//
//  SearchResultsTableViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "RightPanelViewController.h"





@class Courses;

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

@synthesize allCourses,favouritesButton,tableView,customFilterButton,universitySearchedString,courseSearchedString,locationSearchedString,searchResults,universityString,searchResultsUniversityCodes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //set navigation bar title
        self.navigationItem.title = @"Results";
        
        //set up filter button on navigation bar
        customFilterButton =[[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(customFilterButtonPressed)];
        [self.navigationItem setRightBarButtonItem:customFilterButton];
    }
    return self;
}

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    NSLog(@"searched university: %@ and searched course: %@", self.universitySearchedString,self.courseSearchedString);
    
    
    // If user has searched with university, first retrieve the PUBUKPRN of the uni
    
    if ([self.universitySearchedString length] != 0) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Universities"];
        [query whereKey:@"Name" equalTo:universitySearchedString];
        PFObject *universityObject = [query getFirstObject];
        universityString = [universityObject objectForKey:@"PUBUKPRN"];
        NSLog(@"this is the pubukprn: %@", universityString);
        
        //if user has searched with only university then perform this query
        if ([self.courseSearchedString length] == 0) {
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"PUBUKPRN" matchesRegex:universityString modifiers:@"i"];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery setLimit:600];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                //NSLog(@"objects: %@",objects);
                self.searchResults = [objects valueForKey:@"TITLE"];
                //NSLog(@"search results: %@",self.searchResults);
                [self.tableView reloadData];
            }];
        
        
        }
        //if the user has searched with university and course then perform this query
        
        else {
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"PUBUKPRN" matchesRegex:universityString modifiers:@"i"];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            [bigQuery setLimit:100];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                //NSLog(@"objects: %@",objects);
                self.searchResults = [objects valueForKey:@"TITLE"];
                //NSLog(@"search results: %@",self.searchResults);
                [self.tableView reloadData];
            }];
        }
    }
    else if ([self.courseSearchedString length] != 0) {
        PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
        [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
        [bigQuery setLimit:1000];
        [bigQuery whereKeyExists:@"TITLE"];
        [bigQuery orderByAscending:@"TITLE"];
        [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            //NSLog(@"objects: %@",objects);
            self.searchResults = [objects valueForKey:@"TITLE"];
            self.searchResultsUniversityCodes = [objects valueForKey:@"PUBUKPRN"];
            NSLog(@"search results: %@",self.searchResults);
            [self.tableView reloadData];
        }];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    NSLog(@"count: %d",self.searchResults.count);
    return self.searchResults.count;
}

// set cell labels and configure

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12];
    if ([self.universitySearchedString isEqualToString:@""]) {
        
        PFQuery *queryForUniversityNames = [PFQuery queryWithClassName:@"Universities"];
        [queryForUniversityNames whereKey:@"PUBUKPRN" equalTo:[self.searchResultsUniversityCodes objectAtIndex:indexPath.row]];
        PFObject *university = [queryForUniversityNames getFirstObject];
        NSString *universityName = [university valueForKey:@"Name"];
        cell.detailTextLabel.text = universityName;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        
    } else {
        cell.detailTextLabel.text = self.universitySearchedString;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    return cell;
}

#pragma mark - Table view delegate

//In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller. we create a tab bar controller
    
    CourseInfoCoursePageViewController *courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] init];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]init];
    
    ReviewsCoursePageViewController *reviewsCoursePageViewController = [[ReviewsCoursePageViewController alloc] init];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] init];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] init];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,reviewsCoursePageViewController,uniInfoCoursePageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    UILabel *courseTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    courseTitle.numberOfLines = 2;
    courseTitle.text = cell.textLabel.text;
    courseTitle.textAlignment = NSTextAlignmentCenter;
    
    coursePageTabBarController.navigationItem.titleView = courseTitle;
    
    
    
    
    
    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favouritesButton"] style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    favouritesButton.tintColor = [UIColor grayColor];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
}

//method for Favourites button

-(void) customBtnPressed
{
    if (favouritesButton.tintColor == [UIColor yellowColor]) {
        favouritesButton.tintColor = [UIColor grayColor];
    }
    else if (favouritesButton.tintColor == [UIColor grayColor]) {
        favouritesButton.tintColor = [UIColor yellowColor];
    }
    
}

- (void) customFilterButtonPressed
{
    RightPanelViewController *rightPanelViewController = [[RightPanelViewController alloc] initWithNibName:@"RightPanelViewController" bundle:nil];
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.navigationController pushViewController:rightPanelViewController animated:NO];
                    }
                    completion:nil];
    
    
}

@end
