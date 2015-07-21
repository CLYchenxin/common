//
//  NSURl+FGLParam.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (FGLParam)

- (NSDictionary *)fgl_parameters;
- (NSString *)fgl_valueForParameter:(NSString *)parameterKey;

@end
