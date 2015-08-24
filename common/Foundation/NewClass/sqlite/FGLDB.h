//
//  FGLDB.h
//  question
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGLDB : NSObject

- (instancetype)initWithDBPath:(NSString *)dbPath;

- (BOOL)executeUpdate:(NSString *)sql;
- (NSArray *)executeQuery:(NSString *)sql;

@end
