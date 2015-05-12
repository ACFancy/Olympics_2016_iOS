//
//  EventsDAOTests.m
//  PersistenceLayer
//
//  Created by ianc on 15/5/4.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "EventsDAOTests.h"

@implementation EventsDAOTests

- (void)setUp{
    //创建EventsDAO对象
    self.dao = [EventsDAO sharedManager];
    //创建Events对象
    self.theEvents = [[Events alloc] init];
    self.theEvents.EventName = @"test EventName";
    self.theEvents.EventIcon = @"test EventIcon";
    self.theEvents.KeyInfo = @"test KeyInof";
    self.theEvents.BasicsInfo = @"test BasicsInfo";
    self.theEvents.OlympicInfo = @"test OlympicInfo";
}

- (void)tearDown{
    self.dao = nil;
}

//测试 插入Events方法
- (void) test_1_Create{
    int res = [self.dao create:self.theEvents];
    //断言 无异常，返回值为0
    XCTAssertTrue(res == 0,@"数据插入失败");
}

//测试 按主键查询数据方法
- (void)test_2_FindById{
    self.theEvents.EventID = 41;
    Events *resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果非nil
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theEvents.OlympicInfo, resEvents.OlympicInfo,@"项目奥运会历史信息测试失败");
}

//测试 查询所有数据方法
- (void) test_3_FindAll{
    NSArray *list = [self.dao findAll];
    //断言 查询记录数为1
    XCTAssertTrue([list count] == 41,@"查询记录数期望值为:42 实际值为：%i",(int)[list count]);
    Events *resEvents = list[40];
    //断言
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theEvents.OlympicInfo, resEvents.OlympicInfo,@"项目奥运会历史信息测试十失败");
    
}

//测试 修改Events方法
- (void)test_4_Modify{
    self.theEvents.EventID = 41;
    self.theEvents.EventName = @"test modify EventName";
    
    int res = [self.dao modify:self.theEvents];
    
    //断言 无异常，返回值为0
    XCTAssertTrue(res == 0,@"数据修改失败");
    
    Events *resEvents = [self.dao findById:self.theEvents];
    XCTAssertNotNil(resEvents,@"查询记录为nil");
    
    //断言
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName,@"比赛项目名测试失败");
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon,@"比赛项目图标测试失败");
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo,@"项目关键信息测试失败");
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo,@"项目基本信息测试失败");
    XCTAssertEqualObjects(self.theEvents.OlympicInfo, resEvents.OlympicInfo,@"项目奥运会记录信息测试失败");
}

//测试  删除数据方法
- (void) test_5_Remove{
    int res = [self.dao remove:self.theEvents];
    //断言 无异常，返回值为0
    XCTAssertTrue(res == 0, @"数据删除失败");
    
    Events *resEvents = [self.dao findById:self.theEvents];
    //断言 查询结果为nil
    XCTAssertNil(resEvents,@"记录删除失败");
}




@end
