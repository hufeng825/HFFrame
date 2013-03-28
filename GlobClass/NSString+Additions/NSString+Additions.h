//
//  NSString+Additions.h
//  Pluto
//
//  Created by jason on 12-10-21.
//
//

#import <Foundation/Foundation.h>
@interface NSString (HF)

- (NSString*)URLencodeWithEncoding:(NSStringEncoding)stringEncoding;
- (NSString*)URLencodeWithEncodingUTF8;
+ (NSString *)getIPAddress;

+ (NSString*)fenStringWithDecimalNumber:(NSDecimalNumber*)number;
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

-(NSUInteger)lengthToInt;//得到字符串长度 中英文混合情况下
-(NSUInteger)gotChineseCount;//得到字符串中含有的中文和全角支付个数

-(BOOL)validateContainsString:(NSString *)findStr;

-(BOOL)validatePersonCard;
-(BOOL)validateNumberStr;
-(BOOL)validateNameStr;//只准有字母和英文
-(BOOL)validateEmailAddress;
- (BOOL)validateCellPhone;

@end
