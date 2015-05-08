//
//  EventsBLTests.h
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/6.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EventsDAO.h"
#import "EventsBL.h"
@interface EventsBLTests : XCTestCase

@property (nonatomic, strong) EventsBL *bl;
@property (nonatomic, strong) Events *theEvents;

@end
