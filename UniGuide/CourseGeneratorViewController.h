//
//  CourseGeneratorViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "ContactUniversityPageViewController.h"

@interface CourseGeneratorViewController : UIViewController

@property (strong,nonatomic) UILabel *universityLabel;
@property (strong,nonatomic) UILabel *courseLabel;
@property (strong,nonatomic) UILabel *atLabel;
@property (strong,nonatomic) UIButton *goAgainButton;
@property (strong,nonatomic) UIButton *tryCourseButton;


@property (strong,nonatomic) NSMutableArray *universitiesUKPRNS;
@property (strong,nonatomic) NSMutableArray *universities;
@property (strong,nonatomic) NSMutableArray *universitiesSortableNames;

@property (strong,nonatomic) NSString *courseCodeCourseGenerator;
@property (strong,nonatomic) NSString *uniCodeCourseGenerator;
@property (strong,nonatomic) NSString *uniNameCourseGenerator;
@property (strong,nonatomic) NSString *courseNameCourseGenerator;


@property (nonatomic, strong) UIBarButtonItem *favouritesButton;

@property (nonatomic,strong) CourseInfoCoursePageViewController *courseInfoCoursePageViewController;


@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;


@end
