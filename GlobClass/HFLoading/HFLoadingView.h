//
//  HFLoading.h
//  HFFrame
//
//  Created by jason on 12-11-28.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFLoadingView : UIView
@property (nonatomic,retain) UIView *customView;
//传入nil 或空字符串 title 用默认字符串
+ (HFLoadingView *)showLoadingViewAddedTo:(UIView *)view title:(NSString*)title;
+ (void)hideLoadingViewForView:(UIView *)view;
@end
