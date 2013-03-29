//
//  HFtest.m
//  HFFrame
//
//  Created by jason on 12-12-4.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFtest.h"
#import "Array.h"
#import "NSString+Additions.h"
#import "DataCacheManager.h"



@implementation HFtest

-(void)testDateCacheManagerGetKey
{
    GHTestLog(@"%@",[[DataCacheManager sharedDataCacheManager] getCachedObjectByKey:@"test"]);
}
-(void)testDateCacheManagerSave
{
    [[DataCacheManager sharedDataCacheManager] addObject:@"value" forKey:@"test"];
    GHTestLog(@"%@",[[DataCacheManager sharedDataCacheManager] getCachedObjectByKey:@"test"]);
}

-(void)testDateCacheManagerRemove
{
    [[DataCacheManager sharedDataCacheManager] removeObjectInCacheByKey:@"test"];
    GHTestLog(@"%@",[[DataCacheManager sharedDataCacheManager] getCachedObjectByKey:@"test"]);
}
-(void)testString
{
       //arrary 数组去重复
        NSArray *array = [NSArray arrayWithObjects:@"1",@"1",@"2",@"3",@"4",nil];
        GHTestLog(@"去重格式前：%@",array);
        GHTestLog(@"去重格式后：%@",[array uniqueMembers]);
//    GHAssertNULL(str,nil);
//    NSString *str1 = @"hufeng";
//    GHAssertEqualObjects(str, str1, @"dddddd%@",str1);

}



-(void)testValidateTel
{
    NSString *str = @"03123405871";
    GHTestLog(@"%d",[str validateCellPhone]);
}
-(void)testGetIpAddress
{
    NSString *ipStr = [NSString getIPAddress];
    GHTestLog(@"当前ip：%@",ipStr);
}

-(void)testGotChineseCount
{
    NSString *text = @"i'm a 苹果。...";
    GHTestLog(@"%@ 含有的全角支付个数 %d",text,[text gotChineseCount]);
    NSString *text1 = @"i'm a ...";
    GHTestLog(@"%@ 含有的全角支付个数 %d",text1,[text1 gotChineseCount]);
}
- (void)testSimpleFail

{
    GHTestLog(@"格式前dddddd");
//    GHAssertTrue(NO, nil);
    
}

-(void)testMutableArray
{
    NSMutableArray *array = [NSMutableArray array];
    [array  pushObject:@"a"];
    GHTestLog(@"push a 后：%@",array);
    [array  pushObjects:@"b",@"c",@"e",@"d",nil];
    GHTestLog(@"push b c e d 后：%@",array);
    [array moveObjectFromIndex:4 toIndex:5];

}


@end
