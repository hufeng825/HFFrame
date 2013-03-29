//
//  HFStyle.h
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UILabel.h>
@interface HFStyle : NSObject
+(void) setUITabBarStyle: (UITabBarController *)tabBar;
@end

@interface HFNavigationBar : UINavigationBar
@end

@interface CustomBarButtonItem : UIBarButtonItem {
    
}

- (UIBarButtonItem *)initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

@end

@interface UIBarButtonItem(CustomBarButtonItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

@end
