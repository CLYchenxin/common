//
//  NSError+FGLErrorCenter.h
//  whell
//
//  Created by 陈昕 on 15/7/7.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

// 接受到错误信息时，发出的错误通知
extern NSString *const FGLDidReceiveErrorNotification;

// 网络出错,网络断开、链接超时
extern NSString *const FGLNetworkErrorDomain;
extern NSString *const FGLServerErrorDomain; // 服务器错误,404错误,
extern NSString *const FGLLogicErrorDomain;  // 设计上逻辑错误

// 错误信息
extern NSString *const FGLFailureAddressErrorKey;  // 错误发生的地点
extern NSString *const FGLObjectErrorKey;          // 抛出错误发生的对象
extern NSString *const FGLLocalizedDescriptionKey; // 错误原因解释

@interface NSError (FGLErrorCenter)

@end
