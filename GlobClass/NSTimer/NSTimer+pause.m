//
//  NSTimer+pause.m
//  HFFrame
//
//  Created by jason on 12-12-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "NSTimer+pause.h"

@implementation NSTimer (Extras)
NSDate *pauseStart,*previousFireDate;
-(void)pauseTimer{
    pauseStart = [[NSDate dateWithTimeIntervalSinceNow:0] retain];
    
    previousFireDate = [[self fireDate] retain];
    
    [self setFireDate:[NSDate distantFuture]];
}
-(void)resumeTimer{
    float pauseTime = -1*[pauseStart timeIntervalSinceNow];
    
    [self setFireDate:[previousFireDate initWithTimeInterval:pauseTime sinceDate:previousFireDate]];
    
    [pauseStart release];
    
    [previousFireDate release];
    
}
- (void)dealloc
{
    pauseStart = nil;
    previousFireDate = nil;
    [super dealloc];
}
@end
