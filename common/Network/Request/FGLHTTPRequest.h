//
//  FGLHTTPReFGLst.h
//  FGLstion
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FGLHTTPRequestInterface <NSObject>

@property (strong, nonatomic, readonly) NSURLRequest* request;

@end

@interface FGLHTTPRequest : NSObject <FGLHTTPRequestInterface>

@property (strong, nonatomic) NSURLRequest* request;

- (instancetype)initWithURL:(NSURL*)URL;
- (instancetype)initWithRequest:(NSURLRequest*)request;

@end
