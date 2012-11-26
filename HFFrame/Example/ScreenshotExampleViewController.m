//
//  ScreenshotExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-26.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "ScreenshotExampleViewController.h"
#import "UIView+Screenshot.h"
@interface ScreenshotExampleViewController ()

@end

@implementation ScreenshotExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(getScreenshot:)]autorelease];
    }
    return self;
}
-(void)getScreenshot:(id)sender
{
//    self.imageView.image =[[UIApplication sharedApplication].keyWindow screenshot];
    self.imageView.image = [[[[self.navigationController viewControllers]objectAtIndex:0] view]screenshot];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
