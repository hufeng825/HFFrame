//
//  FlipCAlayer.m
//  HFFrame
//
//  Created by jason on 12-11-26.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "FlipCAlayer.h"

@implementation FlipCAlayer
@synthesize image;
- (void)drawInContext:(CGContextRef)ctx
{
    [super drawInContext:ctx];
    // self.backgroundColor = [UIColor redColor].CGColor;
	UIGraphicsPushContext(ctx);
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10.0];
	CGContextSaveGState(ctx);
	CGContextAddPath(ctx, path.CGPath);
	CGContextClip(ctx);
	[image drawInRect:self.bounds];
	CGContextRestoreGState(ctx);
	UIGraphicsPopContext();
}
- (void)setImage:(UIImage *)inImage
{
    if (image != inImage)
    {
        image = [inImage retain];
    }
	[self setNeedsDisplay];
}

- (UIImage *)image
{
	return image;
}
- (void)dealloc
{
    RELEASE_SAFELY(image);
    [super dealloc];
}

@end
