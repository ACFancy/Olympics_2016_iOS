//
//  EventsDetailViewController.m
//  2016Olympics
//
//  Created by ianc on 15/5/11.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import "EventsDetailViewController.h"

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imgEventIcon.image = [UIImage imageNamed:self.event.EventIcon];
    self.lblEventName.text = self.event.EventName;
    self.txtViewKeyInfo.text = self.event.KeyInfo;
    self.txtviewBasicsInfo.text = self.event.BasicsInfo;
    self.txtViewOlympicsInfo.text = self.event.OlympicInfo;
    
    //只有iPhone会使用ScrollView
    self.scrollView.frame =  self.view.frame;
    self.scrollView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    self.scrollView.contentSize = CGSizeMake(320, 900);
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
