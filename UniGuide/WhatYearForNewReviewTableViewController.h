//
//  WhatYearForNewReviewTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddReviewViewController.h"

@class AddReviewViewController;

@interface WhatYearForNewReviewTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *differentYears;
@property (nonatomic, strong) AddReviewViewController *previousViewController;

@end
