//
//  AnimationExampleViewController.h
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFButton.h"
#import "HFAnimation.h"
@interface AnimationExampleViewController : UIViewController
- (IBAction)animationFlipFromLeft:(id)sender;
- (IBAction)animationFlipFromRight:(id)sender;
- (IBAction)animationCurViewDown:(id)sender;
- (IBAction)animationCurViewUp:(id)sender;
- (IBAction)animationExplosion:(id)sender;
- (IBAction)animationShake:(id)sender;
- (IBAction)animationHidden:(id)sender;
- (IBAction)animationShow:(id)sender;
- (IBAction)animationHeartbeat:(id)sender;
- (IBAction)animationMovepoint:(id)sender;
- (IBAction)animationRoateX:(id)sender;
- (IBAction)animationRoateZ:(id)sender;
@end
