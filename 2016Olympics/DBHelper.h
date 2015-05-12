//
//  DBHelper.h
//  PersistenceLayer
//
//  Created by ianc on 15/5/4.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface DBHelper : NSObject{
    sqlite3 *db;
}

//获得沙箱Documents目录下的全路径
+ (NSString *)applicationDocumentsDirectoryFile:(NSString *)fileName;

//初始化并加载数据
- (void) initDB;

//从数据库中获得当前数据库的版本号
- (int) dbVersionNumber;

@end
