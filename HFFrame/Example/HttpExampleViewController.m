//
//  HttpExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HttpExampleViewController.h"

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
    NSMutableURLRequest *request = [self.hfClient requestWithMethod:@"GET" path:
                                    @"http://9snow.org/weather/api?city=%E5%8C%97%E4%BA%AC"
                                                  parameters:nil];
    [request setTimeoutInterval:30];
    //
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             NSLog(@"json %@",[JSON class]);
                                             _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];
                                             // do something with return data
                                         }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             // code for failed request goes here
                                             NSLog(@"%@",[error description]);
                                             _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];

                                         }];
    operation.JSONReadingOptions = NSJSONReadingAllowFragments;//
    [operation start];

    
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
