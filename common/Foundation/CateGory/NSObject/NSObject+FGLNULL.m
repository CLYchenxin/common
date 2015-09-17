//
//  NSObject+FGLNULL.m
//  demo
//
//  Created by chen_xin on 15/8/31.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSObject+FGLNULL.h"

@implementation NSObject (FGLNULL)

- (BOOL)fgl_isNull
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    } else {
        if ([self isKindOfClass:[NSNull class]]) {
            return YES;
        } else {
            if (self==nil) {
                return YES;
            }
        }
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    
    return NO;
}

@end
