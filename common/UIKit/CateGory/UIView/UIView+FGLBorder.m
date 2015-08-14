//
//  UIView+FGLBorder.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIView+FGLBorder.h"
#import <Masonry/Masonry.h>

@implementation UIView (FGLBorder)

- (void)fgl_addBorderWithWidth:(CGFloat)width color:(UIColor *)aColor
{
    self.layer.borderColor = aColor.CGColor;
    self.layer.borderWidth = width;
}

- (void)fgl_addBottomBorderWithWidth:(CGFloat)width color:(UIColor *)aColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = aColor;
    [self addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(width);
        make.height.mas_equalTo(width);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)fgl_addTopBorderWithWidth:(CGFloat)width color:(UIColor *)aColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = aColor;
    [self addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-width);
        make.height.mas_equalTo(width);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)fgl_addLeftBorderWithWidth:(CGFloat)width color:(UIColor *)aColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = aColor;
    [self addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-width);
        make.width.mas_equalTo(width);
        make.top.bottom.mas_equalTo(0);
    }];
}

- (void)fgl_addRightBorderWithWidth:(CGFloat)width color:(UIColor *)aColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = aColor;
    [self addSubview:lineView];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(width);
        make.width.mas_equalTo(width);
        make.top.bottom.mas_equalTo(0);
    }];
}

@end
