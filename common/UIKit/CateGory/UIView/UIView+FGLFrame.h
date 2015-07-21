//
//  UIView+FGLFrame.h
//  question
//
//  Created by 陈昕 on 15/7/15.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FGLFrame)

@property (nonatomic, assign) CGSize fgl_size;

// shortcuts for positions
@property (nonatomic) CGFloat fgl_centerX;
@property (nonatomic) CGFloat fgl_centerY;


@property (nonatomic) CGFloat fgl_top;
@property (nonatomic) CGFloat fgl_bottom;
@property (nonatomic) CGFloat fgl_right;
@property (nonatomic) CGFloat fgl_left;

@property (nonatomic) CGFloat fgl_width;
@property (nonatomic) CGFloat fgl_height;

@end
