//
//  UIImage-Extensions.h
//  The9AdPlatform
//
//  Created by 峰 胡 on 12-3-26.
//  Copyright (c) 2012年 Magus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 ;
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data duration:(NSTimeInterval)duration;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url duration:(NSTimeInterval)duration;
//图片压缩
- (UIImage *)compressedImage;
- (CGFloat)compressionQuality;
- (NSData *)compressedData;
- (NSData *)compressedData:(CGFloat)compressionQuality;

@end;
