//
//  UIView+FGLBorder.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FGLBorder)

- (void)fgl_addBorderWithWidth:(CGFloat)width color:(UIColor *)aColor;

- (void)fgl_addBottomBorderWithWidth:(CGFloat)width color:(UIColor *)aColor;
- (void)fgl_addTopBorderWithWidth:(CGFloat)width color:(UIColor *)aColor;
- (void)fgl_addLeftBorderWithWidth:(CGFloat)width color:(UIColor *)aColor;
- (void)fgl_addRightBorderWithWidth:(CGFloat)width color:(UIColor *)aColor;

@end
