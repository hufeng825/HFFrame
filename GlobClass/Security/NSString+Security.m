//
//  NSString+Security.m
//  Pingan
//
//  Created by Zheng Yue on 11-4-26.
//  Copyright 2011 Magus. All rights reserved.
//

#import "NSString+Security.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Security)

//-----------------------------------------------------------------------------------
// base64编码用的查表
//-----------------------------------------------------------------------------------
static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

//-----------------------------------------------------------------------------------
// 对一个二进制数组进行3DES加密或者解密，使用key做为密钥，返回加密或者解密后的二进制结果
// 3DES算法要求密钥是24字节长，这里要求一个24个字符的字符串做为参数
//-----------------------------------------------------------------------------------
+ (NSData *) doCipherWithData:(NSData*)data key:(NSString*)key operation:(CCOperation)encryptOrDecrypt
{
  const void * dataIn;
  size_t dataInLength;
  
  dataInLength = [data length];
  dataIn = [data bytes];
  
  CCCryptorStatus ccStatus;
  uint8_t * dataOut = NULL;
  size_t dataOutAvailable = 0;
  size_t dataOutMoved = 0;
  // uint8_t ivkCCBlockSize3DES;
  
  dataOutAvailable = (dataInLength + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
  
  dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
  memset((void *)dataOut, 0x0, dataOutAvailable);
  
  uint8_t iv[kCCBlockSize3DES];    
  memset((void *) iv, 0x0, (size_t) sizeof(iv));  
  
  const void * vkey = (const void *)[key UTF8String];
  
  ccStatus = CCCrypt(encryptOrDecrypt,
                     kCCAlgorithm3DES,
                     kCCOptionPKCS7Padding,
                     vkey, // 24字节的key
                     kCCKeySize3DES,
                     iv, 
                     dataIn, //plainText,
                     dataInLength,
                     (void *)dataOut,
                     dataOutAvailable,
                     &dataOutMoved);
  
  if (ccStatus != kCCSuccess) NSLog(@"cryptor error: ccStatus=%d", ccStatus);
  
  return [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
}


//-----------------------------------------------------------------------------------
// 对一个字符串进行加密，返回base64编码后的结果
//-----------------------------------------------------------------------------------
- (NSString*) encryptWithKey:(NSString*)key
{
  NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
  NSData * dataout = [NSString doCipherWithData:data key:key operation:kCCEncrypt];
  return [NSString encodeBase64WithData:dataout];
}

//-----------------------------------------------------------------------------------
// 对一个base64编码的字符串进行解密
//-----------------------------------------------------------------------------------
- (NSString*) decryptBase64WithKey:(NSString*)key
{
  NSData *datain = [NSString decodeBase64WithString:self];
  NSData *dataout = [NSString doCipherWithData:datain key:key operation:kCCDecrypt];
  return [[[NSString alloc] initWithData:dataout encoding:NSUTF8StringEncoding] autorelease];
}


//-----------------------------------------------------------------------------------
// 返回base64编码结果
//-----------------------------------------------------------------------------------
- (NSString *)base64String{
	return [NSString encodeBase64WithData:[self dataUsingEncoding:NSUTF8StringEncoding]];
}

//-----------------------------------------------------------------------------------
// 对二进制数据进行base64编码
//-----------------------------------------------------------------------------------
+ (NSString *)encodeBase64WithData:(NSData *)objData {
	const unsigned char * objRawData = [objData bytes];
	char * objPointer;
	char * strResult;
  
	// Get the Raw Data length and ensure we actually have data
	int intLength = [objData length];
	if (intLength == 0) return nil;
  
	// Setup the String-based Result placeholder and pointer within that placeholder
	strResult = (char *)calloc(((intLength + 2) / 3) * 4 + 1, sizeof(char));
	objPointer = strResult;
	
	// Iterate through everything
	while (intLength > 2) { // keep going until we have less than 24 bits
		*objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
		*objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
		*objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
		*objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
		
		// we just handled 3 octets (24 bits) of data
		objRawData += 3;
		intLength -= 3; 
	}
  
	// now deal with the tail end of things
	if (intLength != 0) {
		*objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
		if (intLength > 1) {
			*objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
			*objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
			*objPointer++ = '=';
		} else {
			*objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
			*objPointer++ = '=';
			*objPointer++ = '=';
		}
	}
  
	// Terminate the string-based result
	*objPointer = '\0';
  
	// Return the results as an NSString object
	NSString *result = [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
  free(strResult);
  return result;
}

//-----------------------------------------------------------------------------------
// 把base64字符串解码成二进制数据
//-----------------------------------------------------------------------------------
+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
	const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
	int intLength = strlen(objPointer);
	int intCurrent;
	int i = 0, j = 0, k;
  
	unsigned char * objResult;
	objResult = calloc(intLength, sizeof(char));
  
	// Run through the whole string, converting as we go
	while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
		if (intCurrent == '=') {
			if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
				// the padding character is invalid at this point -- so this entire string is invalid
				free(objResult);
				return nil;
			}
			continue;
		}
    
		intCurrent = _base64DecodingTable[intCurrent];
		if (intCurrent == -1) {
			// we're at a whitespace -- simply skip over
			continue;
		} else if (intCurrent == -2) {
			// we're at an invalid character
			free(objResult);
			return nil;
		}
    
		switch (i % 4) {
			case 0:
				objResult[j] = intCurrent << 2;
				break;
        
			case 1:
				objResult[j++] |= intCurrent >> 4;
				objResult[j] = (intCurrent & 0x0f) << 4;
				break;
        
			case 2:
				objResult[j++] |= intCurrent >>2;
				objResult[j] = (intCurrent & 0x03) << 6;
				break;
        
			case 3:
				objResult[j++] |= intCurrent;
				break;
		}
		i++;
	}
  
	// mop things up if we ended on a boundary
	k = j;
	if (intCurrent == '=') {
		switch (i % 4) {
			case 1:
				// Invalid state
				free(objResult);
				return nil;
        
			case 2:
				k++;
				// flow through
			case 3:
				objResult[k] = 0;
		}
	}
  
	// Cleanup and setup the return NSData
	NSData * objData = [[[NSData alloc] initWithBytes:objResult length:j] autorelease];
	free(objResult);
	return objData;
}

@end
