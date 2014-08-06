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

@interface CourseInfoCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSString *courseCodeCourseInfo;
@property (strong, nonatomic) NSString *uniCodeCourseInfo;
@property (strong, nonatomic) NSMutableArray *commonJobs;
@property (strong, nonatomic) NSMutableArray *commonJobsPercentages;

@property (strong, nonatomic) UITableView *commonJobsTableView;


@end
