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
@implementation HFtest

-(void)testString
{
       //arrary 数组去重复
        NSArray *array = [NSArray arrayWithObjects:@"1",@"1",@"2",@"3",@"4",nil];
        GHTestLog(@"格式前：%@",array);
        GHTestLog(@"格式后：%@",[array uniqueMembers]);
//    GHAssertNULL(str,nil);
//    NSString *str1 = @"hufeng";
//    GHAssertEqualObjects(str, str1, @"dddddd%@",str1);
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




@end
