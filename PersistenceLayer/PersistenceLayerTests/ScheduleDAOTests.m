//
//  ScheduleDAOTests.m
//  PersistenceLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "ScheduleDAOTests.h"

@implementation ScheduleDAOTests

- (void)setUp{
    self.dao = [ScheduleDAO sharedManager];
    
    //创建Schedule对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameTime = @"test GameTime";
    self.theSchedule.GameInfo = @"test GameInfo";
    self.theSchedule.Event.EventID = 1;
}

- (void)tearDown{
    self.dao = nil;
}

//测试 插入Schedule方法
- (void)test_1_Create{
    int res = [self.dao create:self.theSchedule];
    
    //断言 无异常返回值为 0
    XCTAssertTrue(res == 0,@"数据插入失败");
}

//测试 按照主键查询数据方法
- (void)test_2_FindById{
    self.theSchedule.SchedileID = 502;
    Schedule *resSchedule = [self.dao findById:self.theSchedule];
    //断言 查询结果为非nil
    XCTAssertNotNil(resSchedule,@"查询记录为nil");
    
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate, resSchedule.GameDate,@"比赛日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameTime, resSchedule.GameTime,@"比赛时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameInfo, resSchedule.GameInfo,@"比赛信息测试失败");
    XCTAssertEqual(self.theSchedule.Event.EventID, resSchedule.Event.EventID,@"比赛项目测试失败");
}

//测试  查询所有数据的方法
- (void)test_3_FindAll{

    NSMutableArray *listData = [self.dao findAll];
    //断言 查询记录数为 1
    XCTAssertTrue([listData count] == 1,@"查询记录数期望值为1 实际值为:%i",[listData count]);
    
    Schedule *resSchedule = listData[0];
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate, resSchedule.GameDate,@"比赛日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameTime, resSchedule.GameTime,@"比赛时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameInfo, resSchedule.GameInfo,@"比赛信息测试失败");
    XCTAssertEqual(self.theSchedule.Event.EventID, resSchedule.Event.EventID,@"比赛项目测试失败");
}

//测试 修改数据的方法
- (void)test_4_Modify{
    self.theSchedule.SchedileID = 502;
    self.theSchedule.GameInfo = @"test modifu GameInfo";
    int res = [self.dao modify:self.theSchedule];
   
    //断言， 无异常，返回值为0
    XCTAssertTrue(res == 0,@"数据修改测试失败");
    
    Schedule *resSchedule = [self.dao findById:self.theSchedule];
    //断言
    XCTAssertEqualObjects(self.theSchedule.GameDate, resSchedule.GameDate,@"比赛日期测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameTime, resSchedule.GameTime,@"比赛时间测试失败");
    XCTAssertEqualObjects(self.theSchedule.GameInfo, resSchedule.GameInfo,@"比赛信息测试失败");
    XCTAssertEqual(self.theSchedule.Event.EventID, resSchedule.Event.EventID,@"比赛项目测试失败");
    
}

//测试  删除数据的方法
- (void)test_5_Remove{
    
    int res = [self.dao remove:self.theSchedule];
    
    //断言 无异常，返回值为0
    XCTAssertTrue(res == 0, @"数据删除测试失败");
    
    Schedule *resScheduel = [self.dao findById:self.theSchedule];
    XCTAssertNil(resScheduel,@"记录删除失败");
}

@end
