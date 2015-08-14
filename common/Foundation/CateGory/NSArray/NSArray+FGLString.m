//
//  NSArray+FGLString.m
//  question
//
//  Created by 陈昕 on 15/7/29.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSArray+FGLString.h"

@implementation NSArray (FGLString)

- (NSArray *)fgl_arrayByRemoveString:(NSString *)aString
{
    NSMutableArray *result = [NSMutableArray array];

    for (id value in self) {
        assert([value isKindOfClass:[NSString class]]);

        if (![value isEqualToString:aString]) {
            [result addObject:value];
        }
    }

    return result;
}

- (NSArray *)fgl_arrayByRemoveSameString
{
    NSSet *set = [NSSet setWithArray:self];
    return set.allObjects;
}

@end
