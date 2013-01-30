//
//  HFObjectMapViewController.m
//  HFFrame
//
//  Created by jason on 13-1-30.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFObjectMapViewController.h"
#import "NSObject+JTObjectMapping.h"

@interface HFObjectMapViewController ()

@end

@implementation HFObjectMapViewController

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
    HttpSucessRespon sua = HFHttpSucessResponClass
    {
        NSLog(@"json %@",[JSON class]);
        
    };
    NSURL *url = [[NSBundle mainBundle] URLForResource: @"j" withExtension:@"json"];
    NSLog(@"url 输出 %@",[url absoluteString]);

    [self gettUrl:[[url absoluteString] stringByReplacingOccurrencesOfString:@"" withString:@""] sucessBlock:sua failBlock:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
