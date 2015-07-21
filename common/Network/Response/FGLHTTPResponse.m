//
//  QUEHTTPResponse.m
//  question
//
//  Created by 陈昕 on 15/7/8.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "FGLHTTPResponse.h"
#import "NSError+FGLErrorCenter.h"

@implementation FGLHTTPResponse

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response data:(NSData *)data
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.rawData = data;

    // 不应该为空
    if (response == nil) {
        abort();
    }

    // 1、检查返回的错误码
    if (response.statusCode != 200) {
        NSDictionary *userInfo = @{
            FGLObjectErrorKey: self,
            FGLFailureAddressErrorKey: @"FGLHTTPResponse->initWithResponse",
            FGLLocalizedDescriptionKey:
                [NSString stringWithFormat:@"服务器返回错误码:%ld, URL是:%@", (long)response.statusCode,
                                           [response.URL absoluteString]]
        };
        self.error = [NSError errorWithDomain:FGLServerErrorDomain code:response.statusCode userInfo:userInfo];
    } else if (data == nil) { // 2、检查返回数据是否为空
        NSDictionary *userInfo = @{
            FGLObjectErrorKey: self,
            FGLFailureAddressErrorKey: @"FGLHTTPResponse->initWithResponse",
            FGLLocalizedDescriptionKey:
                [NSString stringWithFormat:@"服务器返回数据为空, URL是:%@", [response.URL absoluteString]]
        };
        self.error = [NSError errorWithDomain:FGLServerErrorDomain code:102 userInfo:userInfo];
    } else { // 3、开始JSON解析

        NSError *error = nil;
        id jsonResult =
            [NSJSONSerialization JSONObjectWithData:self.rawData options:NSJSONReadingMutableLeaves error:&error];

        if (error) {

            NSString *rawString = [[NSString alloc] initWithData:self.rawData encoding:NSUTF8StringEncoding];

            NSDictionary *userInfo = @{
                FGLObjectErrorKey: self,
                FGLFailureAddressErrorKey: @"FGLHTTPResponse->initWithResponse",
                FGLLocalizedDescriptionKey: [NSString
                    stringWithFormat:@"服务器返回数据JSON解析失败;\n URL是:%@\n,原始数据为:%@",
                                     [response.URL absoluteString], rawString]
            };
            self.error = [NSError errorWithDomain:FGLServerErrorDomain code:103 userInfo:userInfo];
        } else {
            self.fetchData = jsonResult;
        }
    }
    return self;
}

@end