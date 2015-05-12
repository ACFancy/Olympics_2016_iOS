//
//  BaseDAO.h
//  PersistenceLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DBHelper.h"

@interface BaseDAO : NSObject{
    sqlite3 *db;
}

//数据库文件全路径
@property (nonatomic, strong) NSString *dbFilePath;

//打开SQLite数据库 。如果返回true表示成功打开，返回false 表示打开失败；
- (BOOL)openDB;

@end
