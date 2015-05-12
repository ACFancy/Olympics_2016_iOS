//
//  EventsDAO.m
//  PersistenceLayer
//
//  Created by ianc on 15/4/30.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "EventsDAO.h"

@implementation EventsDAO

static EventsDAO *sharedManager = nil;
+ (EventsDAO *)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       
        sharedManager = [[super alloc] init];
        
    });
    
    return sharedManager;
}

//插入数据的方法
- (int)create:(Events *)model{
    
    if ([self openDB]) {
        NSString *sqlStr = @"insert into Events (EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo) Values(?,?,?,?,?)";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.EventName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.EventIcon UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.KeyInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.BasicsInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.OlympicInfo UTF8String], -1, NULL);
            
            //执行插入
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"插入数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}
//删除数据的方法
- (int)remove:(Events *)model{
    if ([self openDB]) {
        //先删除子表（比赛日程表）相关数据
        NSString *sqlScheduleStr = [NSString stringWithFormat:@"Delete from Schedule where EventID = %lu",(unsigned long)model.EventID];
        
        char *err;
        
        //开启事务，立刻提交之前的事务
        sqlite3_exec(db, [@"BEGIN IMMEDIATE TRANSACTION" UTF8String], NULL, NULL, &err);
        
        if (sqlite3_exec(db, [sqlScheduleStr UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, [@"ROLLBACK TRANSACTION" UTF8String], NULL, NULL, NULL);
            NSAssert(NO, @"删除数据失败");
        }
        
        //先删除主表 （比赛项目）数据
        NSString *sqlEventStr = [NSString stringWithFormat:@"Delete from Events where EventID = %lu",(unsigned long)model.EventID];
        
        if (sqlite3_exec(db, [sqlEventStr UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, [@"ROLLBACK TRANSACTION" UTF8String], NULL, NULL, &err);
            NSAssert(NO, @"删除数据失败");
        }
        
        //提交事务
        sqlite3_exec(db, [@"COMMIT TRANSACTION" UTF8String], NULL, NULL, &err);
        sqlite3_close(db);
        
    }
    return 0;
}
//修改数据的方法
- (int)modify:(Events *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"Update Events set EventName=?,EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID = ?";
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.EventName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.EventIcon UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.KeyInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.BasicsInfo UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 5, [model.OlympicInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 6, (int)model.EventID);
            
            //执行
            if (sqlite3_step(statement) !=SQLITE_DONE) {
                NSAssert(NO, @"修改数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}
//查询所有数据的方法
- (NSMutableArray *)findAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    if ([self openDB]) {
        NSString *qsql = @"Select EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID from Events";
        sqlite3_stmt *statement;
        //预处理
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //执行
            while (sqlite3_step(statement) == SQLITE_ROW) {
                Events *events = [[Events alloc] init];
                
                char *cEventName = (char *)sqlite3_column_text(statement, 0);
                events.EventName = [NSString stringWithUTF8String:cEventName];
                
                char *cEventIcon = (char *)sqlite3_column_text(statement, 1);
                events.EventIcon = [NSString stringWithUTF8String:cEventIcon];
                
                char *cKeyInfo = (char *)sqlite3_column_text(statement, 2);
                events.KeyInfo = [NSString stringWithUTF8String:cKeyInfo];
                
                char *cBasicsInfo = (char *)sqlite3_column_text(statement, 3);
                events.BasicsInfo = [NSString stringWithUTF8String:cBasicsInfo];
                
                char *cOlympicInfo = (char *)sqlite3_column_text(statement, 4);
                events.OlympicInfo = [NSString stringWithUTF8String:cOlympicInfo];
                
                events.EventID =sqlite3_column_int(statement, 5);
                
                [listData addObject:events];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return listData;
}
//按照主键查询数据的方法
- (Events *)findById:(Events *)model{
    if ([self openDB]) {
        
     NSString *sqlStr = @"select EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID from Events Where EventID = ?";
     
        
     sqlite3_stmt *statement;
     //预处理
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数
            sqlite3_bind_int(statement, 1,(int)model.EventID);
            if (sqlite3_step(statement) == SQLITE_ROW) {
                Events *events = [[Events alloc] init];
                
                char *cEventName = (char *)sqlite3_column_text(statement, 0);
                events.EventName = [NSString stringWithUTF8String:cEventName];
                
                char *cEventIcon = (char *)sqlite3_column_text(statement, 1);
                events.EventIcon = [NSString stringWithUTF8String:cEventIcon];
                
                char *cKeyInfo = (char *)sqlite3_column_text(statement, 2);
                events.KeyInfo = [NSString stringWithUTF8String:cKeyInfo];
                
                char *cBasicsInfo = (char *)sqlite3_column_text(statement, 3);
                events.BasicsInfo = [NSString stringWithUTF8String:cBasicsInfo];
                
                char *cOlympicInfo = (char *)sqlite3_column_text(statement, 4);
                events.OlympicInfo = [NSString stringWithUTF8String:cOlympicInfo];
                
                events.EventID = sqlite3_column_int(statement, 5);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                return events;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}

@end
