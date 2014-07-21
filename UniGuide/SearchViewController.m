//
//  SearchViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize courseTextFieldSearchViewController,universityTextFieldSearchViewController,locationTextFieldSearchViewController,searchButtonSearchViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.title = @"Search";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.courseTextFieldSearchViewController) {
        [textField resignFirstResponder];
    }
    if (textField == self.universityTextFieldSearchViewController) {
        [textField resignFirstResponder];
    }
    if (textField == self.locationTextFieldSearchViewController) {
        [textField resignFirstResponder];
    }
    return NO;
}

- (IBAction)searchButtonSearchViewControllerPressed:(id)sender {
    
    SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:searchResultsTableViewController animated:YES];
    
}
@end
