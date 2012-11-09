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
@interface HFHttpRequest : AFHTTPClient
{
    
}
+(HFHttpRequest *)sharedClient;
@end
