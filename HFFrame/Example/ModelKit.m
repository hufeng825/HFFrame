//
//  ModelKit.m
//  HFFrame
//
//  Created by jason on 13-1-30.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "ModelKit.h"
@implementation ModelKit
@end

/*-------------------------------------------------*/
@implementation StateModel
@synthesize respCode,respMsg;
- (void)dealloc
{
    [respCode release];
    [respMsg release];
    [super dealloc];
}
@end

/*-------------------------------------------------*/
@implementation ContextModel
@synthesize movieList,state;
-(void) dealloc
{
    [state release];
    [movieList release];
    [super dealloc];
}

@end

/*-------------------------------------------------*/
@implementation DictModel
@synthesize name,array;
- (void)dealloc
{
    [name release];
    [array release];
    [super dealloc];
}

@end

/*-------------------------------------------------*/
@implementation MovieModel
@synthesize body,pics,name,movid,length,hasplan,trailor,director,type,url,dict;
- (void)dealloc
{
    [body release];
    [pics release];
    [name release];
    [movid release];
    [length release];
    [hasplan release];
    [trailor release];
    [director release];
    [type release];
    [url release];
    [dict release];
    [super dealloc];
}

@end