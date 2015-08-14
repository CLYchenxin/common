//
//  NSMutableString+FGLReplace.m
//  question
//
//  Created by 陈昕 on 15/7/31.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSMutableString+FGLReplace.h"

@implementation NSMutableString (FGLReplace)

- (void)fgl_replaceStringForHTML:(NSString *)fromString toString:(NSString *)toString
{
    [self replaceOccurrencesOfString:fromString withString:toString options:NSDiacriticInsensitiveSearch range:NSMakeRange(0, self.length)];
}

@end
