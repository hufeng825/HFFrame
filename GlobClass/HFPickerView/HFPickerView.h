//
//  HFPickerView.h
//  HFFrame
//
//  Created by jason on 13-2-4.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HFSNumString(a) [NSString stringWithFormat:@"%@",a]
@protocol HFPickerViewControllerDelegate

-(void) PickerViewChangeValue:(NSString *) value name:(NSString *)name component1Dictionary:(NSDictionary *) com1Dictionary;

@end

@interface HFPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPopoverController *_popver;
}
@property (nonatomic ,retain) UIView *view;
@property (nonatomic, retain) UIControl *mask;
@property (nonatomic, retain)  UIPickerView *pickView;
@property (nonatomic, retain) NSMutableArray *component1Array;
@property (nonatomic, retain) NSMutableDictionary *component1Dictionary;
@property (nonatomic, assign) id<HFPickerViewControllerDelegate> delegate;

- (void)customInit;
-(void) showSelfView;
-(void) toSetLabelText:(NSString *)title;//设置title

@end
