//
//  NSString+Additions.h
//  Pluto
//
//  Created by Zheng Yue on 12-10-21.
//
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
@interface NSString (HF)

- (NSString*)URLencodeWithEncoding:(NSStringEncoding)stringEncoding;
- (NSString*)URLencodeWithEncodingUTF8;

- (CGSize)withWithFont:(UIFont*)font;
- (NSString*)dateStringWithFormat:(NSString*)format;
- (NSString*)ymdString;
- (NSString*)ymdStringWithSeperator:(NSString*)seperator;
- (NSString*)ymString;
- (NSString*)mdString;
- (NSString*)mdStringWithSeperator:(NSString*)seperator;
- (NSString*)hmString;
- (NSString*)nextMonth;
- (NSString*)amountStringWithSymbol:(NSString*)symbol;
+ (NSString*)fenStringWithDecimalNumber:(NSDecimalNumber*)number;


-(BOOL)isContainsString:(NSString *)findStr;
-(int)lengthToInt;//得到字符串长度 中英文混合情况下
-(BOOL)isPersonCard;
-(BOOL)isNumberStr;
-(BOOL)isNameStr;//只准有字母和英文
-(BOOL)isEmailAddress;
@end
