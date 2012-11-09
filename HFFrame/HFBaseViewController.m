//
//  HFBaseViewController.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//


/*********** 正则代码块******************
NSString *email = @"13068319870609101X";
bool ye =[email isMatchedByRegex:@""];
 *************************************/



#import "HFBaseViewController.h"
#import "HFHttpRequest.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "RegexKitLite.h"

@interface HFBaseViewController ()

@end

@implementation HFBaseViewController


- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    HFHttpRequest *client = [HFHttpRequest sharedClient];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];    
//    NSString *path = [NSString stringWithFormat:@"myapipath/?value=%@", value];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:
                             @"http://qa.fun-guide.mobi:7002/users/login.json?mobile=15810329037&password=96E79218965EB72C92A549DD5A330112"
                                           parameters:nil];
    [request setTimeoutInterval:3];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSLog(@"json %@",JSON);
        // do something with return data
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                         {
        // code for failed request goes here        
     
    }];
    [operation start];
    [[client operationQueue]cancelAllOperations];

    
}

-(void)buttonIndexClick
{
    NSLog(@"clicked");
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex  // after animation
{
    NSLog(@"su button %d",buttonIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
