//
//  NSDictionary_HFDictionary.h
//  HFFrame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "NSDictionary_HFDictionary.h"
NSString * const kEmptyString = @"";

@implementation NSDictionary (HFFrame)

- (NSString *)stringForKey:(id)key
{
    NSString *result = [self objectForKey:key];
    if([result isKindOfClass:[NSString class]])
    {
        return result;
    }
    else if ([result isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%d", [result intValue]];
    }
    else {
        return kEmptyString;
    }
}

// jason: return nil if the object is null or not a NSDictionary.
- (NSDictionary *)dictionaryForKey:(id)key
{
    NSDictionary *result = [self objectForKey:key];
    if([result isKindOfClass:[NSDictionary class]])
    {
        return result;
    }
    else {
        return nil;
    }
}

// jason: return nil if the object is null or not a NSArray.
- (NSArray *)arrayForKey:(id)key
{
    NSArray *result = [self objectForKey:key];
    if([result isKindOfClass:[NSArray class]])
    {
        return result;
    }
    else {
        return nil;
    }
}

@end
