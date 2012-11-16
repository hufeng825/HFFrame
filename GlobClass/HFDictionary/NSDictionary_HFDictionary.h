//
//  NSDictionary_HFDictionary.h
//  HFFrame
//
//  Created by jason on 12-11-16.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HFFrame)
// jason: return an empty string if the value is NSNull or not a string.
- (NSString *)stringForKey:(id)key;

// jason: return nil if the object is NSNull or not a NSDictionary
- (NSDictionary *)dictionaryForKey:(id)key;

// jason: return nil if the object is null or not a NSArray.
- (NSArray *)arrayForKey:(id)key;
@end
