//
//  FGLHTTPResponse.h
//  FGLstion
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGLHTTPRequest.h"

@protocol FGLHTTPResponseInterface <NSObject>

@property (strong, nonatomic, readonly) NSData* rawData; // 原始数据
@property (strong, nonatomic, readonly) NSError* error; // 错误信息
@property (strong, nonatomic, readonly) id fetchData; // 转换后的数据

@end

/**
 *  工厂接口
 */
@protocol FGLHTTPResponseFactoryInterface <NSObject>

- (id<FGLHTTPResponseInterface>)creatResponseWithRequest:(id<FGLHTTPRequestInterface>)request
                                                response:(NSHTTPURLResponse*)response
                                                    data:(NSData*)data;

@end

@interface FGLHTTPResponse : NSObject <FGLHTTPResponseInterface>

@property (strong, nonatomic) NSData* rawData;
@property (strong, nonatomic) NSError* error;
@property (strong, nonatomic) id fetchData;

- (instancetype)initWithResponse:(NSHTTPURLResponse*)response data:(NSData*)data;

@end