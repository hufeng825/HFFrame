//
//  HFHttpRequest.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//
#import "HFHttpRequest.h"
@implementation HFHttpRequest
@synthesize operationDict;
- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
        operationDict = [[NSMutableDictionary alloc]init];
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

- (NSString*)encodeURL:(NSString *)string
{
	NSString *newString = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease];
	if (newString) {
		return newString;
	}
	return @"";
}



//因为是单例和非单例混合的初始化 暂时没有重写allocWithZone
#pragma  mark -
#pragma mark -  格式化url中的全角支付
- (NSString *)formatUrlStr:(NSString *)url
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
    return urlStr;
}
#pragma mark -  打印url 可以将post 请求以get 方式打印
- (void)logUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters
{
    if (parameters)
    {
        NSLog(@"post url  输出 %@?%@",urlStr,[self describeDictionary:parameters]);
    }
    else
    {
        NSLog(@"get url 输出 %@",[urlStr description]);
    }
}
#pragma mark - 网络状态改变后的一些处理
- (void)reachabilityStatusChangeBlock
{
    //    operation.JSONReadingOptions = NSJSONReadingAllowFragments;
    //设置网络状态切换模式
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         NSLog(@"changed %d", status);
         //your code here
     }];
}
#pragma mark - 将operate 从字典中移除
- (void) removeHashFromDict :(NSInteger) hasNum
{
    [self.operationDict removeObjectForKey:[NSString stringWithFormat:@"%d",hasNum] ];
}

#pragma mark - 错误处理
- (HttpFailResponBlock )failResponHandling:(HttpFailResponBlock)failRespon hashNum:(NSUInteger) hasNum

{
    [self removeHashFromDict:hasNum];
    //如果用户传入nil 则进入下面调用默认的错误处理
    if (!failRespon)
    {
        
        failRespon =^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            NSLog(@"the error %@",[error description]);
        };
    }
    return failRespon;
}

#pragma mark - 成功处理
-(HttpSucessResponBlock)sucessHandling:(HttpSucessResponBlock)sucessRespon hashNum:(NSUInteger) hasNum
{
    [self removeHashFromDict:hasNum];
    return sucessRespon;
}

- (NSMutableURLRequest *)requestWithMethod:(HFHttpMethod)method
                                      url:(NSString *)path
                                parameters:(NSDictionary *)parameters
                                
{
    NSMutableURLRequest *request;
    if (method == GETHttpMethod)
    {
        request  = [self requestWithMethod:@"GET" path:path
                                parameters:nil];
    }
    else
    {
        request = [self requestWithMethod:@"POST" path:path
                               parameters:parameters];
        
    }
    return request;
}

/* post 参数
 NSDictionary *params = [NSDictionarydictionaryWithObjectsAndKeys: @"value1", @"param1", @"value2", @"param2", @"value3", @"param3", @"value4", @"param4", nil]
 */

-(void)Url:(NSString*)url  parameters:(NSDictionary *)parameters
sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon method:(HFHttpMethod)method progressBlock:(HttpDownloadProgressBlock)progressBlock
{
    NSString *urlStr = [self formatUrlStr:url];
    [self setParameterEncoding:AFJSONParameterEncoding];
    NSMutableURLRequest *request = [self requestWithMethod:method url:urlStr parameters:parameters];
    NSUInteger hashNum = [request hash];
    //设置错误处理
    failRespon = [self failResponHandling:failRespon hashNum:hashNum];
    sucessRespon = [self sucessHandling:sucessRespon hashNum:hashNum];
    
    //设置超时时间
    [request setTimeoutInterval:30];
    //打印url 
    [self logUrl:urlStr parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:
                                         sucessRespon failure:failRespon];
    [self.operationDict setObject:operation forKey:[NSString stringWithFormat:@"%u",hashNum]];
    //打印下载百分比    
    [operation setDownloadProgressBlock:progressBlock];
    //设置网络状态改变
    [self reachabilityStatusChangeBlock];

    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil]];
    [operation start];
}

- (NSString *) describeDictionary :(NSDictionary *)dict
{
    NSArray *keys;
    NSMutableString *parmURLStr = [NSMutableString string];
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        //        NSLog (@"Key: %@ for value: %@", key, value);
        [parmURLStr appendFormat:@"&%@=%@",key,value];
    }
    return parmURLStr;
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
    [operationDict release];
    [[self operationQueue] cancelAllOperations];
    [super dealloc];
}
@end
