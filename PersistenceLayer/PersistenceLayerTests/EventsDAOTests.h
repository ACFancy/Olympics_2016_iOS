//
//  EventsDAOTests.h
//  PersistenceLayer
//
//  Created by ianc on 15/5/4.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Events.h"
#import "EventsDAO.h"

@interface EventsDAOTests : XCTestCase

@property (nonatomic, strong) EventsDAO *dao;
@property (nonatomic, strong) Events *theEvents;

@end
