//
//  EventsDetailViewController.h
//  2016Olympics
//
//  Created by ianc on 15/5/11.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Events.h"
@interface EventsDetailViewController : UIViewController

@property (nonatomic, strong) Events *event;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblEventName;
@property (weak, nonatomic) IBOutlet UIImageView *imgEventIcon;
@property (weak, nonatomic) IBOutlet UITextView *txtViewKeyInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtviewBasicsInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtViewOlympicsInfo;

@end
