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
#import "Favourites.h"
#import "NSManagedObject+CRUD.h"
#import "ARSPopover.h"
#import "Compares.h"

@interface CourseInfoCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSString *courseCodeCourseInfo;
@property (strong, nonatomic) NSString *uniCodeCourseInfo;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;


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
@property (nonatomic) BOOL haveComeFromFavourites;
@property (nonatomic) BOOL isItFavourite;
@property (nonatomic) BOOL isInMiddleOfFavouriteSave;
@property (nonatomic) BOOL isInMiddleOfCompareSave;


-(void) customBtnPressed;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;

@property (strong,nonatomic) ARSPopover *popoverController;
@property (strong,nonatomic) UIButton *favouritesPopoverButton;
@property (strong,nonatomic) UIButton *comparePopoverButton;
@property (strong,nonatomic) UIButton *replaceFirstButton;
@property (strong,nonatomic) UIButton *replaceSecondButton;



@end
