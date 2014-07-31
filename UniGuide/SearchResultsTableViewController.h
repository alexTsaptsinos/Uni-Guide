//
//  SearchResultsTableViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//


#import "RightPanelViewController.h"
#import <Parse/Parse.h>

@interface SearchResultsTableViewController: UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *allCourses;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *customFilterButton;

@property (strong, nonatomic) NSString *universitySearchedString;
@property (strong, nonatomic) NSString *courseSearchedString;
@property (strong, nonatomic) NSString *locationSearchedString;

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *courseSearchResultsKisAimCodes;
@property (strong, nonatomic) NSString *universityString;
@property (strong, nonatomic) NSMutableArray *searchResultsUniversityCodes;
@property int amountToSkip;
//- (void)queryForSearchResults;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
