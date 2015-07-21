//
//  QUEHTTPRequest.m
//  question
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "FGLHTTPRequest.h"

@implementation FGLHTTPRequest

- (instancetype)initWithURL:(NSURL*)URL
{
    if (self = [super init]) {
        _request = [[NSURLRequest alloc] initWithURL:URL];
    }
    return self;
}

- (instancetype)initWithRequest:(NSURLRequest*)request
{
    if (self = [super init]) {
        _request = request;
    }
    return self;
}

@end
