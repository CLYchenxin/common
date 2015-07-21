//
//  NSString+FGLMethod.m
//  question
//
//  Created by 陈昕 on 15/7/9.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "NSString+FGLMethod.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FGLMethod)

- (NSString *)fgl_URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
        kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'~();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));

    result = [result stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return result;
}

- (NSString *)fgl_MD5String
{
    // Get the c string from the NSString
    const char *cString = [self UTF8String];
    unsigned char result[16];

    // MD5 encryption
    CC_MD5(cString, (int)strlen(cString), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0],
                                      result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                                      result[8], result[9], result[10], result[11], result[12], result[13], result[14],
                                      result[15]];
}

@end
