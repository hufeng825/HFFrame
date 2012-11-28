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
+ (HFLoadingView *)showLoadingViewAddedTo:(UIView *)view;
+ (void)hideLoadingViewForView:(UIView *)view;
@end
