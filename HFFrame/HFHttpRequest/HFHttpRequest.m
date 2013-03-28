//
//  HFHttpRequest.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//
#import "HFHttpRequest.h"
@implementation HFHttpRequest
//@synthesize sucessRespon;
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
    }
    
    return self;
}
- (NSString*)encodeURL:(NSString *)string
{
	NSString *newString = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease];
	if (newString) {
		return newString;
	}
	return @"";
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
//    @synchronized([HFHttpRequest class])
//    {
//        if(!sharedHttpRequest)
//            sharedHttpRequest = [[HFHttpRequest alloc] init];
//    }
    static dispatch_once_t onceToken =0;
    dispatch_once(&onceToken, ^{
        if(!sharedHttpRequest)
            sharedHttpRequest = [[HFHttpRequest alloc] init];
    });
    return sharedHttpRequest;
}
//因为是单例和非单例混合的初始化 暂时没有重写allocWithZone

/* post 参数
NSDictionary *params = [NSDictionarydictionaryWithObjectsAndKeys: @"value1", @"param1", @"value2", @"param2", @"value3", @"param3", @"value4", @"param4", nil]
*/
-(void)Url:(NSString*)url  parameters:(NSDictionary *)parameters
 sucessBlock:(HttpSucessRespon)sucessRespon failBlock:(HttpFailRespon)failRespon method:(HFRequestMethod)method progressBlock:(HttpDownloadProgressBlock)progressBlock
{
    NSString *urlStr=nil;//如果含有中文或者全角字符 则进行UTF-8格式化
    if ([url gotChineseCount]>0)
    {
       urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        urlStr = [url URLencodeWithEncodingUTF8];
    }
    else
    {
        urlStr = url;
    }

    /**
     Some nested parameter structures, such as a keyed array of hashes containing inconsistent keys (i.e. @{@"": @[@{@"a" : @(1)}, @{@"b" : @(2)}]}), cannot be unambiguously represented in query strings. It is strongly recommended that an unambiguous encoding, such as AFJSONParameterEncoding, is used when posting complicated or nondeterministic parameter structures
     **/
    [self setParameterEncoding:AFJSONParameterEncoding];
    NSLog(@"url 输出 %@",[urlStr description]);
    NSMutableURLRequest *request;
    if (method == GET)
    {
        request  = [self requestWithMethod:@"GET" path:urlStr
                    parameters:nil];

    }
    else
    {
       request = [self requestWithMethod:@"POST" path:urlStr
            parameters:parameters];

    }
    //设置超时时间
    [request setTimeoutInterval:30];
    //设置默认错误处理方式
    if (!failRespon)
    {
        failRespon  = HFHttpFailResponClass
        {
            NSLog(@"%@",[error description]);
        };
    }
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
    sucessRespon failure:failRespon];
    
    [operation setDownloadProgressBlock:progressBlock];
    
   [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil]];
//    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        NSLog(@"changed %d", status);
        //your code here
    }];
    NSLog(@"opertation %@",[operation description]);
    [operation start];
}



-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    return self;
}

- (void)dealloc
{
//    RELEASE_SAFELY(sucessRespon);
    [super dealloc];
}
@end
