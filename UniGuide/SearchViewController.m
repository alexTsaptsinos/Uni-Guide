//
//  SearchViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"

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
    //give navigation bar title
     self.navigationItem.title = @"Search";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Make sure keyboard goes away when hit return for university,course,location text fields

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

//when search button is pressed, push main view controller which contains results table view and filter view

- (IBAction)searchButtonSearchViewControllerPressed:(id)sender {
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    [self.navigationController pushViewController:mainViewController animated:YES];
    
}
@end
