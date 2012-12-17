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
    [[HFInfoView sharedInstance]showInfo:@"这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMessage:(id)sender
{
    NSArray *array = [NSArray arrayWithObjects:@"短字测试",@"测试一个中等长度的字",@"测试一个特别长的字『胡峰』北京新空气软件技术有限公司 北京市 朝阳区 大望路 国美第一城", nil];
//    [[HFInfoView sharedInstance]showInfo: [array objectAtIndex: rand()%3]];
    ShowInfo([array objectAtIndex: rand()%3]);
}
@end
