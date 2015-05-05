//
//  ScheduleDAO.h
//  PersistenceLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "BaseDAO.h"
#import "Schedule.h"
#import "Events.h"

//比赛日程表， 数据访问对象类
@interface ScheduleDAO : BaseDAO

+ (ScheduleDAO *)sharedManager;

//插入Schedule方法
- (int)create:(Schedule *)model;

//删除Schedule方法
- (int)remove:(Schedule *)model;

//修改Schedule方法
- (int)modify:(Schedule *)model;

//查询所有数据的方法
- (NSMutableArray *)findAll;

//按主键查询数据方法
- (Schedule *)findById:(Schedule *)model;



@end
