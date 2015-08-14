//
//  JKBaseModel.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/27.
//  Copyright (c) 2015年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGLBHelper.h"

/** SQLite五种数据类型 */
#define SQLTEXT @"TEXT"
#define SQLINTEGER @"INTEGER"
#define SQLREAL @"REAL"
#define SQLBLOB @"BLOB"
#define SQLNULL @"NULL"

@interface FGLDBModel : NSObject

/*
 criteria :@"WHERE pk > 5 limit 10"
 */
+ (NSArray *)findAll;
+ (instancetype)findByPK:(NSInteger)inPk;
+ (instancetype)findFirstByCriteria:(NSString *)criteria;
+ (NSArray *)findByCriteria:(NSString *)criteria;
+ (NSArray *)getModelsFromSearchResult:(FMResultSet *)result;

- (BOOL)save;
+ (BOOL)saveObjects:(NSArray *)array;

- (BOOL)deleteObject;
+ (BOOL)deleteAll;
+ (BOOL)deleteObjects:(NSArray *)array;
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria;


+ (BOOL)createTable;


// 用来继承
/**
 *  主键
 *
 *  @return 用来返回主键
 */
+ (NSString *)primaryKey;

@end
