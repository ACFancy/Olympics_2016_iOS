//
//  CountDownViewController.m
//  2016Olympics
//
//  Created by ianc on 15/5/12.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents中的日期
    [comps setDay:5];
    //设置NSDateComponents中的月份
    [comps setMonth:8];
    //设置NSDateComponents中的年份
    [comps setYear:2016];
    //创建日历对象
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2016-08-05的NSDate日期对象
    NSDate *destinationDate = [calendar dateFromComponents:comps];
    //获得当前日期到2016-8-5时间的NSDateComponents对象
    NSDateComponents *compoents = [calendar components:NSCalendarUnitDay fromDate:[NSDate date] toDate:destinationDate options:NSCalendarWrapComponents];
    //获得当前日期到2016-8-5相差的天数
    int days = (int)[compoents day];
    
    NSMutableAttributedString *attributedTextHolder = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i天",days]];
    
    [attributedTextHolder addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] range:NSMakeRange(attributedTextHolder.length - 1, 1)];
    
    self.lblCountDown.attributedText = attributedTextHolder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
