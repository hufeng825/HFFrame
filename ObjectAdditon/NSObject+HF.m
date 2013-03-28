//
//  NSObject+HF.m
//  HFFrame
//
//  Created by jason on 13-3-28.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "NSObject+HF.h"
#import <objc/runtime.h>
@implementation NSObject (HF)

+ (id)object{
    return [[[[self class] alloc] init] autorelease];
}

+ (id)objectWithDataDic:(NSDictionary*)data{
    
    return [[[[self class] alloc] initWithDataDic:data] autorelease];
}

-(id)initWithDataDic:(NSDictionary*)data
{
	if ([self init])
    {
		[self setAttributes:data];
	}
	return self;
}

-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName
{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}

- (NSString *)customDescription
{
	return nil;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSString *)description
{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			if (valueObj) {
				[attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];
			}else {
				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];
			}
			
		}
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 ) {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}else {
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
	
	return desc;
}
#pragma clang diagnostic pop

-(void)setAttributes:(NSDictionary*)dataDic
{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self getSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = attrMapDic[attributeName];
            if ([dataDic[dataDicKey] isKindOfClass:[NSNull class]]) {
                
                [self performSelectorOnMainThread:sel
                                       withObject:nil
                                    waitUntilDone:[NSThread isMainThread]];
            }else{
                
                [self performSelectorOnMainThread:sel
                                       withObject:dataDic[dataDicKey]
                                    waitUntilDone:[NSThread isMainThread]];
            }
		}
	}
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if( [self  init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
			SEL sel = [self getSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel]) {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
    
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
    while ((attributeName = [keyEnum nextObject])) {
        
        SEL getSel = NSSelectorFromString(attributeName);
		
        if ([self respondsToSelector:getSel]) {
            
            NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
				[encoder encodeObject:valueObj forKey:attributeName];
			}
		}
	}
}

- (NSData*)getArchivedData
{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}


@end
