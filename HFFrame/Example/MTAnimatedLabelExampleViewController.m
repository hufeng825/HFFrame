//
//  MTAnimatedLabelExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-30.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "MTAnimatedLabelExampleViewController.h"

@interface MTAnimatedLabelExampleViewController ()

@end

@implementation MTAnimatedLabelExampleViewController
@synthesize label,label1,label2,label3;
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
    [self performSelector:@selector(beginAnimation:) withObject:label afterDelay:0];
    [self performSelector:@selector(beginAnimation:) withObject:label1 afterDelay:2];
    [self performSelector:@selector(beginAnimation:) withObject:label2 afterDelay:4];
    [self performSelector:@selector(beginAnimation:) withObject:label3 afterDelay:6];
    
    [self performSelector:@selector(stopAnimation:) withObject:label afterDelay:3];
    [self performSelector:@selector(stopAnimation:) withObject:label1 afterDelay:5];
    [self performSelector:@selector(stopAnimation:) withObject:label2 afterDelay:7];
}
-(void)beginAnimation:(id)sender
{
    [(MTAnimatedLabel*)sender startAnimating];
}

-(void)stopAnimation:(id)sender
{
    [(MTAnimatedLabel*)sender stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [label release];
    [label1 release];
    [label2 release];
    [label3 release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setLabel:nil];
    [self setLabel1:nil];
    [self setLabel2:nil];
    [self setLabel3:nil];
    [super viewDidUnload];
}

@end
