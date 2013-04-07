//
//  HFDataEnvironment.m
//  HFFrame
//
//  Created by jason on 13-4-7.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFDataEnvironment.h"
#import "SFHFKeychainUtils.h"
#import "DataCacheManager.h"

#define LAST_LOGIN_NAME @"LAST_LOGIN_NAME"
#define LAST_LOGIN_ID_TYPE @"LAST_LOGIN_ID_TYPE"

@interface HFDataEnvironment()
{
    NSString *_analyticsString;
}
@end
@implementation HFDataEnvironment
SYNTHESIZE_SINGLETON_FOR_CLASS(HFDataEnvironment)

#pragma mark - lifecycle methods

- (void)dealloc
{
    [_loginIDTypePickerDataArray release];
    [_publicKey release];
    [_privateKey release];
//    [_fundInfo release];
//    [_currentUser release];
    [_analyticsString release];
	[super dealloc];
}

- (id)init
{
    self = [super init];
	if ( self) {
		[self restore];
        [self registerMemoryWarningNotification];
	}
	return self;
}

-(void)clearNetworkData
{
    [[DataCacheManager sharedDataCacheManager] clearAllCache];
}

#pragma mark - public methods

- (void)clearCacheData
{
    //clear cache data if needed
}

#pragma mark - private methods

- (void)restore
{
//    self.loginIDTypePickerDataArray = @[PADICTIONARY_VALUE_NAME(@"0",@"身份证"),PADICTIONARY_VALUE_NAME(@"1",@"护照"),PADICTIONARY_VALUE_NAME(@"2",@"军官证"),PADICTIONARY_VALUE_NAME(@"3",@"士兵证"),PADICTIONARY_VALUE_NAME(@"4",@"回乡证"),PADICTIONARY_VALUE_NAME(@"5",@"户口本"),PADICTIONARY_VALUE_NAME(@"6",@"外国护照"),PADICTIONARY_VALUE_NAME(@"a",@"警官证"),PADICTIONARY_VALUE_NAME(@"b",@"文职证"),PADICTIONARY_VALUE_NAME(@"TAACCOUNTNO",@"基金账号"),PADICTIONARY_VALUE_NAME(@"7",@"其它")];
}

- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearCacheData)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCacheData)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif
}
#pragma mark - public methods

- (BOOL)isUserLogined
{
//    return (self.currentUser != nil);
}

- (void)logout
{
//    self.currentUser = nil;
    
    [[NSNotificationCenter  defaultCenter] postNotificationName:SUBJECT_USER_LOGOUT object:nil];
}

//- (void)userLogined:(HXUserInformation*)user
//{
//    self.currentUser = user;
//    
//    [[NSNotificationCenter  defaultCenter] postNotificationName:SUBJECT_USER_LOGIN object:nil];
//}
- (NSString*)getAnalyticsPararmString
{
    if (!_analyticsString) {
        NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
        
        // 设备名（设备名＋操作系统版本号）
        NSString *ua = [NSString stringWithFormat:@"%@_",
//                        [[UIDevice currentDevice] platform],
                        [[UIDevice currentDevice] systemVersion]];
        
        // 应用版本号
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        // 产品名称
        NSString *pro = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"FGProdName"];
        //-------------------------------------------------
        // 平台名称
        // 注意：如果想修改平台名称，请去修改Huaxia-Info.plist中的
        // FGDistributionChannel字段的值，请不要来这里改代码！
        // 如果Info.plist中没设，默认是应用商店
        //
        // 平台名称代码包括：
        // 苹果应用商店：APPH
        // 威锋网：WPHONE(IPH)
        // 91助手：91AST(IPH)
        //--------------------------------------------------
        NSString *dist = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"FGDistributionChannel"];
        if(dist == nil)
        {
            dist = @"APPH";
        }
        //      dist = @"91AST";
        // 平台号（就是应用名称＋平台名称+应用版本号）
        NSString *pla = [NSString stringWithFormat:@"%@_iphonehbjj_%@__%@", pro, appVersion,dist];
        
        // 接入点名称（iOS取不到）
        NSString *ap = @"hbjj";
        
        // 屏幕尺寸（iPhone没必要传）
        NSString *ss = @"";
        
        // 拼接完整的统计字符串
        _analyticsString = [[[NSString stringWithFormat:@"_pro=%@&_pla=%@&_ver=%@&_mt=%@&_uid=amc%@&_ss=%@&_ap=%@", pro, pla, appVersion, ua, udid, ss, ap]
                             stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] copy];
    }
    return _analyticsString;
}


- (void)saveLastLoginName:(NSString*)name
                   idType:(NSString*)idType
{
    [SFHFKeychainUtils storeUsername:LAST_LOGIN_NAME andPassword:name forServiceName:@"user.name" updateExisting:YES error:nil];
    [SFHFKeychainUtils storeUsername:LAST_LOGIN_ID_TYPE andPassword:idType forServiceName:@"user.idType" updateExisting:YES error:nil];
}

- (NSString*)getLastLoginName
{
    return [SFHFKeychainUtils getPasswordForUsername:LAST_LOGIN_NAME andServiceName:@"user.name" error:nil];
}

- (NSString*)getLastLoginIdType
{
    return [SFHFKeychainUtils getPasswordForUsername:LAST_LOGIN_ID_TYPE andServiceName:@"user.idType" error:nil];
}

- (NSString*)getLastLoginIdTypeName
{
    NSString *idType = [self getLastLoginIdType];
    if (idType && [idType length] > 0) {
        for (NSDictionary *dic in self.loginIDTypePickerDataArray) {
            if ([idType isEqualToString:dic[@"value"]]) {
                return dic[@"name"];
            }
        }
    }
    return @"";
    
}


@end