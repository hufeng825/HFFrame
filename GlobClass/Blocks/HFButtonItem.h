//
//  RIButtonItem.h
//  Shibui
//
//  Created by jason on 1/12/12.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFButtonItem : NSObject
{
    NSString *label;
    void (^action)();
}
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)(NSInteger buttonIndex);
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
@end

