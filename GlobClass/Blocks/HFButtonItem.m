//
//  RIButtonItem.m
//  Shibui
//
//  Created by jason on 1/12/12.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "HFButtonItem.h"

@implementation HFButtonItem
@synthesize label;
@synthesize action;

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    id newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

@end

