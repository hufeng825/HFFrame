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
    NSMutableURLRequest *request = [self.hfClient requestWithMethod:@"POST" path:
                                    @"http://qa.fun-guide.mobi:7002/users/login.json?mobile=15810329037&password=96E79218965EB72C92A549DD5A330112"
                                                  parameters:nil];
    [request setTimeoutInterval:30];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
//                                             NSLog(@"json %@",JSON);
                                             _resultTextView.text = [NSString stringWithFormat:@"%@",JSON];
                                             // do something with return data
                                         }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
                                             // code for failed request goes here

                                         }];
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
