//
//  NSDate+FGLUtil.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSDate+FGLUtil.h"

@implementation NSDate (FGLUtil)

+ (NSDateFormatter *)p_formatter
{
    static NSDateFormatter *formatter = nil;

    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    return formatter;
}

- (NSString *)fgl_frendlyDescription
{
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    NSInteger minute = fabs(timeInterval / 60);

    if (minute < 60) {
        if (minute < 1) return @"刚刚";

        return [NSString stringWithFormat:@"%ld 分钟前", (long)(minute <= 1 ? 1 : minute)];
    } else {
        NSInteger hour = (minute / 60);
        if (hour < 24) {
            return [NSString stringWithFormat:@"%ld 小时前", (long)(hour <= 1 ? 1 : hour)];
        } else {
            NSInteger day = (hour / 24);

            if (day == 1) {
                NSString *shortDate = [self p_shortDateString];
                return [NSString stringWithFormat:@"昨天 %@ ", shortDate];
            }

            return [self p_dateString];
        }
    }
}

- (NSString *)p_shortDateString
{
    NSDateFormatter *f = [NSDate p_formatter];
    [f setDateFormat:@"h:mm"];
    return [f stringFromDate:self];
}

- (NSString *)p_dateString
{
    NSDateFormatter *f = [NSDate p_formatter];
    [f setDateFormat:@"M月d日 hh:mm"];
    return [f stringFromDate:self];
}

@end
