//
//  UIAlertView+Blocks.m
//  Shibui
//
//  Created by jason on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

static NSString *HF_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";

@implementation UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(HFButtonItem *)inCancelButtonItem otherButtonItemsArray:(NSArray *)inOtherButtonItemsArray {
    if((self = [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        [buttonsArray addObjectsFromArray:inOtherButtonItemsArray];

        for(HFButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }

        if(inCancelButtonItem)
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];

        objc_setAssociatedObject(self, (__bridge const void *)HF_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [self setDelegate:self];
    }
    return self;

}

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(HFButtonItem *)inCancelButtonItem otherButtonItems:(HFButtonItem *)inOtherButtonItems, ... 
{
    NSMutableArray *buttonsArray = [NSMutableArray array];

    HFButtonItem *eachItem;
    va_list argumentList;
    if (inOtherButtonItems)
    {
        [buttonsArray addObject: inOtherButtonItems];
        va_start(argumentList, inOtherButtonItems);
        while((eachItem = va_arg(argumentList, HFButtonItem *)))
        {
            [buttonsArray addObject: eachItem];
        }
        va_end(argumentList);
    }

    return [self initWithTitle:inTitle message:inMessage cancelButtonItem:inCancelButtonItem otherButtonItemsArray:buttonsArray];

}

- (NSInteger)addButtonItem:(HFButtonItem *)item
{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)HF_BUTTON_ASS_KEY);	
	
	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
	return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)HF_BUTTON_ASS_KEY);
        HFButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action(buttonIndex);
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)HF_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
