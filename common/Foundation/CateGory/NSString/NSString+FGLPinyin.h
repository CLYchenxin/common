//
//  NSString+FGLPinyin.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FGLPinyin)

- (NSString *)fgl_pinyinWithPhoneticSymbol;
- (NSString *)fgl_pinyin;
- (NSArray *)fgl_pinyinArray;
- (NSString *)fgl_pinyinWithoutBlank;
- (NSArray *)fgl_pinyinInitialsArray;
- (NSString *)fgl_pinyinInitialsString;

@end
