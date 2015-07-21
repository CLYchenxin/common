//
//  UITableViewCell+FGLSeparator.m
//  question
//
//  Created by 陈昕 on 15/7/15.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UITableViewCell+FGLSeparator.h"

@implementation UITableViewCell (FGLSeparator)

- (void)fgl_clearSeparatorInset
{
    // Remove seperator inset
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
