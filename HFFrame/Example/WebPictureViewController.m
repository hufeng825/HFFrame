//
//  WebPictureViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "WebPictureViewController.h"
#import "UIImageView+WebCache.h"

@interface WebPictureViewController ()

@end

@implementation WebPictureViewController

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
    
    
    /**************************************************************
     ************************下载图片代码段****************************/
    [_imageView setImageWithURL:[NSURL URLWithString:@"http://img.my.csdn.net/uploads/201101/25/3619941_1295933551y8U4.jpg"]
     placeholderImage:[UIImage imageNamed:@"default.png"]];
     
     /*********************************************************************/

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
