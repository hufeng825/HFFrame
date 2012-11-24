//
//  HFButton.h
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ActiveLeftOnBt,
    ActiveRightOnBt,
    ActiveCenterOnBt
}ActionPostionOnBt;

@interface HFButton : UIButton
@property (nonatomic,retain)UIActivityIndicatorView *activeView;
@property(nonatomic,copy)id userInfo;
@property(nonatomic,assign) int index;
@property(nonatomic,retain)NSString *tmpTitle;
-(void)beginWarningAnimation;
-(void)stopWarningAnimation;
-(void)beginActivity:(NSString*)title postion:(ActionPostionOnBt)postion;
-(void)stopActivity;
@end
