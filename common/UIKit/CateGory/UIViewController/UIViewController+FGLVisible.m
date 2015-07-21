//
//  UIViewController+FGLVisible.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIViewController+FGLVisible.h"

@implementation UIViewController (FGLVisible)

- (BOOL)fgl_isVisible {
    return [self isViewLoaded] && self.view.window;
}

@end
