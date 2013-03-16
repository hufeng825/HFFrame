//
//  UncaughtExceptionHandler.m
//  UncaughtExceptions
//  creat by jason

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString *const CrashReportUrl = @"http://httpbin.org/post";

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler

+ (NSArray *)backtrace
{
	 void* callstack[128];
	 int frames = backtrace(callstack, 128);
	 char **strs = backtrace_symbols(callstack, frames);
	 
	 int i;
	 NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
	 for (
	 	i = UncaughtExceptionHandlerSkipAddressCount;
	 	i < UncaughtExceptionHandlerSkipAddressCount +
			UncaughtExceptionHandlerReportAddressCount;
		i++)
	 {
	 	[backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
	 }
	 free(strs);
	 
	 return backtrace;
}

-(NSString *)getInfoApp
{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* version = [infoDict objectForKey:@"CFBundleVersion"];
    NSString *infoStr = [NSString stringWithFormat:@"appVersion=%@&iosVersion=%@&device=%@",
                         version,[[UIDevice currentDevice] systemVersion],[[UIDevice currentDevice]model]
                         ];
    return infoStr;
}

- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
	if (anIndex == 0)
	{
        candismissed = YES;
	}
}

- (void)validateAndSaveCriticalApplicationData:(NSException *)exception
{
    NSString *urlFormat = CrashReportUrl;
    candismissed = NO;
    NSURL *registrationURL = [NSURL URLWithString:urlFormat];
    
    // Create theregistration request
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc]
                                   
                                   initWithURL:registrationURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"function name=%@", [exception reason]]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"des=%@",
                           [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[self getInfoApp] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    
    // And fireit off
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request
                                   
                                                                delegate:self];
    
    [connection start];
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error description]);
    if (candismissed)
    {
        dismissed = YES;
        candismissed = NO;
    }
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSString *reply  =[ [NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"%@",reply);
    if (candismissed)
    {
        dismissed = YES;
        candismissed = NO;
    }
}




- (void)handleException:(NSException *)exception
{
	[self validateAndSaveCriticalApplicationData :exception];

    
    // TODO: Passthe token to our server
    
    
	UIAlertView *alert =
		[[[UIAlertView alloc]
			initWithTitle:NSLocalizedString(@"友情提示", nil)
			message:[NSString stringWithFormat:NSLocalizedString(
				@"点击继续程序可能不稳定\n\n"
				@"Debug details follow:\n%@\n%@", nil),
				[exception reason],
				[[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey]]
			delegate:self
			cancelButtonTitle:NSLocalizedString(@"退出", nil)
			otherButtonTitles:NSLocalizedString(@"继续", nil), nil]
		autorelease];
	[alert show];
	
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
	
	while (!dismissed)
	{
		for (NSString *mode in (NSArray *)allModes)
		{
			CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
		}
	}
	
	CFRelease(allModes);

	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
	
	if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
	{
		kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
	}
	else
	{
		[exception raise];
	}
}

@end



void HandleException(NSException *exception)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSArray *callStack = [UncaughtExceptionHandler backtrace];
    
	NSMutableDictionary *userInfo =
		[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
	[[[[UncaughtExceptionHandler alloc] init] autorelease]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:[exception name]
				reason:[exception reason]
				userInfo:userInfo]
		waitUntilDone:YES];
}

void SignalHandler(int signal)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSMutableDictionary *userInfo =
		[NSMutableDictionary
			dictionaryWithObject:[NSNumber numberWithInt:signal]
			forKey:UncaughtExceptionHandlerSignalKey];

	NSArray *callStack = [UncaughtExceptionHandler backtrace];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
	[[[[UncaughtExceptionHandler alloc] init] autorelease]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:
			[NSException
				exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
				reason:
					[NSString stringWithFormat:
						NSLocalizedString(@"Signal %d was raised.", nil),
						signal]
				userInfo:
					[NSDictionary
						dictionaryWithObject:[NSNumber numberWithInt:signal]
						forKey:UncaughtExceptionHandlerSignalKey]]
		waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler(void)
{
	NSSetUncaughtExceptionHandler(&HandleException);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
}

