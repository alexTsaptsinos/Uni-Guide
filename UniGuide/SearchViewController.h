//
//  SearchViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsTableViewController.h"
#import "LocationSelectTableViewController.h"
#import <Parse/Parse.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIAlertViewDelegate>
{
    NSMutableArray *universitiesFromParse;
    NSMutableArray *autocompleteUniversities;
    UITableView *autocompleteUniversitiesTableView;
    IBOutlet UITextField *universityTextField;
    IBOutlet UITextField *courseTextField;
}

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (nonatomic, retain) NSMutableArray *universitiesFromParse;
@property (nonatomic, retain) NSMutableArray *universityUKPRNFromParse;
@property (nonatomic, retain) NSMutableArray *coursesFromParse;
@property (nonatomic, retain) NSArray *locationsArray;
@property (nonatomic, retain) NSArray *autocompleteUniversities;
@property (nonatomic, retain) UITableView *autocompleteUniversitiesTableView;
@property (nonatomic, retain) UITextField *universityTextField;
@property (nonatomic, retain) UITextField *courseTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSNumber *whichTextFieldActive;
@property (nonatomic, retain) UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic) BOOL anyFound;
@property (nonatomic) BOOL haveQueriedParseForCoursesYet;
@property (nonatomic) BOOL haveFoundAUniversity;

@property (strong, nonatomic) NSDictionary *locationDict;

- (void)filterUniversitiesForSearchText:(NSString*)searchText;
- (void)parseQueryForCourses:(NSString*)searchText;
- (IBAction)searchButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pleaseSelectLabel;
- (IBAction)locationButtonPressed:(id)sender;

@end
