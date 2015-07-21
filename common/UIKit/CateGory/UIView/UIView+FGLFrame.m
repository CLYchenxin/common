//
//  UIView+FGLFrame.m
//  question
//
//  Created by 陈昕 on 15/7/15.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIView+FGLFrame.h"

@implementation UIView (FGLFrame)

- (CGFloat)fgl_top
{
    return self.frame.origin.y;
}

- (void)setFgl_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)fgl_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFgl_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)fgl_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFgl_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)fgl_left
{
    return self.frame.origin.x;
}

- (void)setFgl_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)fgl_width
{
    return self.frame.size.width;
}

- (void)setFgl_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)fgl_height
{
    return self.frame.size.height;
}

- (void)setFgl_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)fgl_origin
{
    return self.frame.origin;
}

- (void)setFgl_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)fgl_size
{
    return self.frame.size;
}

- (void)setFgl_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)fgl_centerX
{
    return self.center.x;
}

- (void)setFgl_centerX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)fgl_centerY
{
    return self.center.y;
}

- (void)setFgl_centerY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

@end
