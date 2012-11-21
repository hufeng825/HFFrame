//
//  AnimationExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "AnimationExampleViewController.h"

@interface AnimationExampleViewController ()

@end

@implementation AnimationExampleViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationFlipFromLeft:(id)sender
{
    [HFAnimation animationFlipFromLeft:sender];
}

- (IBAction)animationFlipFromRight:(id)sender
{
    [HFAnimation animationFlipFromRight:sender];
}

- (IBAction)animationCurViewDown:(id)sender
{
    [HFAnimation animationCurViewDown:sender];    
}

- (IBAction)animationCurViewUp:(id)sender {
    [HFAnimation animationCurViewUp:sender];
}

- (IBAction)animationExplosion:(id)sender
{
    [HFAnimation animationExplosion:sender];
}

- (IBAction)animationShake:(id)sender
{
    [HFAnimation animationShake:sender];
}

- (IBAction)animationHidden:(id)sender
{
    [HFAnimation animationHidden:sender];
}
- (IBAction)animationShow:(id)sender
{
    [HFAnimation animationShow:sender];
}

- (IBAction)animationHeartbeat:(id)sender
{
    [HFAnimation animationHeartbeat:sender];
}

- (IBAction)animationMovepoint:(id)sender
{
    [HFAnimation animationMovepoint:sender point:CGPointMake(-10, -10)];
}

@end
