//
//  Global_macro.h
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFStyle.h"

#import "SynthesizeSingleton.h"
#import "NSDictionary_HFDictionary.h"
#import "NSString+Additions.h"
#import "UIViewAdditions.h"
#import "UIImage+Extensions.h"
#import "NSObject+HF.h"
#import "Array.h"

#define DATA_ENV [DataEnvironment sharedDataEnvironment]
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//#ifdef QA
# define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

//#else
//# define NSLog(...){};
//#endif

//判断系统是否大于等于v
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//表示释放对象，并且将该对象赋值为nil
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

// Release a CoreFoundation object safely.检测对象是否为nil，如果不为nil释放对象，最后赋值为nil。
#define RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }

#define HFAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//判断是否越狱
#define IS_JailBreak system("ls") == 0 ? YES:NO

//判断是否是iphone5
#define Is_IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//机器语言
#define HFApplicationLanguage [[NSUserDefaults standardUserDefaults]\
       objectForKey:@"AppleLanguages"]\
	   objectAtIndex:0];

//ios版本
#define IOSVersion [[[UIDevice currentDevice] systemVersion] floatValue];

#define HFAlert(fmt, ...) \
    {\
      UIAlertView *alert1 = [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:fmt,##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil] autorelease];\
        [alert1 show]; \
    }

#define HFAlert_T_M_BT(t,m,bt) \
    {\
        UIAlertView *alert1 = [[[UIAlertView alloc] initWithTitle:t message:m delegate:nil cancelButtonTitle:bt otherButtonTitles:nil] autorelease];[alert1 show];\
    }


void ShowInfo( id formatstring,...);

BOOL TTIsStringWithAnyText(id object) ;
