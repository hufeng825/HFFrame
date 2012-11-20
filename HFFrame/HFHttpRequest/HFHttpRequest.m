//
//  HFHttpRequest.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//
#import "HFHttpRequest.h"
@implementation HFHttpRequest
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
    }
    
    return self;
}

//非单例模式
+(HFHttpRequest *)client
{
    return [[[self alloc]init]autorelease];
}

//单例模式
+(HFHttpRequest *)sharedClient
{
    static HFHttpRequest *sharedHttpRequest = nil;
    @synchronized([HFHttpRequest class])
    {
        if(!sharedHttpRequest)
            sharedHttpRequest = [[HFHttpRequest alloc] init];
    }
    return sharedHttpRequest;
}



-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    return self;
}

- (void)dealloc {

    [super dealloc];
}
@end
