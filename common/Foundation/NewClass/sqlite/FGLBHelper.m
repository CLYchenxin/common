//
//  JKDataBase.m
//  JKBaseModel
//
//  Created by zx_04 on 15/6/24.
//
//

#import "FGLBHelper.h"
#import "NSFileManager+FGLFilePath.h"

@interface FGLBHelper ()

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

@end

@implementation FGLBHelper

static FGLBHelper *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });

    return _instance;
}

static NSString *p_dbPath;

+ (NSString *)dbPath
{
    if (!p_dbPath) {
        NSString *docsdir = [[NSFileManager fgl_documentsPath] stringByAppendingPathComponent:@"Cache"];
        BOOL isDir;
        BOOL exit = [[NSFileManager defaultManager] fileExistsAtPath:docsdir isDirectory:&isDir];
        if (!exit || !isDir) {
            [[NSFileManager defaultManager] createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        p_dbPath = [docsdir stringByAppendingPathComponent:@"db.sqlite"];
    }
    return p_dbPath;
}

+ (void)setDbPath:(NSString *)dbPath
{
    NSString *docsdir = [[NSFileManager fgl_documentsPath] stringByAppendingPathComponent:@"Cache"];
    BOOL isDir;
    BOOL exit = [[NSFileManager defaultManager] fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    p_dbPath = [docsdir stringByAppendingPathComponent:dbPath];
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}

@end
