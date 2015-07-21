//
//  NSFileManager+FGLFilePath.m
//  question
//
//  Created by 陈昕 on 15/7/20.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSFileManager+FGLFilePath.h"

@implementation NSFileManager (FGLFilePath)

+ (NSString *)fgl_documentsPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)fgl_cachePath
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)fgl_tmpPath
{
    return NSTemporaryDirectory();
}

@end
