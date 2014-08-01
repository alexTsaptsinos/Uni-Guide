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

@synthesize allCourses,favouritesButton,tableView,customFilterButton,universitySearchedString,courseSearchedString,locationSearchedString,searchResults,universityUKPRNString,searchResultsUniversityCodes,searchResultsCourseCodes,activityIndicator;

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
    self.tableView.hidden = YES;
    [self.activityIndicator startAnimating];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    //self.amountToSkip = 0;
    
    NSLog(@"searched university: %@ and searched course: %@ and locaton searched: %@", self.universitySearchedString,self.courseSearchedString,self.locationSearchedString);
    
    // if user has searched for university, first get UKPRN (location has automatically loaded)
    
    if (self.universitySearchedString.length != 0) {
        
        PFQuery *queryForUKPRN = [PFQuery queryWithClassName:@"Institution1213"];
        [queryForUKPRN whereKey:@"Institution" equalTo:self.universitySearchedString];
        [queryForUKPRN selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
        PFObject *ukprnObject = [queryForUKPRN getFirstObject];
        NSString *ukprn = [ukprnObject valueForKey:@"UKPRN"];
        
        //if the user has searched for university (and location) and course (location automatically loaded)
        
        if (self.courseSearchedString.length != 0) {
            NSLog(@"code to search: %@ and course to search: %@", ukprn,courseSearchedString);
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            [bigQuery setLimit:100];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                NSLog(@"objects: %@",objects);
                self.searchResults = [objects valueForKey:@"TITLE"];
                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
                //NSLog(@"search results: %@",self.searchResults);
                self.tableView.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
            }];
        }
        
        // if the user has searched for university and location but not course (location automatically loaded)
        
        else if (self.courseSearchedString.length == 0) {
            
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery setLimit:600];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                //NSLog(@"objects: %@",objects);
                self.searchResults = [objects valueForKey:@"TITLE"];
                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
                //NSLog(@"search results: %@",self.searchResults);
                self.tableView.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
            }];
            
        }
    }
    
    //if the user has searched by course and location
    
    else if (self.universitySearchedString.length == 0) {
        
        //first get possible university UKPRNs using location
        
        NSDictionary *locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
        
        NSArray *locationIDArray = [locationDict allKeysForObject:self.locationSearchedString];
        NSString *locationID = [locationIDArray objectAtIndex:0];
        
        PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Institution1213"];
        [locationsQuery whereKeyExists:@"UKPRN"];
        [locationsQuery selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
        [locationsQuery whereKey:@"RegionOfInstitution" equalTo:locationID];
        NSArray *locationUniversityUKPRNS = [locationsQuery findObjects];
        
        NSLog(@"number of possible unis: %d",locationUniversityUKPRNS.count);
        
        for (int i=0; i < locationUniversityUKPRNS.count; i++) {
            // now query courses using ukprns
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            [bigQuery setLimit:1000];
            [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                NSLog(@"objects: %@",objects);
                self.searchResults = [objects valueForKey:@"TITLE"];
                self.searchResultsUniversityCodes = [objects valueForKey:@"UKPRN"];
                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
                NSLog(@"search results: %@",self.searchResults);
                self.tableView.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
            }];
        }
        
        
        
    }

// If user has searched with university, first retrieve the PUBUKPRN of the uni

//    if ([self.universitySearchedString length] != 0) {
//
//        // if searching by university and course
//
//        if ([self.courseSearchedString length] != 0) {
//
//            // if searching by university, course and locaton
//
//            if ([self.locationSearchedString length] != 0) {
//                PFQuery *query = [PFQuery queryWithClassName:@"Institution1213"];
//                [query whereKey:@"Institution" matchesRegex:universitySearchedString modifiers:@"i"];
//                [query whereKey:@"RegionOfInstitution" equalTo:self.locationSearchedString];
//                [query selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
//                NSArray *universityObjectUKPRNS = [query findObjects];
//                //universityUKPRNString = [universityObject objectForKey:@"UKPRN"];
//                NSLog(@"this is the pubukprn: %@", universityObjectUKPRNS);
//
//                [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
//
//                    for (PFObject *object in objects) {
//                        NSString *ukprn = [object valueForKey:@"UKPRN"];
//                        NSLog(@"ukprn: %@", ukprn);
//                        PFQuery *queryForCourses = [PFQuery queryWithClassName:@"Kiscourse"];
//                        [queryForCourses whereKey:@"UKPRN" equalTo:ukprn];
//                        [queryForCourses selectKeys:[NSArray arrayWithObject:@"TITLE"]];
//                        [queryForCourses findObjectsInBackgroundWithBlock:^(NSArray *courseObjects,NSError *courseError) {
//                            NSArray *courseNames = [courseObjects valueForKey:@"TITLE"];
//                            [self.searchResults addObjectsFromArray:courseNames];
//                            NSLog(@"search results: %@",self.searchResults);
//                            self.tableView.hidden = NO;
//                            [self.activityIndicator stopAnimating];
//                        }];
//                    }
//
//                }];
//            }
//        }
//    }
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
    
    
    //    // Configure the cell...
        PFQuery *queryForHonourReceived = [PFQuery queryWithClassName:@"Kisaim"];
        [queryForHonourReceived whereKey:@"KISAIMCODE" equalTo:[self.courseSearchResultsKisAimCodes objectAtIndex:indexPath.row]];
        PFObject *object = [queryForHonourReceived getFirstObject];
        NSString *courseHonour = [object valueForKey:@"KISAIMLABEL"];
        NSString *courseName = [self.searchResults objectAtIndex:indexPath.row];
        courseName = [courseName stringByAppendingString:@" - "];
        courseName = [courseName stringByAppendingString:courseHonour];
    NSLog(@"course name; %@",courseName);
        cell.textLabel.text = courseName;
    
   //     cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    //cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([self.universitySearchedString isEqualToString:@""]) {
    
            PFQuery *queryForUniversityNames = [PFQuery queryWithClassName:@"Institution1213"];
            [queryForUniversityNames whereKey:@"UKPRN" equalTo:[self.searchResultsUniversityCodes objectAtIndex:indexPath.row]];
            PFObject *university = [queryForUniversityNames getFirstObject];
            NSString *universityName = [university valueForKey:@"Institution"];
    
            cell.detailTextLabel.text = universityName;
    
    
        } else {
            cell.detailTextLabel.text = self.universitySearchedString;
        }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

//- (void)queryForSearchResults
//{
//    if ([self.universitySearchedString length] != 0) {
//
//        PFQuery *query = [PFQuery queryWithClassName:@"Universities"];
//        [query whereKey:@"Name" equalTo:universitySearchedString];
//        PFObject *universityObject = [query getFirstObject];
//        universityString = [universityObject objectForKey:@"PUBUKPRN"];
//        NSLog(@"this is the pubukprn: %@", universityString);
//
//        //if user has searched with only university then perform this query
//        if ([self.courseSearchedString length] == 0) {
//            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//            [bigQuery whereKey:@"PUBUKPRN" matchesRegex:universityString modifiers:@"i"];
//            [bigQuery whereKeyExists:@"TITLE"];
//            [bigQuery setLimit:600];
//            bigQuery.skip = self.amountToSkip;
//            [bigQuery orderByAscending:@"TITLE"];
//            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
//                //NSLog(@"objects: %@",objects);
//                self.searchResults = [objects valueForKey:@"TITLE"];
//                //NSLog(@"search results: %@",self.searchResults);
//                [self.tableView reloadData];
//            }];
//
//
//        }
//        //if the user has searched with university and course then perform this query
//
//        else {
//            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//            [bigQuery whereKey:@"PUBUKPRN" matchesRegex:universityString modifiers:@"i"];
//            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
//            [bigQuery setLimit:100];
//            bigQuery.skip = self.amountToSkip;
//            [bigQuery whereKeyExists:@"TITLE"];
//            [bigQuery orderByAscending:@"TITLE"];
//            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
//                //NSLog(@"objects: %@",objects);
//                self.searchResults = [objects valueForKey:@"TITLE"];
//                //NSLog(@"search results: %@",self.searchResults);
//                [self.tableView reloadData];
//            }];
//        }
//    }
//
//    //now if user has searched only using course
//
//    else if ([self.courseSearchedString length] != 0) {
//        PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//        [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
//        [bigQuery setLimit:10];
//        bigQuery.skip = self.amountToSkip;
//        [bigQuery whereKeyExists:@"TITLE"];
//        [bigQuery orderByAscending:@"TITLE"];
//        [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
//            //NSLog(@"objects: %@",objects);
//            self.searchResults = [objects valueForKey:@"TITLE"];
//            self.searchResultsUniversityCodes = [objects valueForKey:@"PUBUKPRN"];
//            self.amountToSkip += 10;
//            NSLog(@"search results: %@",self.searchResults);
//            [self.tableView reloadData];
//        }];
//    }
//
//}
//
//- (void)scrollViewDidEndDraggin:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (scrollView.contentSize.height - scrollView.contentOffset.y < (self.view.bounds.size.height))
//    {
//        [self queryForSearchResults];
//    }
//
//}

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
    coursePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favouritesButton"] style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    favouritesButton.tintColor = [UIColor grayColor];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    courseInfoCoursePageViewController.universityName = cell.detailTextLabel.text;
    courseInfoCoursePageViewController.courseName = cell.textLabel.text;
    courseInfoCoursePageViewController.courseCodeCourseInfo = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
    PFQuery *queryForUniversityCode = [PFQuery queryWithClassName:@"Institution1213"];
    [queryForUniversityCode whereKey:@"Institution" equalTo:cell.detailTextLabel.text];
    PFObject *universityObject = [queryForUniversityCode getFirstObject];
    uniInfoCoursePageViewController.universityObject = universityObject;
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
