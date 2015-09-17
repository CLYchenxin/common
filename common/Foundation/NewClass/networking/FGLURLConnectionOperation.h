//
//  FGLURLConnectionOperation.h
//  demo
//
//  Created by chen_xin on 15/9/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FGLNetworkingOperation;

@protocol FGLNetworkingOperationDelegate <NSObject>

@optional
- (void)networkingOperationDidStart:(FGLNetworkingOperation *)operation;
- (void)networkingOperationDidFinish:(FGLNetworkingOperation *)operation;

@end

@interface FGLNetworkingOperation : NSOperation

- (instancetype)initWithURLRequest:(NSURLRequest *)request;
- (instancetype)initWithURLString:(NSString *)URLString;

@property (strong, nonatomic, readonly) NSURLRequest *request;

@property (weak, nonatomic) id<FGLNetworkingOperationDelegate>delegate;

@property (strong, nonatomic, readonly) NSURLResponse *response;
@property (strong, nonatomic, readonly) NSError *error;
@property (strong, nonatomic, readonly) NSData *responseData;
@property (strong, nonatomic, readonly) NSString *responseString;

@end
