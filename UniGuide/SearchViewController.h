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
}

@property (nonatomic, retain) NSMutableArray *universitiesFromParse;
@property (nonatomic, retain) NSArray *autocompleteUniversities;
@property (nonatomic, retain) UITableView *autocompleteUniversitiesTableView;
@property (nonatomic, retain) UITextField *universityTextField;


//- (IBAction)searchButtonSearchViewControllerPressed:(id)sender;
//@property (weak, nonatomic) IBOutlet UIButton *searchButtonSearchViewController;
//- (IBAction)editingChanged;
//- (void)searchUniversitiesAutocompleteEntriesWithSubstring:(NSString *)substring;
- (void)filterUniversitiesForSearchText:(NSString*)searchText;

@end
