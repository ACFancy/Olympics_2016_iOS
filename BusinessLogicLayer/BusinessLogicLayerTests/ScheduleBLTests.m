//
//  ScheduleBLTests.m
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/8.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "ScheduleBLTests.h"

@implementation ScheduleBLTests

- (void)setUp{
 //创建ScheduleBL对象
 self.bl = [[ScheduleBL alloc] init];
 //创建Schedule 对象
    self.theSchedule = [[Schedule alloc] init];
    self.theSchedule.GameDate = @"test GameDate";
    self.theSchedule.GameInfo = @"test GameInfo";
    self.theSchedule.GameTime = @"test GameTime";
    
    Events *event = [[Events alloc] init];
    event.EventName = @"Cycling Mountain Bike";
    event.EventID = 10;
    self.theSchedule.Event = event;
    
    //插入测试数据
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao create:self.theSchedule];
}

- (void)tearDown{
  //删除测试数据
    self.theSchedule.SchedileID = 502;
    ScheduleDAO *dao = [ScheduleDAO sharedManager];
    [dao remove:self.theSchedule];
    
    self.bl = nil;
}


@end
