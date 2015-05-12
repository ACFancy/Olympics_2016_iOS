//
//  AboutViewController.h
//  2016Olympics
//
//  Created by ianc on 15/5/12.
//  Copyright (c) 2015年 PGWizard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

#define kSampleAdUnitID @"a14df1974738141"

@interface AboutViewController : UIViewController<GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;

- (GADRequest *)createRequest;

@end
