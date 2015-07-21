//
//  NSURl+FGLParam.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSURL+FGLParam.h"

@implementation NSURL (FGLParam)

- (NSDictionary *)fgl_parameters
{
    NSMutableDictionary *parametersDictionary = [NSMutableDictionary dictionary];
    NSArray *queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString *queryComponent in queryComponents) {
        NSString *key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString *value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}
- (NSString *)fgl_valueForParameter:(NSString *)parameterKey
{
    return [[self fgl_parameters] objectForKey:parameterKey];
}


@end
