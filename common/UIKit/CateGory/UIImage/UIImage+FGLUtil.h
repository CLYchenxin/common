//
//  UIImage+FGLUtil.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (FGLUtil)

- (UIImage*)fgl_scaledToSize:(CGSize)targetSize;

+ (UIImage *)fgl_imageWithColor:(UIColor *)aColor;
+ (UIImage *)fgl_imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

+ (UIImage *)fgl_fullResolutionImageFromALAsset:(ALAsset *)asset;

@end
