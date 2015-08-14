//
//  JKDataBase.h
//  JKBaseModel
//
//  Created by zx_04 on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FGLBHelper : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;

+ (FGLBHelper *)shareInstance;

+ (NSString *)dbPath;

@end
