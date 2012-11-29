//
//  GifExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-29.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "GifExampleViewController.h"

@interface GifExampleViewController ()

@end

@implementation GifExampleViewController

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
    UIImageView *imageV = (UIImageView*)[self.view viewWithTag:2];
    imageV.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://pic3.nipic.com/20090615/2761475_134344084_2.gif"] duration:1];
    
    
    UIImageView *imageVe = (UIImageView*)[self.view viewWithTag:1];
    NSURL *url  = [[NSBundle mainBundle] URLForResource:@"wof01" withExtension:@"gif"];
    imageVe.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url] duration:1];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
