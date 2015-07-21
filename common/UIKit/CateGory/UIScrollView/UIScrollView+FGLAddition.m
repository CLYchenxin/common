//
//  UIScrollView+FGLAddition.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIScrollView+FGLAddition.h"

@implementation UIScrollView (FGLAddition)

- (CGPoint)fgl_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)fgl_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)fgl_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)fgl_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}


- (BOOL)fgl_isScrolledToTop
{
    return self.contentOffset.y <= [self fgl_topContentOffset].y;
}

- (BOOL)fgl_isScrolledToBottom
{
    return self.contentOffset.y >= [self fgl_bottomContentOffset].y;
}

- (BOOL)fgl_isScrolledToLeft
{
    return self.contentOffset.x <= [self fgl_leftContentOffset].x;
}

- (BOOL)fgl_isScrolledToRight
{
    return self.contentOffset.x >= [self fgl_rightContentOffset].x;
}

- (void)fgl_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self fgl_topContentOffset] animated:animated];
}

- (void)fgl_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self fgl_bottomContentOffset] animated:animated];
}

- (void)fgl_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self fgl_leftContentOffset] animated:animated];
}

- (void)fgl_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self fgl_rightContentOffset] animated:animated];
}

- (NSUInteger)fgl_YPageCount
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)fgl_XPageCount
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

- (void)fgl_scrollToYPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)fgl_scrollToXPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
