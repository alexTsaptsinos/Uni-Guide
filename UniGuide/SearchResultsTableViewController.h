//
//  SearchResultsTableViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//


#import "RightPanelViewController.h"
#import <Parse/Parse.h>
#import "Favourites.h"
#import "NSManagedObject+CRUD.h"
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "RightPanelViewController.h"

@interface SearchResultsTableViewController: UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray *allCourses;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *customFilterButton;

@property (strong, nonatomic) NSString *universitySearchedString;
@property (strong, nonatomic) NSString *courseSearchedString;
@property (strong, nonatomic) NSString *locationSearchedString;

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *courseSearchResultsKisAimCodes;
@property (strong, nonatomic) NSString *universityUKPRNString;
@property (strong, nonatomic) NSMutableArray *searchResultsUniversityCodes;
@property (strong, nonatomic) NSMutableArray *searchResultsCourseCodes;
@property (strong, nonatomic) NSMutableArray *courseDegreeTitles;
@property (strong, nonatomic) NSMutableArray *universityNamesForSearchResults;
@property (nonatomic) BOOL haveFoundEverySeachValue;
@property (nonatomic) BOOL anyResults;

@property (nonatomic,strong) CourseInfoCoursePageViewController *courseInfoCoursePageViewController;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)queryForSearchResults;


@end
