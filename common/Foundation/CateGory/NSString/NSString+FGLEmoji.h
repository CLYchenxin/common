//
//  NSString+FGLEmoji.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FGLEmoji)

- (NSString *)fgl_stringByReplacingEmojiCheatCodesWithUnicode;
- (NSString *)fgl_stringByReplacingEmojiUnicodeWithCheatCodes;

- (BOOL)fgl_isIncludingEmoji;

- (instancetype)fgl_removedEmojiString;
@end
