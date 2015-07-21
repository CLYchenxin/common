//
//  UIButton+FGLEdgeInsets.h
//  question
//
//  Created by 陈昕 on 15/7/17.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FGLButtonEdgeInsetsStyle) {
    FGLButtonEdgeInsetsStyleImageLeft,
    FGLButtonEdgeInsetsStyleImageRight,
    FGLButtonEdgeInsetsStyleImageTop,
    FGLButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (FGLEdgeInsets)

- (void)fgl_layoutButtonWithEdgeInsetsStyle:(FGLButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end


