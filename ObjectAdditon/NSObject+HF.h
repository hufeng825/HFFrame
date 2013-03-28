//
//  NSObject+HF.h
//  HFFrame
//
//  Created by jason on 13-3-28.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HF)
+ (id)object;
+ (id)objectWithDataDic:(NSDictionary*)data;
- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

@end
