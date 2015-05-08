//
//  EventsBL.m
//  BusinessLogicLayer
//
//  Created by ianc on 15/5/5.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "EventsBL.h"
#import "EventsDAO.h"

@implementation EventsBL

- (NSMutableArray *)readData{
    EventsDAO *dao = [EventsDAO sharedManager];
    NSMutableArray *list = [dao findAll];
    return list;
}

@end
