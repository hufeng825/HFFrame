//
//  HFInfoView.m
//  HFFrame
//
//  Created by jason on 12-12-16.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFInfoView.h"
#import "SynthesizeSingleton.h"
#import "QuartzCore/QuartzCore.h"


@implementation HFInfoView
@synthesize view;

SYNTHESIZE_SINGLETON_FOR_CLASS(HFInfoView);

+(HFInfoView *)sharedInstance
{
    BOOL mustInitialize = !sharedHFInfoView;
    HFInfoView *v = [HFInfoView sharedHFInfoView];
    if (mustInitialize)
    {
        v.view = [[[NSBundle mainBundle] loadNibNamed:@"HFInfoView" owner:self options:nil]objectAtIndex:0];
    }
    return v;
}


-(void)showInfo:(NSString *)infoStr
{
//    [view setAlpha:0];
    
    UILabel * textlabel = [[HFInfoView sharedInstance] textLable];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    textlabel.text = infoStr;
    
    CGSize size = [infoStr withWithFont:textlabel.font];
    [textlabel setWidth:size.width];
    [textlabel setHeight:size.height];
    
    [view setWidth:size.width+3];
    [view setHeight:size.height+3];
    
    float x = (window.width - view.width)/2.0;
    float y = window.height - view.height -2;
    [view setTop:y];
    [view setLeft:x];
    
    //使文字居中
    [textlabel setCenter:CGPointMake(view.width/2,view.height/2)];
    [window addSubview:view];
    [view.layer removeAllAnimations];

    CABasicAnimation *scalAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalAnimation.fromValue = [NSNumber numberWithFloat:0.3];
    scalAnimation.toValue = [NSNumber numberWithFloat:1];
    scalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //透明动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.f];
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:scalAnimation,opacityAnimation, nil];
    animGroup.duration = 0.5;
    animGroup.delegate = self;
    [view.layer addAnimation:animGroup forKey:nil];

    int64_t delayInSeconds = 2.0;

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       //缩放动画
                       CABasicAnimation *scalAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                       scalAni.fromValue = [NSNumber numberWithFloat:1];
                       scalAni.toValue = [NSNumber numberWithFloat:0.3];
                       scalAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                       //透明动画
                       CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
                       opacityAni.fromValue = [NSNumber numberWithFloat:1.0];
                       opacityAni.toValue = [NSNumber numberWithFloat:0.f];
                       opacityAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                       CAAnimationGroup *animGroup_ = [CAAnimationGroup animation];
                       animGroup_.animations = [NSArray arrayWithObjects:scalAni,opacityAni,nil];
                       animGroup_.duration = .5;
                       animGroup_.removedOnCompletion = NO;
                       animGroup_.fillMode = kCAFillModeForwards;
                       [view.layer addAnimation:animGroup_ forKey:nil];
                   });
    

       

/*
    //设置显示动画
    [UIView animateWithDuration:1.f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [UIView setAnimationRepeatCount:repeatCount];
        [view setAlpha:1.f];
        [view setWidth:size.width+3];
        [view setHeight:size.height+3];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1.f delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [view setAlpha:0.f];
                [view setWidth:0];
                [view setHeight:0];
            } completion:NULL];
        }
    }];*/
}

-(void)hideView
{
    
}

-(UILabel*)textLable
{
    return(UILabel *)[[HFInfoView sharedHFInfoView].view viewWithTag:10];
}

-(UIImageView*)imageView
{
    return(UIImageView *)[[HFInfoView sharedHFInfoView].view viewWithTag:11];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc
{
    [view release];
    [super dealloc];
}

@end
