/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 add Postitioning by jason 
 
 */

#import "UIViewAdditions.h"

@implementation UIView (KalAdditions)

- (CGFloat)left
{
  return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)right
{
  return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}

- (CGFloat)top
{
  return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)bottom
{
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
  CGRect frame = self.frame;
  frame.origin.y = bottom - frame.size.height;
  self.frame = frame;
}

- (CGFloat)width
{
  return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)height
{
  return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

-(BOOL)hiddenWithAnimation
{
    if (self.alpha==0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)setHiddenWithAnimation:(BOOL)hidden
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30f];
    if (hidden)
    {
        self.alpha =0;
    }
    else
    {
        self.alpha =1;
    }
    [UIView commitAnimations];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


//针对给定的坐标系居中
- (void)centerInRect:(CGRect)rect
{
    //如果参数是小数，则求最大的整数但不大于本身.
    //CGRectGetMidX获取中心点的X轴坐标
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

//针对给定的坐标系纵向居中
- (void)centerVerticallyInRect:(CGRect)rect
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

//针对给定的坐标系横向居中
- (void)centerHorizontallyInRect:(CGRect)rect
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}

//相对父视图居中
- (void)centerInSuperView
{
    [self centerInRect:[[self superview] bounds]];
}
- (void)centerVerticallyInSuperView;
{
    [self centerVerticallyInRect:[[self superview] bounds]];
}
- (void)centerHorizontallyInSuperView
{
    [self centerHorizontallyInRect:[[self superview] bounds]];
}


- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}
//同一父视图的兄弟视图水平居中
- (void)centerHorizontallyBelow:(UIView *)view;
{
    [self centerHorizontallyBelow:view padding:0];
}

@end
