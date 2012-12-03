//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by jason on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFButtonItem.h"

@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(HFButtonItem *)inCancelButtonItem otherButtonItems:(HFButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(HFButtonItem *)inCancelButtonItem otherButtonItemsArray:(NSArray *)inOtherButtonItemsArray;

- (NSInteger)addButtonItem:(HFButtonItem *)item;

@end
