//
//  FlipViewController.m
//  HFFrame
//
//  Created by jason on 12-11-26.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "FlipViewController.h"

@interface FlipViewController ()

@end

@implementation FlipViewController
@synthesize delegate;
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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
	self.navigationItem.leftBarButtonItem = item;
	[item release];
}


-(void)close:(id)sender{
    if (delegate && [delegate respondsToSelector:@selector(FlipViewControllerClose:)])
    {
        [delegate FlipViewControllerClose:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
