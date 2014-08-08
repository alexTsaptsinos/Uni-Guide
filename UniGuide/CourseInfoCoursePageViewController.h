//
//  CourseInfoCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CommonJobsCustomCellView.h"
#import "CourseInfoTextCustomCellView.h"
#import "UniInfoCustomCellView.h"
#import "CourseInfoPieCustomCellView.h"
#import "CourseInfoSalaryCustomCellView.h"

@interface CourseInfoCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSString *courseCodeCourseInfo;
@property (strong, nonatomic) NSString *uniCodeCourseInfo;


@property (strong, nonatomic) NSString *uniNameCourseInfo;
@property (strong, nonatomic) NSString *courseNameCourseInfo;
@property (strong, nonatomic) NSString *yearAbroad;
@property (strong, nonatomic) NSString *sandwichYear;
@property (strong, nonatomic) NSString *courseUrl;
@property (strong, nonatomic) NSString *ucasCourseCode;
@property (strong, nonatomic) NSMutableArray *degreeStatistics;
@property (strong, nonatomic) NSString *averageTariffString;
@property (strong, nonatomic) NSMutableArray *assessmentMethods;
@property (strong, nonatomic) NSMutableArray *timeSpent;
@property (strong, nonatomic) NSString *proportionInWork;
@property (strong, nonatomic) NSMutableArray *commonJobs;
@property (strong, nonatomic) NSMutableArray *commonJobsPercentages;
@property (strong, nonatomic) NSString *instituteSalary;
@property (strong, nonatomic) NSString *nationalSalary;



@property (strong, nonatomic) UITableView *courseInfoTableView;
@property (nonatomic) BOOL firstTimeLoad;



@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;


@end
