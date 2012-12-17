//
//  Global_macro.m
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "Global_macro.h"
#import "HFInfoView.h"
BOOL TTIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]]&& [(NSString*)object length] > 0 && object !=nil ;}
void ShowInfo(NSString *str)
{
   [ [HFInfoView sharedInstance]showInfo: str];
}
