//
//  UIResponder+FGLNearby.m
//  question
//
//  Created by 陈昕 on 15/7/20.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIResponder+FGLNearby.h"

@implementation UIResponder (FGLNearby)

- (UIViewController *)fgl_viewController
{
    UIResponder *responder = self.nextResponder;

    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }

        responder = responder.nextResponder;

    } while (responder != nil);
    
    return nil;

}
- (UINavigationController *)fgl_navigationController
{
    UIResponder *responder = self;

    do {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responder;
        }

        responder = responder.nextResponder;

    } while (responder != nil);
    
    return nil;
}

@end
