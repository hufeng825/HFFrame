//
//  HFPickerExampleViewController.m
//  HFFrame
//
//  Created by jason on 13-2-4.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFPickerExampleViewController.h"

@interface HFPickerExampleViewController ()

@end

@implementation HFPickerExampleViewController

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
    HFPickerView *picker = [[HFPickerView alloc]init];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [picker showSelfView];
    });
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
