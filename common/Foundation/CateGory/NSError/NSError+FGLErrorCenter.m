//
//  NSError+FGLErrorCenter.m
//  whell
//
//  Created by 陈昕 on 15/7/7.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSError+FGLErrorCenter.h"

NSString *const FGLNetworkErrorDomain = @"FGLNetworkErrorDomain"; 
NSString *const FGLServerErrorDomain = @"FGLServerErrorDomain";   
NSString *const FGLLogicErrorDomain = @"FGLLogicErrorDomain";    

NSString *const FGLLocalizedDescriptionKey = @"FGLLocalizedDescriptionKey";

@implementation NSError (FGLErrorCenter)

- (NSString *)fgl_errorDescription
{
    NSString *message = self.userInfo[FGLLocalizedDescriptionKey];
    if (!message) {
        message = self.localizedDescription;
    }

    assert(message != nil);

    return message;
}

@end
