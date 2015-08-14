//
//  JKBaseModel.m
//  JKBaseModel
//
//  Created by zx_04 on 15/6/27.
//  Copyright (c) 2015年 joker. All rights reserved.
//

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#define debugError() NSLog(@"Error at %s Line:%d", __func__, __LINE__)
#else
#define debugLog(...)
#define debugMethod()
#define debugError()
#endif


#import "FGLDBModel.h"

#import <objc/runtime.h>

@interface FGLDBModel ()
/** 列名 */
@property (retain, readonly, nonatomic) NSArray *columeNames;
/** 列类型 */
@property (retain, readonly, nonatomic) NSArray *columeTypes;
@end

@implementation FGLDBModel

#pragma mark - Init

+ (void)initialize
{
    if (self != [FGLDBModel self]) {
        [self createTable];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [self.class getPropertys];
        _columeNames = dic[@"name"];
        _columeTypes = dic[@"type"];
    }
    return self;
}

#pragma mark - Public

- (BOOL)save
{
    debugMethod();

    NSString *sql;
    NSArray *insertValues;

    [self p_saveSql:&sql insertValues:&insertValues];

    __block BOOL res = NO;
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        res = [db executeUpdate:sql withArgumentsInArray:insertValues];
    }];
    return res;
}

+ (BOOL)saveObjects:(NSArray *)array
{
    debugMethod();
    //判断是否是JKBaseModel的子类
    for (id model in array) {
        assert([model isKindOfClass:[FGLDBModel class]]);
    }

    NSString *sql;
    NSMutableArray *insertValuesArray = [NSMutableArray array];

    for (FGLDBModel *model in array) {
        NSArray *insertValues;

        [model p_saveSql:&sql insertValues:&insertValues];
        [insertValuesArray addObject:insertValues];
    }

    __block BOOL res = YES;
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        for (int i = 0; i < insertValuesArray.count; i++) {
            NSArray *insertValues = insertValuesArray[i];
            if (![db executeUpdate:sql withArgumentsInArray:insertValues]) {
                res = NO; // 保存失败
            }
        }
    }];
    return res;
}

/** 删除单个对象 */
- (BOOL)deleteObject
{
    debugMethod();
    assert([self.class primaryKey] != nil);
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        id primaryValue = [self valueForKey:[self.class primaryKey]];
        if (!primaryValue || primaryValue <= 0) {
            return;
        }
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", tableName, [self.class primaryKey]];
        res = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
    }];
    return res;
}

/** 批量删除用户对象 */
+ (BOOL)deleteObjects:(NSArray *)array
{
    debugMethod();
    for (FGLDBModel *model in array) {
        if (![model isKindOfClass:[FGLDBModel class]]) {
            return NO;
        }
    }

    assert([self primaryKey] != nil);

    __block BOOL res = YES;
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    // 如果要支持事务
    [jkDB.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (FGLDBModel *model in array) {
            NSString *tableName = NSStringFromClass(model.class);
            id primaryValue = [model valueForKey:[self primaryKey]];
            NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", tableName, [self primaryKey]];
            BOOL flag = [db executeUpdate:sql withArgumentsInArray:@[primaryValue]];
            if (!flag) {
                res = NO;
                *rollback = YES;
                return;
            }
        }
    }];
    return res;
}

/** 通过条件删除数据 */
+ (BOOL)deleteObjectsByCriteria:(NSString *)criteria
{
    debugMethod();
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@ ", tableName, criteria];
        res = [db executeUpdate:sql];
    }];
    return res;
}

/** 清空表 */
+ (BOOL)deleteAll
{
    debugMethod();
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    __block BOOL res = NO;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        res = [db executeUpdate:sql];
    }];
    return res;
}

/** 查询全部数据 */
+ (NSArray *)findAll
{
    debugMethod();
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    __block NSArray *users;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        users = [self getModelsFromSearchResult:resultSet];
    }];

    assert(users != nil);

    return users;
}

/** 查找某条数据 */
+ (instancetype)findFirstByCriteria:(NSString *)criteria
{
    NSArray *results = [self.class findByCriteria:criteria];
    if (results.count < 1) {
        return nil;
    }

    return [results firstObject];
}

+ (instancetype)findByPK:(NSInteger)inPk
{
    NSString *condition = [NSString stringWithFormat:@"WHERE %@=%ld", [self primaryKey], (long)inPk];
    return [self findFirstByCriteria:condition];
}

/** 通过条件查找数据 */
+ (NSArray *)findByCriteria:(NSString *)criteria
{
    debugMethod();
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    __block NSArray *users;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ ", tableName, criteria];
        FMResultSet *resultSet = [db executeQuery:sql];
        users = [self getModelsFromSearchResult:resultSet];
    }];

    assert(users != nil);

    return users;
}

+ (NSArray *)getModelsFromSearchResult:(FMResultSet *)result
{
    NSMutableArray *users = [NSMutableArray array];
    while ([result next]) {
        FGLDBModel *model = [[self.class alloc] init];
        for (int i = 0; i < model.columeNames.count; i++) {
            NSString *columeName = [model.columeNames objectAtIndex:i];
            NSString *columeType = [model.columeTypes objectAtIndex:i];
            if ([columeType isEqualToString:SQLTEXT]) {
                [model setValue:[result stringForColumn:columeName] forKey:columeName];
            } else {
                [model setValue:[NSNumber numberWithLongLong:[result longLongIntForColumn:columeName]]
                         forKey:columeName];
            }
        }
        [users addObject:model];
        FMDBRelease(model);
    }

    return users;
}

/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)createTable
{
    __block BOOL res = YES;
    FGLBHelper *jkDB = [FGLBHelper shareInstance];

    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:[self getCreatTableSql]]) {
            assert(NO); // 创建表失败
        }
    }];

    return res;
}

+ (NSString *)primaryKey
{
    return nil;
}

#pragma mark - Private

+ (NSString *)getCreatTableSql
{
    NSMutableString *pars = [NSMutableString string];
    NSDictionary *dict = [self.class getPropertys];

    NSMutableArray *proNames = [dict objectForKey:@"name"];
    NSMutableArray *proTypes = [dict objectForKey:@"type"];

    for (int i = 0; i < proNames.count; i++) {
        [pars appendFormat:@"%@ %@", proNames[i], proTypes[i]];

        if ([[self primaryKey] isEqualToString:proNames[i]]) {
            [pars appendString:@" PRIMARY KEY"];
        }

        if (i + 1 != proNames.count) {
            [pars appendString:@","];
        }
    }

    NSString *tableName = NSStringFromClass(self.class);
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);", tableName, pars];

    return sql;
}

/**
 *  获取该类的所有属性
 */
+ (NSDictionary *)getPropertys
{
    NSMutableArray *proNames = [NSMutableArray array];
    NSMutableArray *proTypes = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [proNames addObject:propertyName];

        //获取属性类型等参数
        NSString *propertyType =
            [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];

        /*
         各种符号对应类型，部分类型在新版SDK中有所变化，如long 和long long
         c char         C unsigned char
         i int          I unsigned int
         l long         L unsigned long
         s short        S unsigned short
         d double       D unsigned double
         f float        F unsigned float
         q long long    Q unsigned long long
         B BOOL
         @ 对象类型 //指针 对象类型 如NSString 是@“NSString”


         64位下long 和long long 都是Tq
         SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
         因为在项目中用的类型不多，故只考虑了少数类型
         */

        BOOL isStringType = [propertyType hasPrefix:@"T@"];
        BOOL isIntType = [propertyType hasPrefix:@"Ti"] || [propertyType hasPrefix:@"TI"] ||
                     [propertyType hasPrefix:@"Ts"] || [propertyType hasPrefix:@"TS"] ||
                     [propertyType hasPrefix:@"TB"] || [propertyType hasPrefix:@"Tq"];


        if (isStringType) {
            [proTypes addObject:SQLTEXT];
        } else if (isIntType) {
            [proTypes addObject:SQLINTEGER];
        } else {
            [proTypes addObject:SQLREAL];
        }
    }
    free(properties);

    return @{ @"type": proTypes, @"name": proNames };
}

/** 数据库中是否存在表 */
+ (BOOL)isExistInTable
{
    __block BOOL res = NO;
    FGLBHelper *jkDB = [FGLBHelper shareInstance];
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        res = [db tableExists:tableName];
    }];
    return res;
}

- (void)p_saveSql:(NSString **)sql insertValues:(NSArray **)insertValues
{
    NSString *tableName = NSStringFromClass(self.class);
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *valueString = [NSMutableString string];
    NSMutableArray *pinsertValues = [NSMutableArray array];

    for (int i = 0; i < self.columeNames.count; i++) {
        NSString *proname = [self.columeNames objectAtIndex:i];

        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];

        id value = [self valueForKey:proname];
        if (!value) {
            value = @"";
        }
        [pinsertValues addObject:value];
    }

    [keyString deleteCharactersInRange:NSMakeRange(keyString.length - 1, 1)];
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];

    *sql = [NSString stringWithFormat:@"REPLACE INTO %@(%@) VALUES (%@);", tableName, keyString, valueString];
    *insertValues = pinsertValues;

    return;
}

@end
