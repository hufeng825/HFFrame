//
//  HFSEFilterControlViewController.m
//  HFFrame
//
//  Created by jason on 12-12-17.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFSEFilterControlViewController.h"
#import "SEFilterControl.h"
#import "HFButton.h"
@interface HFSEFilterControlViewController ()

@end

@implementation HFSEFilterControlViewController

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
    SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:[self.view viewWithTag:10].frame
                                                             Titles:[NSArray arrayWithObjects:@"50元", @"100元", @"200元", @"300元",@"500元", nil]];
    [filter setProgressColor:[UIColor lightGrayColor]];
    //[filter setHandlerColor:[UIColor redColor]];
    [filter setTitlesColor:[UIColor whiteColor]];
    [filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filter];
    [filter release];
}

-(void)filterValueChanged:(SEFilterControl *) sender{
    HFButton *bt = (HFButton*)[self.view viewWithTag:11];
//    [bt setText:[NSString stringWithFormat:@"%d", sender.SelectedIndex]];
    [bt setTitle:[NSString stringWithFormat:@"去充值%@", [sender.titleArray objectAtIndex:sender.SelectedIndex] ] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btClick:(id)sender
{
    HFButton *bt = (HFButton*)sender;
    [bt beginActivity:nil postion:ActiveLeftOnBt];
}
@end
