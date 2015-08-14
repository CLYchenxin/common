//
//  FGLRegexManager.h
//  question
//
//  Created by 陈昕 on 15/7/28.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGLRegexManager : NSObject

+ (bool)isPhoneNum:(NSString *)raw;
+ (bool)isURL:(NSString *)raw;
+ (BOOL)isEmail:(NSString *)raw;

/**
 *  6～30位
 *
 *  @param string 密码
 *
 *  @return 格式是否正确
 */
+ (BOOL)isPassword:(NSString *)string;

 /**
 *  @author 陈昕, 15-08-14 16:08:08
 *
 *  判断是否是身份证号码
 *
 *  @param sPaperId 身份证号码
 *
 */
+ (BOOL)isIdentityCard: (NSString *)sPaperId;

/**
 *  @author 陈昕, 15-08-14 16:08:42
 *
 *  判断是否是银联银行卡号
 *
 */
+ (BOOL)isBankNumber:(NSString *)value;

@end
