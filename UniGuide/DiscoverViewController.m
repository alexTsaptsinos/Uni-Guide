//
//  DiscoverViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SearchResultsTableViewController.h"
//#import "MainViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

@synthesize discoverButtonLabel,userSubjectsTableDiscover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Discover";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;


    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//when discover button is pressed launch main view controller which contains search results list view and filter view 

- (IBAction)discoverButtonLabelPressed:(id)sender {
    
//    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:mainViewController animated:YES];
    
    SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:searchResultsTableViewController animated:YES];
    
}
@end
