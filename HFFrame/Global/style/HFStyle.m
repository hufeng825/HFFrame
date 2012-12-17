//
//  HFStyle.m
//  HFFrame
//
//  Created by jason on 12-11-18.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFStyle.h"
#import "UIColor+Hex.h"
@implementation HFStyle

@end
/*
 设置uitabr 样式
 此方法需要设置了viewControllers 后设置了后调用
 tabBar.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nil];
 */


//-------------------------------------------------------
// 因为iOS 5以后，UINavigationBar的drawRect方法不再被调用，
// 除非是继承的子类。所以这里，继承一个子类，然后让UINavigationBar
// 返回这个子类对象。这样修改最简单
//-------------------------------------------------------

@implementation HFNavigationBar
- (void)drawRect:(CGRect)rect {
    
}
- (void)dealloc
{
    [super dealloc];
}
@end

//Overide the drawing of the background UINavigationBar
@implementation UINavigationBar (CustomImage)

- (Class)class {
    return NSClassFromString(@"HFNavigationBar");
}

- (void)drawRect:(CGRect)rect {
    UIImage *navBarImage = [UIImage imageNamed:@"navigation@2x.jpg"];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGPoint center=self.center;
    
    CGImageRef cgImage= CGImageCreateWithImageInRect(navBarImage.CGImage, CGRectMake(0, 0, 0, 44));
    CGContextDrawImage(context, CGRectMake(center.x-160-80, 0, 80, self.frame.size.height), cgImage);
    CGContextDrawImage(context, CGRectMake(center.x-160, 0, 320, self.frame.size.height), navBarImage.CGImage);
    CGContextDrawImage(context, CGRectMake(center.x+160, 0, 80, self.frame.size.height), cgImage);
    RELEASE_CF_SAFELY(cgImage);
    
}

//让title居中 否则会根据lefttile 和righttitle的 存在与否进行变化
-(void)layoutSubviews {
    [super layoutSubviews];
    for (id view in self.subviews) {
        if ([view isMemberOfClass:NSClassFromString(@"UILabel")]) {
            // Do whatever you want with view here
			[view setFrame:CGRectMake(0 ,0, 320, 44) ];
        }
    }
}

@end

//-------------------------------------------------------
//
// 自定义BarButtonItem
//
//-------------------------------------------------------

@implementation CustomBarButtonItem

- (Class)class {
    return NSClassFromString(@"CustomBarButtonItem");
}

-(UIBarButtonItem *) initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    barButton.titleLabel.font = font;
    //    barButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
	barButton.adjustsImageWhenHighlighted = NO;
	barButton.showsTouchWhenHighlighted = YES;
    [barButton setBackgroundImage:image forState:UIControlStateNormal];
    //	[barButton setBackgroundImage:image forState:UIControlStateHighlighted];
    //	[barButton setImage:[UIImage imageNamed:@"click.png"] forState:UIControlStateHighlighted];
    [barButton setTitle:title forState:UIControlStateHighlighted];
	[barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [barButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [barButton setTitleShadowColor:[UIColor colorWithHex:0xffffff]forState:UIControlStateNormal];
    //    [barButton setTitleShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    
	if (image ==nil) {
		if ([title length] <= 2) {
			barButton.frame = CGRectMake(0, 0, 45, 30);
		}
		else if ([title lengthToInt] < 4 && [title lengthToInt] > 2)
        {
            barButton.frame = CGRectMake(0, 0, 60, 30);
        }
		else
		{
			barButton.frame = CGRectMake(0, 0, 80, 30);
            
		}
	}
    else
        barButton.frame = CGRectMake(0, 0, image.size.width + 15 + [title sizeWithFont:font].width, 30);
    UIImage *img = [[UIImage imageNamed:@"btm_nav.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:3];
	[barButton setBackgroundImage:img
                         forState:UIControlStateNormal];
	
    if (self = [super initWithCustomView:barButton]) {
        self.target = target;
        self.action = action;
		[barButton addTarget:target
                      action:action
            forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

@end


@implementation UIBarButtonItem (CustomBarButtonItem)

+ (UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action {
    return [[[CustomBarButtonItem alloc] initWithImage:image
                                                 title:title
                                                target:target
                                                action:action]autorelease];
}

@end