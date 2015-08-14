//
//  NSDate+FGLUtil.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FGLUtil)

- (NSString *)fgl_frendlyDescription;

/**
 *  @author 陈昕, 15-08-11 16:08:34
 *
 *  两个日期之间的天数，8月9号22:00和时间8-10号1:00之间间隔一天，8-9号7:00和8-9号19:00间隔0天
 *
 *
 *  @return 间隔天数
 */
- (NSInteger)fgl_daySpaceWithDate:(NSDate *)date;

@end
