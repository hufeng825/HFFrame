//
//  HFButtonExampleViewController.h
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBaseViewController.h"
#import "HFButton.h"

@interface HFButtonExampleViewController : HFBaseViewController
@property (retain, nonatomic) IBOutlet HFButton *warningBt;
@property (retain, nonatomic) IBOutlet HFButton *passValueBt;
@property (retain, nonatomic) IBOutlet HFButton *loadingBt;

- (IBAction)Btclicked:(id)sender;
@end
