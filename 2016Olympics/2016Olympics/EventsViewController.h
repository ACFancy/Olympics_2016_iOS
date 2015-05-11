//
//  EventsViewController.h
//  2016Olympics
//
//  Created by ianc on 15/5/11.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsViewCell.h"
#import "EventsBL.h"
#import "Events.h"
#import "EventsDetailViewController.h"

@interface EventsViewController : UICollectionViewController{
  //一行中的列数
    NSUInteger COL_COUNT;
}

@property (strong ,nonatomic) NSArray *events;

@end
