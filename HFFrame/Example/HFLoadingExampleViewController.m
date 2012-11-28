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
    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:1]];
//    [HFLoadingView showLoadingViewAddedTo:[self.view viewWithTag:3]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
