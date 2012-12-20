//
//  HttpExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HttpExampleViewController.h"
#import "HFHttpRequest.h"
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
    
    /***********************网络请求例子*****************************/
    HttpSucessRespon su = HFHttpSucessResponClass
    {
        NSLog(@"json %@",[JSON class]);
        _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];
    };
    
   [self gettUrl:@"http://9snow.org/weather/api?city=北京" sucessBlock:su failBlock:nil];
    
    
    
    /***********************网络请求例子*****************************/
    HttpSucessRespon sua = HFHttpSucessResponClass
    {
        NSLog(@"json %@",[JSON class]);
        _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];
        
    };
    
    [self gettUrl:@"http://9snow.org/weather/api?city=北京" sucessBlock:sua failBlock:nil];
    
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
