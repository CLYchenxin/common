//
//  NSError+FGLErrorCenter.h
//  whell
//
//  Created by 陈昕 on 15/7/7.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络出错,网络断开、链接超时
extern NSString *const FGLNetworkErrorDomain; //  网络链接错误
extern NSString *const FGLServerErrorDomain;  //  服务器返回错误
extern NSString *const FGLLogicErrorDomain;   //  设计上逻辑错误

extern NSString *const FGLLocalizedDescriptionKey; // 错误原因解释

@interface NSError (FGLErrorCenter)

- (NSString *)fgl_errorDescription;

@end
