//
//  AlertActionSheetBlockExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-12-3.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "AlertActionSheetBlockExampleViewController.h"

@interface AlertActionSheetBlockExampleViewController ()

@end

@implementation AlertActionSheetBlockExampleViewController

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
        
    
    HFButtonItem *cancelItem = [HFButtonItem item];
    cancelItem.label = @"否";
    cancelItem.action = ^(NSInteger index)
    {
        HFAlert(@"用户点击了否，回调%d",index);
    };
    
    HFButtonItem *yesItem1 = [HFButtonItem itemWithLabel:@"是"];
    yesItem1.action = ^(NSInteger index)
    {
        HFAlert(@"用户点击了是，回调%d",index);
    };
    
    HFButtonItem *yesItem2 = [HFButtonItem itemWithLabel:@"唤起sheet"];
    yesItem2.action = ^(NSInteger index)
    {
//        HFAlert(@"用户点击了是，回调%d",index);
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"测试回调" cancelButtonItem:cancelItem destructiveButtonItem:yesItem1 otherButtonItems:yesItem2, nil];
        [sheet showInView:self.view];
    };

    
    UIAlertView *alertView  = [ [UIAlertView alloc] initWithTitle:@"测试块回调" message:@"请点击相应按钮" cancelButtonItem:cancelItem otherButtonItems:yesItem1,yesItem2, nil ];
    
    [alertView show];
    [alertView release];
    
    
    
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
