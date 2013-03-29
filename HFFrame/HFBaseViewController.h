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



@property (nonatomic,retain) UILabel *titleLabel;//标题栏
@property (nonatomic,retain) HFHttpRequest *hfClient;

-(void)postUrl:(NSString*)url  parameters:(NSDictionary *)parameters sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock;
-(void)gettUrl:(NSString*)url sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock;

//返回上级页面 自行判断是mode 还是push 弹出来的
-(void)goBack;
@end