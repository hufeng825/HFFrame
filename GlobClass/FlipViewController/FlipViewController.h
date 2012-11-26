//
//  FlipViewController.h
//  HFFrame
//
//  Created by jason on 12-11-26.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFBaseViewController.h"
@class FlipViewController;
@protocol FlipViewControllerDelegate <NSObject>
@optional
 -(void)FlipViewControllerClose:(FlipViewController *)flipViewController;
@end


@interface FlipViewController : HFBaseViewController
@property (nonatomic,assign) id<FlipViewControllerDelegate>delegate;
@end
