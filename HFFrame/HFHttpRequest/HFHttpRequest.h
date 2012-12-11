//
//  HFHttpRequest.h
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"


#define HFHttpSucessResponClass  ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
#define HFHttpFailResponClass ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
typedef  void(^HttpSucessRespon)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);
typedef  void(^HttpFailRespon)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);

typedef enum
{
    POST,
    GET
}HFRequestMethod ;

@interface HFHttpRequest : AFHTTPClient
{

}


+(HFHttpRequest *)sharedClient;
+(HFHttpRequest *)client;
-(void)Url:(NSString*)url  parameters:(NSDictionary *)parameters sucessBlock:(HttpSucessRespon)sucessRespon failBlock:(HttpFailRespon)failRespon method:(HFRequestMethod)method;
@end
