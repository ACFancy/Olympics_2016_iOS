//
//  ScheduleDAO.m
//  PersistenceLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "ScheduleDAO.h"

@implementation ScheduleDAO
static ScheduleDAO *sharedManager;

+ (ScheduleDAO *)sharedManager{
    dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

//插入Schedule方法
- (int)create:(Schedule *)model{
    if ([self openDB]) {
        
       NSString *sqlStr = @"insert into Schedule(GameDate,GameTime,GameInf,EventID) Values(?,?,?,?)";
        
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数
            sqlite3_bind_text(statement, 1, [model.GameDate UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.GameTime UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.GameInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statement,4,(int)model.Event.EventID);
            
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"插入数据失败");
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return  0;
}

//删除Schedule方法
- (int)remove:(Schedule *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"Delete from Schedule where ScheduleID = ？";
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数
            sqlite3_bind_int(statement, 1, (int)model.Event.EventID);
            
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"删除数据失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}

//修改Schedule方法
- (int)modify:(Schedule *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"Update Schedule set GameDate = ?,GameTime = ? ,GameInfo = ? where ScheduleID = ?";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //绑定参数
            sqlite3_bind_text(statement, 1, [model.GameDate UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.GameTime UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [model.GameInfo UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 4,(int)model.SchedileID);
            
            if (sqlite3_step(statement) != SQLITE_DONE) {
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
    NSMutableArray *listData = [NSMutableArray array];
    if ([self openDB]) {
      NSString *sqlStr = @"select GameDate,GameTime,GameInfo,EventID,ScheduleID from Schedule";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                Schedule *schedule = [[Schedule alloc] init];
                Events *event = [[Events alloc] init];
                schedule.Event = event;
                
                char *cGameDate = (char *)sqlite3_column_text(statement, 0);
                schedule.GameDate = [NSString stringWithUTF8String:cGameDate];
                
                char *cGameTime = (char *)sqlite3_column_text(statement, 1);
                schedule.GameTime = [NSString stringWithUTF8String:cGameTime];
                
                char *cGameInfo = (char *)sqlite3_column_text(statement, 2);
                schedule.GameInfo = [NSString stringWithUTF8String:cGameInfo];
                
                schedule.Event.EventID = sqlite3_column_int(statement, 3);
                schedule.SchedileID = sqlite3_column_int(statement, 4);
                
                [listData addObject:schedule];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return listData;
}

//按主键查询数据方法
- (Schedule *)findById:(Schedule *)model{
    if ([self openDB]) {
        NSString *sqlStr = @"select GameDate,GameTime,GameInfo,EventID,ScheduleID from Schedule where ScheduleID = ?";
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            //绑定参数
            sqlite3_bind_int(statement, (int)model.SchedileID, 1);
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
                Schedule *schedule = [[Schedule alloc] init];
                Events *event = [[Events alloc] init];
                schedule.Event = event;
                
                char *cGameDate = (char *)sqlite3_column_text(statement, 0);
                schedule.GameDate = [NSString stringWithUTF8String:cGameDate];
                
                char *cGameTime = (char *)sqlite3_column_text(statement, 1);
                schedule.GameTime = [NSString stringWithUTF8String:cGameTime];
                
                char *cGameInfo = (char *)sqlite3_column_text(statement, 2);
                schedule.GameInfo = [NSString stringWithUTF8String:cGameInfo];
                
                schedule.Event.EventID = sqlite3_column_int(statement, 3);
                schedule.SchedileID = sqlite3_column_int(statement, 4);
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                return schedule;
            }
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}



@end
