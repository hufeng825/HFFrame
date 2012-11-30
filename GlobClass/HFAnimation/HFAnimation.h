//
// Created by jason on 12-11-20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
//声音
#import "AudioToolbox/AudioToolbox.h"


typedef enum
{
    RotateX,
    RotateY,
    RotateZ
}RotatePos;


@interface HFAnimation : NSObject
+(void) animationFlipFromLeft:(id)sender;
+(void) animationFlipFromRight:(id)sender;
+(void) animationCurViewDown:(id)sender;
+(void) animationCurViewUp:(id)sender;
+(void) animationExplosion:(id)sender;
+ (void)animationShake:(id)sender;
+ (void)animationShake:(id)sender  repeatCount:(float)repeatCount;

+(void)animationShow:(id)sender;
+(void)animationHidden:(id)sender;
+(void )animationMovepoint:(id)sender point:(CGPoint )point; //点移动
+(void)animationHeartbeat:(id)sender;
+(void)removeAllAnimation:(id)sender;

+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos;
+(void)animationRotate:(id)sender rotatePos:(RotatePos)rotatePos duration:(NSTimeInterval)duration  repeatCount:(float)repeatCount;
+(void)palySound:(NSString*)soundAct;
@end