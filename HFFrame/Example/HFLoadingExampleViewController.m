//
//  HFLoadingExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-28.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFLoadingExampleViewController.h"
#import "HFLoadingView.h"
@interface HFLoadingExampleViewController ()

@end

@implementation HFLoadingExampleViewController

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
	// Do any additional setup after loading the view.
    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:1] title:@"测试loading 页面"];
//    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:3]];
    int64_t delayInSeconds = 5.0;
    dispatch_time_t popTimes = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTimes, dispatch_get_main_queue(), ^(void){
        [HFLoadingView hideLoadingViewForView:[self.view viewWithTag:1]];
    });
    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:2] title:@"测试loading 页面"];
    //    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:3]];
    int64_t delayInSecond = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSecond * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [HFLoadingView hideLoadingViewForView:[self.view viewWithTag:2]];
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
