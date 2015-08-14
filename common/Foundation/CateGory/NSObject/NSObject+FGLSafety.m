//
//  NSObject+FGLSafety.m
//  KSMei-Cars
//
//  Created by 陈昕 on 15/8/3.
//  Copyright (c) 2015年 tangzhipeng. All rights reserved.
//

#import "NSObject+FGLSafety.h"

@implementation NSObject (FGLSafety)

- (NSString *)fgl_stringValueForKey:(NSString *)key
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    id value = ((NSDictionary *)self)[key];

    if (value == nil || ![value isKindOfClass:[NSString class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSString class]]);

    return value;
}

- (NSArray *)fgl_arrayValueForKey:(NSString *)key
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    id value = ((NSDictionary *)self)[key];

    if (value == nil || ![value isKindOfClass:[NSArray class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSArray class]]);

    return value;
}

- (NSDictionary *)fgl_dictionaryValueForKey:(NSString *)key
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    id value = ((NSDictionary *)self)[key];

    if (value == nil || ![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSDictionary class]]);

    return value;
}

- (NSString *)fgl_stringValueAtIndex:(NSInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSArray *array = (NSArray *)self;
    if (index >= array.count) {
        return nil;
    }

    id value = array[index];

    if (value == nil || ![value isKindOfClass:[NSString class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSString class]]);

    return value;
}

- (NSArray *)fgl_arrayValueAtIndex:(NSInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSArray *array = (NSArray *)self;
    if (index >= array.count) {
        return nil;
    }

    id value = array[index];
    if (value == nil || ![value isKindOfClass:[NSArray class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSArray class]]);

    return value;
}

- (NSDictionary *)fgl_dictionaryValueAtIndex:(NSInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }

    NSArray *array = (NSArray *)self;
    if (index >= array.count) {
        return nil;
    }

    id value = array[index];
    if (value == nil || ![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    assert(value != nil && [value isKindOfClass:[NSDictionary class]]);

    return value;
}

@end
