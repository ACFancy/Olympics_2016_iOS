//
//  DBHelper.m
//  PersistenceLayer
//
//  Created by ianc on 15/5/4.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

//获得沙箱Documents目录下的全路径
+ (NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    return path;
}

//初始化并加载数据
- (void) initDB{
    NSString *configTablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"DBConfig" ofType:@"plist"];
    NSDictionary *configTable = [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //从配置文件获得数据库版本号
    NSNumber *dbConfigVersion = [configTable objectForKey:@"DB_VERSION"];
    //从数据库DBVersionInfo表记录中返回数据库版本号
    int versionNumber = [self dbVersionNumber];
    
    //版本号不一致
    if ([dbConfigVersion intValue] != versionNumber) {
        NSString  *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
       
        if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSAssert(NO, @"数据库打开失败");
        }else{
          //加载数据到业务表中
            NSLog(@"数据库升级...");
            char *err;
            NSString *createtablePath = [[NSBundle bundleForClass:[self class]]  pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql = [[NSString alloc] initWithContentsOfFile:createtablePath encoding:NSUTF8StringEncoding error:nil];
            if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"数据库升级失败的原因：%@", [NSMutableString stringWithCString:err encoding:NSUTF8StringEncoding]);
               
            }
            
            //把当前版本号写回到文件中
            NSString *usql = [[NSString alloc] initWithFormat:@"update DBVersionInfo set version_number = %i",[dbConfigVersion intValue]];
            if (sqlite3_exec(db, [usql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
                NSLog(@"更新DBVersionInfo 失败");
            }
            sqlite3_close(db);
            
        }
       
    }
}

//从数据库中获得当前数据库的版本号
- (int) dbVersionNumber{
    NSString *dbfilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    int versionNumber = -1;
    
    if (sqlite3_open([dbfilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    }else{
        NSString *sql = @"Create table if not exists DBVersionInfo (version_number int);";
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
            NSAssert(NO, @"创建表失败");
        }
        
        NSString *qsql = @"select version_number from DBVersionInfo";
        
        sqlite3_stmt *statement;
        //预处理
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
             //有数据情况
                NSLog(@"有数据");
                versionNumber = sqlite3_column_int(statement, 0);
            }else{
             //没有数据
                NSLog(@"无数据");
                NSString *csql = @"insert into DBVersionInfo (version_number) values(-1)";
                if (sqlite3_exec(db, [csql UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
                    NSAssert(NO, @"插入数据失败");
                }
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    
    }
    
    return versionNumber;
}

@end
