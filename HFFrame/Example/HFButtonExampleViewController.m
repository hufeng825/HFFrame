//
//  HFButtonExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFButtonExampleViewController.h"

@interface HFButtonExampleViewController ()

@end

@implementation HFButtonExampleViewController

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
    [_warningBt beginWarningAnimation];
    _passValueBt.userInfo =@"你好胡峰";
    [_loadingBt beginActivity:@"仿QQ登录Bt" postion:ActiveRightOnBt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_warningBt release];
    [_passValueBt release];
    [_loadingBt release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWarningBt:nil];
    [self setPassValueBt:nil];
    [self setLoadingBt:nil];
    [super viewDidUnload];
}
- (IBAction)Btclicked:(id)sender
{
    HFButton *bt = sender;
    HFAlert(bt.userInfo);
  }
@end
