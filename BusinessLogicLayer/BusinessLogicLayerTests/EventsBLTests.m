//
//  EventsBLTests.m
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/6.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "EventsBLTests.h"

@implementation EventsBLTests

- (void)setUp{
  //创建EventsBL 对象
    self.bl = [[EventsBL alloc] init];
  //创建Events对象
    self.theEvents = [[Events alloc] init];
    self.theEvents.EventName = @"test EventName";
    self.theEvents.EventIcon = @"test EventIcon";
    self.theEvents.KeyInfo = @"test KeyInfo";
    self.theEvents.BasicsInfo = @"test BasicsInfo";
    self.theEvents.OlympicInfo = @"test OlympicInfo";
    
    //插入测试数据
    EventsDAO *dao = [EventsDAO sharedManager];
    [dao create:self.theEvents];
}

- (void)tearDown{
   //删除测试数据
    self.theEvents.EventID = 41;
    EventsDAO *dao = [EventsDAO sharedManager];
    [dao remove:self.theEvents];
    
    self.bl = nil;
}

//测试 按照主键查询数据方法
- (void)testFindAll{
    NSArray *list = [self.bl readData];
    //断言 查询记录数为1
    XCTAssertTrue([list count] == 41,@"查询记录数期望值为：41 实际值为：%lu",(unsigned long)[list count]);
    
    Events *resEvents = list[40];
    //断言
    XCTAssertEqualObjects(self.theEvents.EventName, resEvents.EventName,@"比赛项目名称测试失败");
    XCTAssertEqualObjects(self.theEvents.EventIcon, resEvents.EventIcon,@"比赛图片测试失败");
    XCTAssertEqualObjects(self.theEvents.KeyInfo, resEvents.KeyInfo,@"比赛关键信息测试失败");
    XCTAssertEqualObjects(self.theEvents.BasicsInfo, resEvents.BasicsInfo,@"比赛基本信息测试失败");
    XCTAssertEqualObjects(self.theEvents.OlympicInfo, resEvents.OlympicInfo,@"比赛奥运历史信息测试失败");
    
}

@end
