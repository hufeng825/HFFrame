//
//  UncaughtExceptionHandler.h
//  UncaughtExceptions
//  creat by jason


#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject{
	BOOL dismissed;
    BOOL candismissed;
}

@end
void HandleException(NSException *exception);
void SignalHandler(int signal);


void InstallUncaughtExceptionHandler(void);
