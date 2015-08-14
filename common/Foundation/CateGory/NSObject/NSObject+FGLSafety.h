//
//  NSObject+FGLSafety.h
//  KSMei-Cars
//
//  Created by 陈昕 on 15/8/3.
//  Copyright (c) 2015年 tangzhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FGLSafety)

- (NSString *)fgl_stringValueForKey:(NSString *)key;
- (NSArray *)fgl_arrayValueForKey:(NSString *)key;
- (NSDictionary *)fgl_dictionaryValueForKey:(NSString *)key;

- (NSString *)fgl_stringValueAtIndex:(NSInteger)index;
- (NSArray *)fgl_arrayValueAtIndex:(NSInteger)index;
- (NSDictionary *)fgl_dictionaryValueAtIndex:(NSInteger)index;

@end
