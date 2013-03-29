//
//  DataCacheManager.m
//  
//
//  Created by lian jie on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataCacheManager.h"

@interface DataCacheManager()
- (void)restore;
- (BOOL)isValidKey:(NSString*)key;
- (void)removeKey:(NSString*)key fromKeyArray:(NSMutableArray*)keyArray;
- (void)registerMemoryWarningNotification;
@end

@implementation DataCacheManager

SYNTHESIZE_SINGLETON_FOR_CLASS(DataCacheManager);

#pragma mark - lifecycle methods
- (void)dealloc
{
    [_memoryCacheKeys release];
    _memoryCacheKeys = nil;
    [_memoryCachedObjects release];
    _memoryCachedObjects = nil;
    [_keys release];
    _keys = nil;
    [_cachedObjects release];
    _cachedObjects = nil;
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if(self){
        [self registerMemoryWarningNotification];
        _cachedObjects = [[NSMutableDictionary alloc] init];
        _memoryCacheKeys = [[NSMutableArray alloc] init];
        _memoryCachedObjects = [[NSMutableDictionary alloc] init];
        _keys = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - private methods
- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemoryCache)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];    
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemoryCache)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif        
}

- (void)restore
{
    if ([ [NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_DATA_CACHE_KEYS]) {
        NSArray *keysArray = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:[ [NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_DATA_CACHE_KEYS]];
        _keys = [[NSMutableArray alloc] initWithArray:keysArray];
    }else{
        _keys = [[NSMutableArray alloc] init];
    }
    
    if([ [NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_DATA_CACHE_OBJECTS]){
        NSDictionary *objDic = (NSDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:[ [NSUserDefaults standardUserDefaults] objectForKey:UD_KEY_DATA_CACHE_OBJECTS]];
        _cachedObjects = [[NSMutableDictionary alloc] initWithDictionary:objDic];
    }else{
        _cachedObjects = [[NSMutableDictionary alloc] init];
    }
    _memoryCacheKeys = [[NSMutableArray alloc] init];
    _memoryCachedObjects = [[NSMutableDictionary alloc] init];
}

- (BOOL)isValidKey:(NSString*)key
{
    if (!key || [key length] == 0 || (NSNull*)key == [NSNull null]) {
        return NO;
    }
    return YES;
}

- (void)removeKey:(NSString*)key fromKeyArray:(NSMutableArray*)keyArray
{
    int indexInKeys = NSNotFound;
    for (int i=0;i < [keyArray count];i++) {
        if ([keyArray[i] isEqualToString:key]) {
            indexInKeys = i;
            break;
        }
    }
    if (indexInKeys != NSNotFound) {
        [keyArray removeObjectAtIndex:indexInKeys];
    }
}

#pragma mark - public methods

- (void)doSave
{
    [ [NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_keys] forKey:UD_KEY_DATA_CACHE_KEYS];
    [ [NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:_cachedObjects] forKey:UD_KEY_DATA_CACHE_OBJECTS];
    [ [NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearAllCache
{
    [self clearMemoryCache];
    [_keys removeAllObjects];
    [_cachedObjects removeAllObjects];
    [self doSave];
}

- (void)clearMemoryCache
{
    [_memoryCacheKeys removeAllObjects];
    [_memoryCachedObjects removeAllObjects];
}

- (void)addObject:(NSObject*)obj forKey:(NSString*)key
{
    if (![self isValidKey:key]) {
        return;
    }
    if (!obj || (NSNull*)obj == [NSNull null]) {
        return;
    }
    if ([self hasObjectInCacheByKey:key]) {
        [self removeObjectInCacheByKey:key];
    }
    [_keys addObject:key];
    _cachedObjects[key] = obj;
    [self doSave];
}

- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key
{
    if (![self isValidKey:key]) {
        return;
    }
    if (!obj || (NSNull*)obj == [NSNull null]) {
        return;
    }
    if ([self hasObjectInCacheByKey:key]) {
        [self removeObjectInCacheByKey:key];
    }
    [_memoryCacheKeys addObject:key];
    _memoryCachedObjects[key] = obj;
}

- (NSObject*)getCachedObjectByKey:(NSString*)key
{
    if (![self isValidKey:key]) {
        return nil;
    }
    if (_memoryCachedObjects[key]) {
        return _memoryCachedObjects[key];
    }else{
        return _cachedObjects[key];
    }
}

- (BOOL)hasObjectInCacheByKey:(NSString*)key
{
    return [self getCachedObjectByKey:key] != nil;
}

- (void)removeObjectInCacheByKey:(NSString*)key
{
    if (![self isValidKey:key]) {
        return;
    }
    [_cachedObjects removeObjectForKey:key];
    [self removeKey:key fromKeyArray:_keys];
    [_memoryCachedObjects removeObjectForKey:key];
    [self removeKey:key fromKeyArray:_memoryCacheKeys];
}
@end
