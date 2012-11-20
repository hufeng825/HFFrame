//
//  HFButton.h
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFButton : UIButton
@property(nonatomic,copy)id userInfo;
@property(nonatomic,assign) int index;
-(void)beginWarningAnimation;
-(void)stopWarningAnimation;
@end
