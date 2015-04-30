//
//  EventsDAO.h
//  PersistenceLayer
//
//  Created by ianc on 15/4/30.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Events.h"

@interface EventsDAO : NSObject

//插入数据的方法
- (int)create:(Events *)model;
//删除数据的方法
- (int)remove:(Events *)model;
//修改数据的方法
- (int)modify:(Events *)model;
//查询所有数据的方法
- (NSMutableArray *)findAll;
//按照主键查询数据的方法
- (Events *)findById:(Events *)model;
@end
