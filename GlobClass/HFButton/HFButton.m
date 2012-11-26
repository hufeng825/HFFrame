//
//  HFButton.m
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFButton.h"
@implementation HFButton
@synthesize userInfo,index,activeView,tmpTitle;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initStyle];
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
    [self initStyle: UIControlStateHighlighted ]; // used when UIControl isHighlighted is set
    [self initStyle: UIControlStateDisabled];
    [self initStyle: UIControlStateSelected];     // flag usable by app (see below)
    [self initStyle: UIControlStateApplication];  // additional flags available for application use
    [self initStyle:UIControlStateReserved];
}
-(void)initUIActivityView
{
    
}
-(void)initStyle :(UIControlState)state
{
    self.tmpTitle=nil;
    if ([self backgroundImageForState:state])
    {
        UIImage *img = [self backgroundImageForState:state];
        if ( [img respondsToSelector:        NSSelectorFromString(@"resizableImageWithCapInsets:resizingMode:")])
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

-(void)beginWarningAnimation
{
    UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction|
        UIViewAnimationOptionRepeat|
        UIViewAnimationOptionAutoreverse
    ;
    
    [UIView animateWithDuration:1 delay:0.0 options:options animations:^
     {
         self.alpha = .6;
         
     } completion:nil];

}
-(void)stopWarningAnimation
{
    [UIView animateWithDuration:1 animations:^
     {
         self.alpha = 1;
         
     } completion:nil];

}

-(void)setUserInfo:(id)_userInfo
{
    if (userInfo != _userInfo )
    {
        userInfo = [_userInfo copy];
    }
}

-(void)beginActivity:(NSString*)title postion:(ActionPostionOnBt)postion
{
    if (!activeView)
    {
        activeView  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
        activeView.center= CGPointMake(10, self.height/2);
        [self addSubview:activeView];
    }
    self.tmpTitle = self.titleLabel.text;
    [self setTitle:title forState:UIControlStateDisabled];
    switch (postion) {
        case ActiveLeftOnBt:
            activeView.left = 10;
            break;
        case ActiveRightOnBt: activeView.right = self.width-10;
            break;
        case ActiveCenterOnBt: activeView.left = self.width/2-activeView.width/2;
        default:
            break;
    }
    [self setAlpha:.8];
    [self setEnabled:NO];
    [activeView startAnimating];
}
-(void)stopActivity
{
    [activeView stopAnimating];
    [self setTitle:tmpTitle forState:UIControlStateDisabled];
    [self setAlpha:1];
}


-(id)userInfo
{
    return userInfo ;
}
- (void)dealloc
{
    RELEASE_SAFELY(activeView);
    if (tmpTitle) {
        RELEASE_SAFELY(tmpTitle);
    }
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
