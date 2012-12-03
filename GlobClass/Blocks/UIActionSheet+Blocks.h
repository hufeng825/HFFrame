//
//  UIActionSheet+Blocks.h
//  Shibui
//
//  Created by jason on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFButtonItem.h"

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(HFButtonItem *)inCancelButtonItem destructiveButtonItem:(HFButtonItem *)inDestructiveItem otherButtonItems:(HFButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(HFButtonItem *)inCancelButtonItem destructiveButtonItem:(HFButtonItem *)inDestructiveItem otherButtonItemsArray:(NSArray *)inOtherButtonItems;

- (NSInteger)addButtonItem:(HFButtonItem *)item;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();

@end
