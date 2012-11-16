//
//  Global_macro.h
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

//判断系统是否大于等于v
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//表示释放对象，并且将该对象赋值为nil
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

// Release a CoreFoundation object safely.检测对象是否为nil，如果不为nil释放对象，最后赋值为nil。
#define RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }


BOOL TTIsStringWithAnyText(id object) ;
