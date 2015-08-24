//
//  FGLDB.m
//  question
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "FGLDB.h"
#import "FMDB.h"

@interface FGLDB ()

@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@end

@implementation FGLDB

- (instancetype)initWithDBPath:(NSString *)dbPath
{
    if (self = [super init]) {
        self.dbQueue = [[FMDatabaseQueue alloc] initWithPath:dbPath];
    }
    return self;
}

- (BOOL)executeUpdate:(NSString *)sql
{
    __block BOOL res;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        res = [db executeUpdate:sql];
    }];
    
    return res;
}

- (NSArray *)executeQuery:(NSString *)sql
{
    
    __block NSArray *res;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        
        NSMutableArray *users = [NSMutableArray array];
        while ([result next]) {
            
            NSMutableDictionary *model = [NSMutableDictionary dictionary];
            
            for (int i = 0 ; i < result.columnCount; i++) {
                NSString *key = [result columnNameForIndex:i];
                id value = [result objectForColumnIndex:i];
                
                if (value != [NSNull null]) {
                    model[key] = value;
                }
            }
            
            [users addObject:model];
        }
        
        res = users;
    }];
    
    return res;
}
@end
