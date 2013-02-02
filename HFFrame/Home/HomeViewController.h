//
//  HomeViewController.h
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBaseViewController.h"
#import "FlipCAlayer.h"


/******用于翻转动画 工程中没用到可注释******/
#import "FlipViewController.h"
#import "FlipCAlayer.h"
#import "UIView+Screenshot.h"
/******        结束翻转动画       ******/


@interface HomeViewController : HFBaseViewController
<
/******用于翻转动画 工程中没用到可注释******/
FlipViewControllerDelegate
/******        结束翻转动画       ******/

>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *context_array;
@property (retain, nonatomic)     NSMutableArray *nameArray;

/******用于翻转动画 工程中没用到可注释******/
@property (nonatomic,retain) FlipCAlayer *flipcalayer;
/******        结束翻转动画       ******/


@end
