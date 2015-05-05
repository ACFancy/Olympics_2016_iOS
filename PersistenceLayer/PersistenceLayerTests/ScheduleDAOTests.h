//
//  ScheduleDAOTests.h
//  PersistenceLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Schedule.h"
#import "ScheduleDAO.h"


@interface ScheduleDAOTests : XCTestCase

@property (nonatomic, strong) ScheduleDAO *dao;
@property (nonatomic, strong) Schedule *theSchedule;

@end
