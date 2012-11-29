//
//  HFScrollViewViewController.h
//  HFFrame
//
//  Created by jason on 12-11-24.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "CycleScrollView.h"
#import "HFBaseViewController.h"

@interface HFScrollViewViewController : HFBaseViewController<CycleScrollViewDelegate>
{
}
@property(nonatomic,retain)  CycleScrollView * cycleScrollView;
@property(nonatomic,retain)	 NSMutableArray *picArray;
@end
