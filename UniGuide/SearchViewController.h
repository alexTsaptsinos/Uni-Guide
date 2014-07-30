//
//  SearchViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsTableViewController.h"
#import <Parse/Parse.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *universitiesFromParse;
    NSMutableArray *autocompleteUniversities;
    UITableView *autocompleteUniversitiesTableView;
    IBOutlet UITextField *universityTextField;
    IBOutlet UITextField *courseTextField;
    IBOutlet UITextField *locationTextField;
}

@property (nonatomic, retain) NSMutableArray *universitiesFromParse;
@property (nonatomic, retain) NSMutableArray *coursesFromParse;
@property (nonatomic, retain) NSArray *autocompleteUniversities;
@property (nonatomic, retain) UITableView *autocompleteUniversitiesTableView;
@property (nonatomic, retain) UITextField *universityTextField;
@property (nonatomic, retain) UITextField *courseTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSNumber *whichTextFieldActive;
@property (nonatomic, retain) UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (void)filterUniversitiesForSearchText:(NSString*)searchText;
- (IBAction)searchButtonPressed:(id)sender;

@end
