//
//  NSFileManager+FGLFilePath.h
//  question
//
//  Created by 陈昕 on 15/7/20.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (FGLFilePath)

/**
 *  Documents: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据。
 *
 */
+ (NSString *)fgl_documentsPath;

/**
 *  Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
 *
 */
+ (NSString *)fgl_cachePath;

/**
 *  tmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除
 *
 */
+ (NSString *)fgl_tmpPath;


@end
