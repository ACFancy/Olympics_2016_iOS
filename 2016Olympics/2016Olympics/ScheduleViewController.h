//
//  ScheduleViewController.h
//  2016Olympics
//
//  Created by ianc on 15/5/11.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "ScheduleBL.h"
#import "EventsDetailViewController.h"

@interface ScheduleViewController : UITableViewController

//表视图使用的数据
@property (nonatomic ,strong) NSDictionary *data;

//比赛日期列表
@property (nonatomic, strong) NSArray *arrayGameDateList;

@end
