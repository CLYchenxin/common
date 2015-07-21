//
//  UIScrollView+FGLAddition.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (FGLAddition)

- (CGPoint)fgl_topContentOffset;
- (CGPoint)fgl_bottomContentOffset;
- (CGPoint)fgl_leftContentOffset;
- (CGPoint)fgl_rightContentOffset;

- (BOOL)fgl_isScrolledToTop;
- (BOOL)fgl_isScrolledToBottom;
- (BOOL)fgl_isScrolledToLeft;
- (BOOL)fgl_isScrolledToRight;
- (void)fgl_scrollToTopAnimated:(BOOL)animated;
- (void)fgl_scrollToBottomAnimated:(BOOL)animated;
- (void)fgl_scrollToLeftAnimated:(BOOL)animated;
- (void)fgl_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)fgl_YPageCount;
- (NSUInteger)fgl_XPageCount;

- (void)fgl_scrollToYPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)fgl_scrollToXPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
