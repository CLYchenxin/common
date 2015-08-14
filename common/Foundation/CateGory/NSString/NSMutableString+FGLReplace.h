//
//  NSMutableString+FGLReplace.h
//  question
//
//  Created by 陈昕 on 15/7/31.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (FGLReplace)

- (void)fgl_replaceStringForHTML:(NSString *)fromString toString:(NSString *)toString;

@end
