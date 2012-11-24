//
//  AttributedLabelControllViewController.m
//  HFFrame
//
//  Created by jason on 12-11-25.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "AttributedLabelControllViewController.h"

@interface AttributedLabelControllViewController ()

@end

@implementation AttributedLabelControllViewController
@synthesize label;
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
    label.numberOfLines = 0;
    NSString* text = @"190多分钟啊！！越往后越精彩，嘴都笑抽了！龌龊于，猥琐郭，弱智岳。走你！！！！才看到19:30 笑喷了。。。果断分享了啊，慢慢看！！";
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^(NSMutableAttributedString *mutableAttributedString){
        //NSMutableAttributedString *mutableAttributedString;
        NSRange whiteRange = [text rangeOfString:@"后"];
        if (whiteRange.location != NSNotFound)
        {
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor grayColor].CGColor range:whiteRange];
        }
        return mutableAttributedString;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [label release];
     [super dealloc];
}
- (void)viewDidUnload
{
     [self setLabel:nil];
     [super viewDidUnload];
}
@end
