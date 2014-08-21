//
//  StudentSatisfactionCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "StudentSatisfactionCustomCellView.h"

@interface StudentSatisfactionCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *courseCodeStudentSatisfaction;
@property (strong, nonatomic) NSString *uniCodeStudentSatisfaction;
@property (strong, nonatomic) NSString *uniNameStudentSatisfaction;
@property (strong, nonatomic) NSString *courseNameStudentSatisfaction;
@property (strong, nonatomic) NSMutableArray *questionResults;

@property (strong, nonatomic) UITableView *tableViewStudentSatisfaction;
@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;

@property (nonatomic) BOOL firstTimeLoad;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@end
