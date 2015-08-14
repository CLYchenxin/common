//
//  NSArray+FGLString.h
//  question
//
//  Created by 陈昕 on 15/7/29.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FGLString)

- (NSArray *)fgl_arrayByRemoveString:(NSString *)aString;
- (NSArray *)fgl_arrayByRemoveSameString;

@end
