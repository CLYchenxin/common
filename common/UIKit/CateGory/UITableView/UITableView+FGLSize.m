//
//  UITableView+FGLSize.m
//  question
//
//  Created by 陈昕 on 15/8/1.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UITableView+FGLSize.h"

@implementation UITableView (FGLSize)

- (CGFloat)fgl_contentHeight
{
    [self layoutIfNeeded];
    return self.contentSize.height;
}

@end
