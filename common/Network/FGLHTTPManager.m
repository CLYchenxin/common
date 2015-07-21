//
//  FGLHTTPManager.m
//  FGLstion
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "FGLHTTPManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSError+FGLErrorCenter.h"

@interface FGLHTTPManager ()

@property (strong, nonatomic, readonly) AFHTTPRequestOperation *operation;
@property (strong, nonatomic, readonly) NSOperationQueue *taskQueue;
@property (strong, nonatomic, readonly) id<FGLHTTPRequestInterface> HTTPRequest;

@property (strong, nonatomic) id<FGLHTTPResponseFactoryInterface> responseFactory;

@end

@implementation FGLHTTPManager

@synthesize taskQueue = _taskQueue;

+ (instancetype)httmManager:(id<FGLHTTPRequestInterface>)HTTPRequest
            responseFactory:(id<FGLHTTPResponseFactoryInterface>)responseFactory
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:HTTPRequest.request];
    FGLHTTPManager *manager = [[FGLHTTPManager alloc] initWithOperation:operation HTTPRequest:HTTPRequest];
    manager.responseFactory = responseFactory;
    return manager;
}

- (instancetype)initWithOperation:(AFHTTPRequestOperation *)operation
                      HTTPRequest:(id<FGLHTTPRequestInterface>)HTTPRequest
{
    if (self = [super init]) {
        _operation = operation;
        _HTTPRequest = HTTPRequest;

        // 设置返回值的解析方式, 设置成什么都不做, 使用原始数据
        _operation.responseSerializer = [[AFHTTPResponseSerializer alloc] init];

        // 设置网络请求接受的数据类型
        NSArray *acceptTypes = @[@"application/json", @"text/json", @"text/html"];
        _operation.responseSerializer.acceptableContentTypes = [NSSet setWithArray:acceptTypes];
    }
    return self;
}

- (void)start
{
    [self.taskQueue addOperation:self.operation];
}

- (void)cancel
{
    [self.operation cancel];
}

- (void)setCompletionHandle:(FGLHTTPManagerCompletionHandler)completionHandle
{

    // 防止变量提前释放
    id<FGLHTTPRequestInterface> HTTPRequest = self.HTTPRequest;
    id<FGLHTTPResponseFactoryInterface> responseFactory = self.responseFactory;

    [self.operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        id<FGLHTTPResponseInterface> res = [responseFactory creatResponseWithRequest:HTTPRequest
                                                                            response:operation.response
                                                                                data:operation.responseData];

        if (completionHandle && res.error) {

            [[NSNotificationCenter defaultCenter] postNotificationName:FGLDidReceiveErrorNotification
                                                                object:res.error
                                                              userInfo:res.error.userInfo];

            completionHandle(nil, res.error);
        } else if (completionHandle) {
            completionHandle(res, nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSDictionary *userInfo = @{
            FGLFailureAddressErrorKey: @"FGLHTTPManager->setCompletionHandle",
            FGLLocalizedDescriptionKey: error.localizedDescription
        };

        NSError *err = [NSError errorWithDomain:FGLNetworkErrorDomain code:error.code userInfo:userInfo];

        [[NSNotificationCenter defaultCenter] postNotificationName:FGLDidReceiveErrorNotification
                                                            object:err
                                                          userInfo:err.userInfo];

        if (completionHandle) {
            completionHandle(nil, err);
        }
    }];
}

/*--------------------------------------------------------------------------------------------------------------
 *--------------------------------------------------------------------------------------------------------------

 Set,Get方法

 ---------------------------------------------------------------------------------------------------------------*
 ---------------------------------------------------------------------------------------------------------------*/
#pragma mark - Get

- (FGLHTTPManagerState)state
{
    if (self.operation.isReady) {
        return FGLHTTPManagerStateReady;
    } else if (self.operation.isExecuting) {
        return FGLHTTPManagerStateLoading;
    } else if (self.operation.isFinished) {
        return FGLHTTPManagerStateFinished;
    }
    return FGLHTTPManagerStateNone;
}

#pragma mark - Set

- (NSOperationQueue *)taskQueue
{
    static NSOperationQueue *queue;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 2;
    });

    return queue;
}

@end
