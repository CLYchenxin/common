//
//  UIColor+FGLGradient.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FGLGood)

//渐变
+ (UIColor *)fgl_gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(int)height;
// 半透明
- (UIColor *)fgl_colorForTranslucency;

@end
