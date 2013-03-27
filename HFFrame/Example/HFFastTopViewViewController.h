//
//  HFFastTopViewViewController.h
//  HFFrame
//
//  Created by jason on 13-3-27.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBaseViewController.h"
@interface HFFastTopViewViewController : HFBaseViewController
{
    CGPoint lastOffset;
    NSTimeInterval lastOffsetCapture;

}
@property (retain, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end
