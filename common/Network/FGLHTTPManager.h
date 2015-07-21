//
//  FGLHTTPManager.h
//  FGLstion
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FGLHTTPRequest.h"
#import "FGLHTTPResponse.h"

typedef void (^FGLHTTPManagerCompletionHandler)(id<FGLHTTPResponseInterface> response, NSError* error);

typedef enum : NSUInteger {
    FGLHTTPManagerStateNone,
    FGLHTTPManagerStateReady,
    FGLHTTPManagerStateLoading,
    FGLHTTPManagerStateFinished,
} FGLHTTPManagerState;

@protocol FGLHTTPManagerInterface <NSObject>

/**
 *  初始化化方法
 *
 *  @param HTTPRequest     网络请求
 *  @param responseFactory 请求结束之后创建response的工厂类
 *
 */
+ (instancetype)httmManager:(id<FGLHTTPRequestInterface>)HTTPRequest
            responseFactory:(id<FGLHTTPResponseFactoryInterface>)responseFactory;

@property (assign, nonatomic, readonly) FGLHTTPManagerState state;

- (void)start;
- (void)cancel;

- (void)setCompletionHandle:(FGLHTTPManagerCompletionHandler)completionHandle;

@end

@interface FGLHTTPManager : NSObject <FGLHTTPManagerInterface>

@end
