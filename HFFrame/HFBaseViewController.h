//
//  HFBaseViewController
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHttpRequest.h"
#import "AFNetworkActivityIndicatorManager.h"


#define APPID @"50a45160"
#define H_CONTROL_ORIGIN CGPointMake(20, 70)
#define ENGINE_URL @"http://dev.voicecloud.cn:1028/index.htm"

@interface HFBaseViewController : UIViewController
{
}



@property (nonatomic,retain) HFHttpRequest *hfClient;
@property (nonatomic,retain) UILabel *titleLabel;//标题栏


-(void)postUrl:(NSString*)url  parameters:(NSDictionary *)parameters sucessBlock:(HttpSucessRespon)sucessRespon failBlock:(HttpFailRespon)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock;
-(void)gettUrl:(NSString*)url sucessBlock:(HttpSucessRespon)sucessRespon failBlock:(HttpFailRespon)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock;
//返回上级页面 自行判断是mode 还是push 弹出来的
-(void)goBack;
@end