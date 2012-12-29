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
@synthesize timer;
#define AnimationInterval .5f
#define ShowInterval 1.5f

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

    UILabel * textlabel = [[HFInfoView sharedInstance] textLable];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView  = [[HFInfoView sharedHFInfoView]backgroundView];
    textlabel.text = infoStr;
//    CGSize size = [infoStr withWithFont:textlabel.font];
    CGSize size = [infoStr sizeWithFont:textlabel.font constrainedToSize:CGSizeMake(200.f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];

    [textlabel setWidth:size.width];
    [textlabel setHeight:size.height];
    [view setWidth:size.width+8];
    [view setHeight:size.height+8];
    float x = (window.width - view.width)/2.0;
    float y = (window.height - view.height)/2.0 ;
    [view setTop:y];
    [view setLeft:x];
    
    //使文字居中
    [textlabel setCenter:CGPointMake(view.width/2,view.height/2)];
    
    
    //设置背景
    backgroundView.layer.cornerRadius = 8.f;
    backgroundView.layer.borderWidth = 0;
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
    backgroundView.layer.borderColor = [[UIColor blackColor] CGColor];
    [backgroundView setFrame: CGRectMake(0, 0, view.width, view.height)];
    [window addSubview:view];
   [ view.layer removeAnimationForKey:@"hideAnimat"] ;
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
    animGroup.duration = AnimationInterval;
    animGroup.removedOnCompletion = NO;
   animGroup.delegate = self;
    animGroup.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animGroup forKey:nil];

//    if (isFinsh == NO)
//    {
//        return;
//    }
//    isFinsh = NO;
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_current_queue(), ^(void)
//                   {
//                       //!!! 词句最好放在动画结束的delegate 中 但是 不知道为何 设置好delegate后 无法调用  很是奇怪。
//                       isFinsh = YES;
//                       
//                   });

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([timer isValid])
    {
        [timer invalidate];
        timer = nil;
    }
   self.timer = [ NSTimer  timerWithTimeInterval:ShowInterval target:self selector:@selector(timerFinsh:) userInfo:nil repeats:NO];
   NSRunLoop *main=[NSRunLoop currentRunLoop];
    [main addTimer:timer forMode:NSDefaultRunLoopMode];
    return;

    /*另外一种写法
     NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(timerFinsh:)];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sgn];
    [inv setTarget: self];
    [inv setSelector:@selector(timerFinsh:)];
    
    self.timer = [NSTimer timerWithTimeInterval: AnimationInterval
                                     invocation:inv
                                        repeats:NO];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer: timer forMode: NSDefaultRunLoopMode];

    return;
     */

}

-(void)timerFinsh:(NSTimer *)timer
{
       //缩放动画
       CABasicAnimation *scalAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
       scalAni.fromValue = [NSNumber numberWithFloat:1];
       scalAni.toValue = [NSNumber numberWithFloat:.8];
       scalAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //透明动画
       CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
       opacityAni.fromValue = [NSNumber numberWithFloat:1.0];
       opacityAni.toValue = [NSNumber numberWithFloat:0.f];
       opacityAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
      CAAnimationGroup *animGroup_ = [CAAnimationGroup animation];
       animGroup_.animations = [NSArray arrayWithObjects:scalAni,opacityAni,nil];
       animGroup_.duration = AnimationInterval;
       animGroup_.removedOnCompletion = NO;
       animGroup_.fillMode = kCAFillModeForwards;
       [view.layer addAnimation:animGroup_ forKey:@"hideAnimat"];
}


-(UILabel*)textLable
{
    return(UILabel *)[[HFInfoView sharedHFInfoView].view viewWithTag:13];
}

-(UIView*)backgroundView
{
    return(UIView *)[[HFInfoView sharedHFInfoView].view viewWithTag:12];
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
    [timer release];
    [view release];
    [super dealloc];
}

@end
