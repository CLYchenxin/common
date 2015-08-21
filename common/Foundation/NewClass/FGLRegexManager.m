//
//  FGLRegexManager.m
//  question
//
//  Created by 陈昕 on 15/7/28.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "FGLRegexManager.h"

@implementation FGLRegexManager

+ (bool)isPhoneNum:(NSString *)raw
{
    return [self string:raw isMatchRegex:@"^1[3-8]\\d{9}$"];
}

+ (bool)isURL:(NSString *)raw
{
    NSURL *candidateURL = [NSURL URLWithString:raw];
    return candidateURL && candidateURL.scheme && candidateURL.host;
}

+ (BOOL)isEmail:(NSString *)raw
{
    return [self string:raw isMatchRegex:@"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"];
}

+ (BOOL)isPassword:(NSString *)string
{
    return [self string:string isMatchRegex:@"^[\\@A-Za-z0-9\\!\\#\\$\\%\\^\\&\\*\\.\\~]{6,30}$"];
}

+ (BOOL)string:(NSString *)string isMatchRegex:(NSString *)reg
{
    if (string == nil) {
        return NO;
    }

    NSRegularExpression *regularexpression =
        [[NSRegularExpression alloc] initWithPattern:reg options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:string
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, string.length)];
    return numberofMatch > 0;
}

//#pragma mark - 身份证识别
//+ (BOOL)isIdentityCard:(NSString *)sPaperId
//{
//    //判断位数
//    if ([sPaperId length] < 15 || [sPaperId length] > 18) {
//
//        return NO;
//    }
//
//    NSString *carid = sPaperId;
//    long lSumQT = 0;
//    //加权因子
//    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
//    //校验码
//    unsigned char sChecker[11] = {'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};
//
//    //将15位身份证号转换成18位
//
//    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
//    if ([sPaperId length] == 15) {
//
//
//        [mString insertString:@"19" atIndex:6];
//
//        long p = 0;
//        const char *pid = [mString UTF8String];
//        for (int i = 0; i <= 16; i++) {
//            p += (pid[i] - 48) * R[i];
//        }
//
//        int o = p % 11;
//        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
//        [mString insertString:string_content atIndex:[mString length]];
//        carid = mString;
//    }
//
//    //判断地区码
//    NSString *sProvince = [carid substringToIndex:2];
//
//    if (![KSUtils areaCode:sProvince]) {
//
//        return NO;
//    }
//
//    //判断年月日是否有效
//
//    //年份
//    int strYear = [[KSUtils getStringWithRange:carid Value1:6 Value2:4] intValue];
//    //月份
//    int strMonth = [[KSUtils getStringWithRange:carid Value1:10 Value2:2] intValue];
//    //日
//    int strDay = [[KSUtils getStringWithRange:carid Value1:12 Value2:2] intValue];
//
//
//    NSTimeZone *localZone = [NSTimeZone localTimeZone];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
//    [dateFormatter setTimeZone:localZone];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date =
//        [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
//    if (date == nil) {
//
//        return NO;
//    }
//
//    const char *PaperId = [[carid uppercaseString] UTF8String];
//
//    //检验长度
//    if (18 != strlen(PaperId)) return -1;
//    //校验数字
//    for (int i = 0; i < 18; i++) {
//        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i)) {
//            return NO;
//        }
//    }
//    //验证最末的校验码
//    for (int i = 0; i <= 16; i++) {
//        lSumQT += (PaperId[i] - 48) * R[i];
//    }
//    if (sChecker[lSumQT % 11] != PaperId[17]) {
//        return NO;
//    }
//
//    return YES;
//}

+ (BOOL)isBankNumber:(NSString *)value
{
    NSString *lastNum = [[value substringFromIndex:(value.length - 1)] copy];  //取出最后一位
    NSString *forwardNum = [[value substringToIndex:(value.length - 1)] copy]; //前15或18位

    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {

        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }

    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = (forwardArr.count - 1); i > -1; i--) { //前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }

    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];  //奇数位*2的积 < 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0]; //奇数位*2的积 > 9
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0]; //偶数位数组

    for (int i = 0; i < forwardDescArr.count; i++) {

        int num = [forwardDescArr[i] intValue];

        if (i % 2) { //偶数位
            [arrEvenNum addObject:[NSNumber numberWithInt:num]];
        } else { //奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInt:num * 2]];
            } else {
                int decadeNum = (num * 2) / 10;
                int unitNum = (num * 2) % 10;

                [arrOddNum2 addObject:[NSNumber numberWithInt:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInt:decadeNum]];
            }
        }
    }

    __block NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {

        sumOddNumTotal += [obj integerValue];

    }];


    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {

        sumOddNum2Total += [obj integerValue];

    }];

    __block NSInteger sumEvenNumTotal = 0;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {

        sumEvenNumTotal += [obj integerValue];

    }];

    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;

    return (luhmTotal % 10 == 0) ? YES : NO;
}

@end
