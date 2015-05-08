//
//  ScheduleBL.m
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "ScheduleBL.h"
#import "ScheduleDAO.h"
#import "EventsDAO.h"
@implementation ScheduleBL

- (NSMutableDictionary *)readData{
    ScheduleDAO *scheduleDAO = [ScheduleDAO sharedManager];
    NSMutableArray *schedules = [scheduleDAO findAll];
    NSMutableDictionary *resDict = [NSMutableDictionary dictionary];
    
    EventsDAO *eventsDAO = [EventsDAO sharedManager];
    //延迟加载Events数据
    for(Schedule *schedule in schedules){
        Events *event = [eventsDAO findById:schedule.Event];
        schedule.Event = event;
        
        NSArray *allKey = [resDict allKeys];
        
        //把NSMutableArray结构化转化为NSMutableDictionary结构
        if ([allKey containsObject:schedule.GameDate]) {
            NSMutableArray *value = [resDict objectForKey:schedule.GameDate];
            [value addObject:schedule];
        }else{
            NSMutableArray *value = [NSMutableArray array];
            [value addObject:schedule];
            [resDict setObject:value forKey:schedule.GameDate];
        }
    }
    return resDict;
}

@end
