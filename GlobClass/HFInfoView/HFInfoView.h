//
//  HFInfoView.h
//  HFFrame
//
//  Created by jason on 12-12-16.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFInfoView : UIView
@property(nonatomic,retain)UIView *view;
-(void)showInfo:(NSString *)infoStr;
+(HFInfoView *)sharedInstance;
@end
