//
// Created by jason on 12-11-20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
//声音
#import "AudioToolbox/AudioToolbox.h"


@interface HFAnimation : NSObject
+(void) animationFlipFromLeft:(id)sender;
+(void) animationFlipFromRight:(id)sender;
+(void) animationCurViewDown:(id)sender;
+(void) animationCurViewUp:(id)sender;
+(void) animationExplosion:(id)sender;
+ (void)animationShake:(id)sender;
+(void)palySound:(NSString*)soundAct;
@end