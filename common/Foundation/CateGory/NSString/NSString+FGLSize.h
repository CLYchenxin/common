//
//  NSString+FGLSize.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FGLSize)

- (CGFloat)fgl_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)fgl_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (CGSize)fgl_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)fgl_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end
