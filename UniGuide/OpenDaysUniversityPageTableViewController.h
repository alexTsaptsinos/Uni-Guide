//
//  OpenDaysUniversityPageTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OpenDaysUniversityPageTableViewController : UITableViewController

@property (nonatomic, retain) NSString *universityUKPRN;
@property (nonatomic, retain) NSMutableArray *openDays;
@property (strong, nonatomic) NSMutableArray *openDayDates;
@property (strong, nonatomic) NSMutableArray *startTimes;
@property (strong, nonatomic) NSMutableArray *endTimes;
@property (strong, nonatomic) NSMutableArray *details;
@property (strong, nonatomic) NSMutableArray *links;
@property (nonatomic) BOOL foundAnyBool;
@property (nonatomic) BOOL firstTimeLoad;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@end
