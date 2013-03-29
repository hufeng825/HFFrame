//
//  Global_macro.m
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "GlobalMacro.h"
//#import "HFInfoView.h"
BOOL TTIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]]&& [(NSString*)object length] > 0 && object !=nil ;}
//void ShowInfo( id formatstring,...)
//{
//    va_list arglist;
//	if (!formatstring) return;
//	va_start(arglist, formatstring);
//	id outstring = [[[NSString alloc] initWithFormat:formatstring arguments:arglist] autorelease];
//	va_end(arglist);
//   [ [HFInfoView sharedInstance]showInfo: outstring];
//}
