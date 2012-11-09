//
//  UIColor+Hex.m
//  Pluto
//
//  Created by 峰 胡 on 12-6-9.
//  Copyright (c) 2012年 Magus. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0 
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0xffffff alpha:alphaValue];
}

+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0x000000 alpha:alphaValue];
}


+(UIColor*)colorWithred:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
	return  [UIColor colorWithRed:[[ NSNumber numberWithInt:red]floatValue]/255.0f green:[[ NSNumber numberWithInt:green]floatValue]/255.0f blue:[[ NSNumber numberWithInt:blue]floatValue]/255.0f alpha:1.f];
}

+(UIColor*)colorWithred:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(float)alpha_
{
	return  [UIColor colorWithRed:[[ NSNumber numberWithInt:red]floatValue]/255.0f green:[[ NSNumber numberWithInt:green]floatValue]/255.0f blue:[[ NSNumber numberWithInt:blue]floatValue]/255.0f alpha:alpha_];
}
@end
