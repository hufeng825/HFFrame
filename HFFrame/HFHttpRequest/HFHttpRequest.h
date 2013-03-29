//
//  HFHttpRequest.h
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"


#define HFHttp_Sucess_Respon  ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
#define HFHttp_Fail_Respon ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
#define HFHttp_DownloadProgress ^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)

typedef  void(^HttpSucessResponBlock)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);

typedef  void(^HttpFailResponBlock)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);

typedef  void (^HttpDownloadProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

typedef enum
{
    POSTHttpMethod,
    GETHttpMethod
}HFRequestMethod ;

@interface HFHttpRequest : AFHTTPClient
{
}

+(HFHttpRequest *)sharedClient;
+(HFHttpRequest *)client;
-(void)Url:(NSString*)url  parameters:(NSDictionary *)parameters sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon method:(HFRequestMethod)method progressBlock:(HttpDownloadProgressBlock)progressBlock;
@end
