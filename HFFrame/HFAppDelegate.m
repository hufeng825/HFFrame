//
//  DMAppDelegate.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFAppDelegate.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation HFAppDelegate

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
  
	self.viewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:self.viewController];
	self.window.rootViewController = nv ;
    [self.window makeKeyAndVisible];
    
    UIImageView *splashScreen = [[[UIImageView alloc] initWithFrame:self.window.bounds] autorelease];
    splashScreen.image = [UIImage imageNamed:@"Default"];
    [self.window addSubview:splashScreen];
    [NSThread sleepForTimeInterval:1.0];
    [UIView animateWithDuration:1.0 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
    splashScreen.layer.transform = transform;
    splashScreen.alpha = 0.0;
    } completion:^(BOOL finished) {
        [splashScreen removeFromSuperview];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
