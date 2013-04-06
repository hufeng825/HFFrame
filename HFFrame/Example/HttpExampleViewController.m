//
//  HttpExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HttpExampleViewController.h"
#import "HFHttpRequest.h"
#import "HFLoadingView.h"
#import "UIImage+Extensions.h"
@interface HttpExampleViewController ()

@end

@implementation HttpExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    /***********************网络get请求例子*************************/
    HttpSucessResponBlock su = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
//  HFHttp_Sucess_Respon
    {
        NSLog(@"json %@",[JSON class]);
        _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];
        [HFLoadingView hideLoadingViewForView:self.view];
    };
    
    
    HttpFailResponBlock failBlock = HFHttp_Fail_Respon
    {
        HFAlert(@"%@",[error description]);
    };
    
    NSString *url = @"http://9snow.org/weather/api?city=北京";
    NSLog(@"%d",[url gotChineseCount]);
   [self gettUrl:url sucessBlock:su failBlock:failBlock downloadProgressBlock:nil];
    
    
    url = @"http://httpbin.org/post";
    /***********************网络post请求例子*************************/    
    
    HttpSucessResponBlock sua = HFHttp_Sucess_Respon
    {
        [HFLoadingView hideLoadingViewForView:self.view];
        _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];

        NSLog(@"%@",JSON);
    };
    NSData *imageData = [[UIImage imageNamed:@"Default-568h@2x.png"]compressedData];
    HttpDownloadProgressBlock progressBlock = HFHttp_DownloadProgress
    {
        float percentNum = (float)totalBytesRead/totalBytesExpectedToRead ;
        NSString *percentStr = [NSString stringWithFormat:@"%.0f",percentNum*100];
        
        [HFLoadingView changeLoadingTextForView:self.view title:[ NSString stringWithFormat:@"%@%@",percentStr,@"%"]];
    };
    [self postUrl:url parameters:[NSDictionary dictionaryWithObject:[imageData description]forKey:@"urlimage"] sucessBlock:sua failBlock:nil downloadProgressBlock:progressBlock];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_resultTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setResultTextView:nil];
    [super viewDidUnload];
}
@end
