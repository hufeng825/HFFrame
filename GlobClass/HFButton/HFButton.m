//
//  HFButton.m
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFButton.h"

@implementation HFButton
@synthesize userInfo,index;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initStyle];
    }
    return self;
}
///!!! 设置button 外观
-(void)initStyle
{
    [self initStyle: UIControlStateNormal];
    [self initStyle: UIControlStateHighlighted ];                  // used when UIControl isHighlighted is set
    [self initStyle: UIControlStateDisabled];
    [self initStyle: UIControlStateSelected];                   // flag usable by app (see below)
    [self initStyle: UIControlStateApplication];              // additional flags available for application use
    [self initStyle:UIControlStateReserved];
}

-(void)initStyle :(UIControlState)state
{
    if ([self backgroundImageForState:state])
    {
        UIImage *img = [self backgroundImageForState:state];
        if ( [img respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)])
        {
            [self setBackgroundImage:
             [img resizableImageWithCapInsets:UIEdgeInsetsMake(4,2,4,2) resizingMode:UIImageResizingModeStretch]
                            forState:state];
        }
        else
        {
            [self setBackgroundImage:
             [img stretchableImageWithLeftCapWidth:4 topCapHeight:4]
                            forState:state];
        }
    }
}



-(void)setUserInfo:(id)_userInfo
{
    if (userInfo != _userInfo )
    {
        userInfo = [_userInfo copy];
    }
}
-(id)userInfo
{
    return userInfo ;
}
- (void)dealloc
{
    [userInfo release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
