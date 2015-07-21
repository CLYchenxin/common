//
//  UIView+FGLUtil.m
//  question
//
//  Created by 陈昕 on 15/7/15.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIView+FGLUtil.h"

@implementation UIView (FGLUtil)

- (void)fgl_removeAllSubViews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
