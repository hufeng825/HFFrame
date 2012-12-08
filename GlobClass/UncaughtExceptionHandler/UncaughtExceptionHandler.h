//
//  UncaughtExceptionHandler.h
//  UncaughtExceptions
//  creat by jason


#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject{
	BOOL dismissed;
}

@end
void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void);
