//
//  ScheduleBLTests.h
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/8.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ScheduleBL.h"
#import "ScheduleDAO.h"
#import "Events.h"

@interface ScheduleBLTests : XCTestCase

@property (nonatomic, strong) ScheduleBL *bl;
@property (nonatomic, strong) Schedule *theSchedule;

@end
