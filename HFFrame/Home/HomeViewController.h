//
//  HomeViewController.h
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBaseViewController.h"
#import "iFlyMSC/IFlyRecognizeControl.h"
#import "iFlyMSC/IFlySynthesizerControl.h"
@interface HomeViewController : HFBaseViewController
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *context_array;
@end
