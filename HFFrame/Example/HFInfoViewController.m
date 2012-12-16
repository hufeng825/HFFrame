//
//  HFInfoViewController.m
//  HFFrame
//
//  Created by jason on 12-12-16.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFInfoViewController.h"
#import "HFInfoView.h"

@interface HFInfoViewController ()

@end

@implementation HFInfoViewController

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
    [self.view addSubview: [HFInfoView sharedInstance].view ];
    [[HFInfoView sharedInstance]showInfo:@"这是一个测试"];
    [[HFInfoView sharedInstance]showInfo:@"这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
