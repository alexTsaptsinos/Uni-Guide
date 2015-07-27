//
//  CourseListTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 29/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"
#import "ContactUniversityPageViewController.h"

@interface CourseListTableViewController : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *universityCourses;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;
@property (nonatomic, strong) NSString *universityCode;
@property (nonatomic, strong) NSString *universityName;
@property (nonatomic,strong) NSMutableArray *cellTitles;
@property (nonatomic,strong) CourseInfoCoursePageViewController *courseInfoCoursePageViewController;

@property (nonatomic) BOOL firstTimeLoad;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@end
