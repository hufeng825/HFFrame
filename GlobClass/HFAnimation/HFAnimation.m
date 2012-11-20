//
// Created by jason on 12-11-20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HFAnimation.h"
#import "QuartzCore/QuartzCore.h"

@implementation HFAnimation
//!!!翻转 从左往右
+(void) animationFlipFromLeft:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

//!!!翻转 从右往左
+(void) animationFlipFromRight:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

 //!!! 翘脚落下
+(void) animationCurViewDown:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}
//!!!翘脚翻起
+(void) animationCurViewUp:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:view cache:YES];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView commitAnimations];
}

 //!!! 爆炸
+(void) animationExplosion:(id)sender
{
    UIView *view = (UIView*)sender;
    CGAffineTransform scale = CGAffineTransformMakeScale(5.0f, 5.0f);
    CGAffineTransform unScale = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView animateWithDuration:0.3 animations:^{
        [view setAlpha:0.0f];
        [view setTransform:scale];
    } completion:^(BOOL finished){
        [view setAlpha:1.0f];
        [view setTransform:unScale];
    }];
}

//!!! 晃动提醒
+ (void)animationShake:(id)sender
{
    UIView *view = (UIView*)sender;
    CGFloat t = 2.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    view.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:FLT_MAX];
        view.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

+(void )animationMovepoint:(id)sender point:(CGPoint )point //点移动
{
    UIView *view = (UIView*)sender;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = .5;
    animation.toValue=[NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"transform.scale"];
}


+(void)removeAllAnimation:(id)sender;
{
    UIView *view = (UIView*)sender;
    [UIView setAnimationsEnabled:YES];
    [view.layer removeAllAnimations];
}


//!!! 隐藏动画
+(void)animationHidden:(id)sender
{
    UIView *view = (UIView*)sender;
    [UIView animateWithDuration:1 animations:^{
        [view setAlpha:0.0f];
    } completion:^(BOOL finished){
        [view setHidden:YES];
        [view setAlpha:1];
    }];
}

//!!! 隐藏动画
+(void)animationShow:(id)sender
{
    UIView *view = (UIView*)sender;
    [view setAlpha:0];
    [view setHidden:NO];
    [UIView animateWithDuration:1 animations:^{
        [view setAlpha:1.0f];
    } completion:^(BOOL finished){
        [view setAlpha:1];
    }];
}


+(void)animationHeartbeat:(id)sender
{
    float bigSize = 1.1;
    UIView *view = (UIView*)sender;

    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = .5;
    pulseAnimation.toValue = [NSNumber numberWithFloat:bigSize];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    [view.layer addAnimation:pulseAnimation forKey:@"transform.scale"];
};



+(void)palySound:(NSString*)soundAct
{
    NSString *path = [NSString stringWithFormat:@"%@%@",
                                                [[NSBundle mainBundle]resourcePath],
                                                soundAct];
    //	NSString *url = [NSString stringWithFormat:@"%@%@",
    //					 [[NSBundle mainBundle]resourceURL],
    //					 soundAct];
    //	NSLog(@"%@ \n %@",path,url);
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:YES];
    AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    AudioServicesPlayAlertSound(soundID);
}


@end