//
//  UIColor+FGLUtil.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FGLHEX)

+ (UIColor *)fgl_colorWithHex:(UInt32)hex;
+ (UIColor *)fgl_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

- (NSString *)fgl_HEXString;

@end
