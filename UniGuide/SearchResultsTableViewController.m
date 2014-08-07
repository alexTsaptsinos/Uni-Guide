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


@property (nonatomic) int limit;
@property (nonatomic) int skip;
@property (nonatomic, strong) NSString *universitySearchedUKPRN;


@end

@implementation SearchResultsTableViewController

@synthesize allCourses,favouritesButton,tableView,customFilterButton,universitySearchedString,courseSearchedString,locationSearchedString,searchResults,universityUKPRNString,searchResultsUniversityCodes,searchResultsCourseCodes,activityIndicator,limit,skip,courseDegreeTitles,universitySearchedUKPRN,haveFoundEverySeachValue;

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
    self.limit = 10;
    self.skip = 0;
    self.searchResults = [[NSMutableArray alloc] init];
    self.searchResultsCourseCodes = [[NSMutableArray alloc] init];
    self.courseSearchResultsKisAimCodes = [[NSMutableArray alloc] init];
    self.courseDegreeTitles = [[NSMutableArray alloc] init];
    self.universityNamesForSearchResults = [[NSMutableArray alloc] init];
    self.searchResultsUniversityCodes = [[NSMutableArray alloc] init];
    self.haveFoundEverySeachValue = NO;
    [self queryForSearchResults];
    //self.amountToSkip = 0;

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

- (void)queryForSearchResults
{
    NSLog(@"searched university: %@ and searched course: %@ and locaton searched: %@", self.universitySearchedString,self.courseSearchedString,self.locationSearchedString);
    
    
    // if user has searched for university, first get UKPRN (location has automatically loaded)
    
    if (self.universitySearchedString.length != 0) {
        
        PFQuery *queryForUKPRN = [PFQuery queryWithClassName:@"Institution1213"];
        [queryForUKPRN whereKey:@"Institution" equalTo:self.universitySearchedString];
        [queryForUKPRN selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
        PFObject *ukprnObject = [queryForUKPRN getFirstObject];
        self.universitySearchedUKPRN = [ukprnObject valueForKey:@"UKPRN"];
        
        //if the user has searched for university (and location) and course (location automatically loaded)
        
        if (self.courseSearchedString.length != 0) {
            NSLog(@"code to search: %@ and course to search: %@", self.universitySearchedUKPRN,courseSearchedString);
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"UKPRN" equalTo:self.universitySearchedUKPRN];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            [bigQuery setLimit:self.limit];
            [bigQuery setSkip:self.skip];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
               // NSLog(@"objects: %@",objects);
                NSArray *tempNames = [objects valueForKey:@"TITLE"];
                [self.searchResults addObjectsFromArray:tempNames];
                [self.searchResultsCourseCodes addObjectsFromArray:[objects valueForKey:@"KISCOURSEID"]];
                [self.courseSearchResultsKisAimCodes addObjectsFromArray:[objects valueForKey:@"KISAIMCODE"]];
                for (int k = self.skip; k<self.courseSearchResultsKisAimCodes.count; k++) {
                    NSString *aimCodes = [self.courseSearchResultsKisAimCodes objectAtIndex:k];
                    PFQuery *queryForHonourReceived = [PFQuery queryWithClassName:@"Kisaim"];
                    [queryForHonourReceived whereKey:@"KISAIMCODE" equalTo:aimCodes];
                    PFObject *object = [queryForHonourReceived getFirstObject];
                    NSString *courseHonour = [object valueForKey:@"KISAIMLABEL"];
                    [self.courseDegreeTitles addObject:courseHonour];
                    NSLog(@"course degree titles count as we go: %d",self.courseDegreeTitles.count);
                }
                if (objects.count == 0) {
                    self.haveFoundEverySeachValue = YES;
                }
                NSLog(@"search results: %@",self.searchResults);
                self.skip += self.limit;
                NSLog(@"self.skip : %d",self.skip);
                self.tableView.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
            }];
        }
        
        // if the user has searched for university and location but not course (location automatically loaded)
        
        else if (self.courseSearchedString.length == 0) {
            
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"UKPRN" equalTo:self.universitySearchedUKPRN];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery setLimit:self.limit];
            [bigQuery setSkip:self.skip];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                //NSLog(@"objects: %@",objects);
                NSArray *tempNames = [objects valueForKey:@"TITLE"];
                [self.searchResults addObjectsFromArray:tempNames];
                [self.searchResultsCourseCodes addObjectsFromArray:[objects valueForKey:@"KISCOURSEID"]];
                [self.courseSearchResultsKisAimCodes addObjectsFromArray:[objects valueForKey:@"KISAIMCODE"]];
                for (int k = self.skip; k<self.courseSearchResultsKisAimCodes.count; k++) {
                    NSString *aimCodes = [self.courseSearchResultsKisAimCodes objectAtIndex:k];
                    PFQuery *queryForHonourReceived = [PFQuery queryWithClassName:@"Kisaim"];
                    [queryForHonourReceived whereKey:@"KISAIMCODE" equalTo:aimCodes];
                    PFObject *object = [queryForHonourReceived getFirstObject];
                    NSString *courseHonour = [object valueForKey:@"KISAIMLABEL"];
                    [self.courseDegreeTitles addObject:courseHonour];
                    NSLog(@"course degree titles count as we go: %d",self.courseDegreeTitles.count);
                }
                if (objects.count == 0) {
                    self.haveFoundEverySeachValue = YES;
                }
                NSLog(@"search results: %@",self.searchResults);
                self.skip += self.limit;
                NSLog(@"self.skip : %d",self.skip);
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
        
        // find the location searched id using the dictionary
        NSArray *locationIDArray = [locationDict allKeysForObject:self.locationSearchedString];
        NSString *locationID = [locationIDArray objectAtIndex:0];
        NSLog(@"array: %@ and ID: %@",locationIDArray,locationID);
        
        // now we query for all universities with this region id
        PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Institution1213"];
        [locationsQuery whereKeyExists:@"UKPRN"];
        [locationsQuery selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
        [locationsQuery whereKey:@"RegionOfInstitution" equalTo:locationID];
        NSArray *locationUniversityObjects = [locationsQuery findObjects];
        // array of the possible ukprns
        NSArray *locationUniversityUKPRNS = [locationUniversityObjects valueForKey:@"UKPRN"];
        NSLog(@"possible unis count: %d",locationUniversityUKPRNS.count);
        NSLog(@"number of possible unis: %d",locationUniversityUKPRNS.count);
        
        // we use the cumulative search results to keep adding results
        
        NSMutableArray *cumulativeSearchResults = [[NSMutableArray alloc] init];
        [cumulativeSearchResults removeAllObjects];
        
        for (int i=0; i < locationUniversityUKPRNS.count; i++) {
            // now query courses using ukprns
            NSLog(@"i value: %d",i);
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            // find this number per university
            if (locationUniversityUKPRNS.count >5) {
                [bigQuery setLimit:2];
            } else {
                [bigQuery setLimit:5];
            }
            [bigQuery setSkip:self.skip];
            NSLog(@"ukprn: %@",[locationUniversityUKPRNS objectAtIndex:i]);
            [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                // now find university name
                PFQuery *universityNameQuery = [PFQuery queryWithClassName:@"Institution1213"];
                [universityNameQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
                [universityNameQuery selectKeys:[NSArray arrayWithObject:@"Institution"]];
                PFObject *tempObject = [universityNameQuery getFirstObject];
                NSString *universityNameTemp = [tempObject valueForKey:@"Institution"];
                NSLog(@"uni name temp: %@",universityNameTemp);
                
                //for however many courses found add the university name this many times
                for (int j=0; j<objects.count; j++) {
                    [self.universityNamesForSearchResults addObject:universityNameTemp];
                    //  [self.searchResultsUniversityCodes addObject:[locationUniversityUKPRNS objectAtIndex:i]];
                    // NSLog(@"university names: %@ and uni ukprns: %@",self.universityNamesForSearchResults,self.searchResultsUniversityCodes);
                }
                
                // now add the courses we found
                [cumulativeSearchResults addObjectsFromArray:objects];
                NSLog(@"cum search results count: %d",cumulativeSearchResults.count);
                
                // if we have got to the final university in this region
                if (i == locationUniversityUKPRNS.count - 1) {
                    if (cumulativeSearchResults.count == 0) {
                        self.haveFoundEverySeachValue = YES;
                    }
                    [self.searchResults  addObjectsFromArray:[cumulativeSearchResults valueForKey:@"TITLE"]];
                    NSLog(@"search results first; %@",self.searchResults);
                    [self.searchResultsUniversityCodes addObjectsFromArray:[cumulativeSearchResults valueForKey:@"UKPRN"]];
                    [self.courseSearchResultsKisAimCodes addObjectsFromArray:[cumulativeSearchResults valueForKey:@"KISAIMCODE"]];
                    NSLog(@"kis codes: %@",self.courseSearchResultsKisAimCodes);
                    [self.searchResultsCourseCodes addObjectsFromArray:[cumulativeSearchResults valueForKey:@"KISCOURSEID"]];
                    for (int k = self.skip; k<self.courseSearchResultsKisAimCodes.count; k++) {
                        NSString *aimCodes = [self.courseSearchResultsKisAimCodes objectAtIndex:k];
                        PFQuery *queryForHonourReceived = [PFQuery queryWithClassName:@"Kisaim"];
                        [queryForHonourReceived whereKey:@"KISAIMCODE" equalTo:aimCodes];
                        PFObject *object = [queryForHonourReceived getFirstObject];
                        NSString *courseHonour = [object valueForKey:@"KISAIMLABEL"];
                        [self.courseDegreeTitles addObject:courseHonour];
                        NSLog(@"course degree titles count as we go: %d",self.courseDegreeTitles.count);
                    }
                    if (objects.count == 0) {
                        self.haveFoundEverySeachValue = YES;
                    }
                    if (locationUniversityUKPRNS.count >5) {
                        self.skip += 2;
                    } else {
                        self.skip +=5;
                    }
                    NSLog(@"uni names %@",self.universityNamesForSearchResults);
                    NSLog(@"self.skip : %d",self.skip);
                    self.tableView.hidden = NO;
                    [self.activityIndicator stopAnimating];
                    [self.tableView reloadData];
                }
            }];
           
        }
    }
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
    
    if (indexPath.row == [self.searchResults count] - 1) {
        if (self.haveFoundEverySeachValue == NO) {
            [self queryForSearchResults];
        }
    }
    
    //    // Configure the cell...
    NSLog(@"course names count: %d and course codes count: %d",self.searchResults.count,self.courseDegreeTitles.count);
    NSString *courseName = [self.searchResults objectAtIndex:indexPath.row];
    courseName = [courseName stringByAppendingString:@" - "];
    courseName = [courseName stringByAppendingString:[self.courseDegreeTitles objectAtIndex:indexPath.row]];
    cell.textLabel.text = courseName;
    
    //cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([self.universitySearchedString isEqualToString:@""]) {
        cell.detailTextLabel.text = [self.universityNamesForSearchResults objectAtIndex:indexPath.row];
    } else {
        cell.detailTextLabel.text = self.universitySearchedString;
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}



#pragma mark - Table view delegate

//In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller. we create a tab bar controller
    
    CourseInfoCoursePageViewController *courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] initWithNibName:@"CourseInfoCoursePageViewController" bundle:nil];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]initWithNibName:@"StudentSatisfactionCoursePageViewController" bundle:nil];
    
    ReviewsCoursePageViewController *reviewsCoursePageViewController = [[ReviewsCoursePageViewController alloc] initWithNibName:@"ReviewsCoursePageViewController" bundle:nil];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] initWithNibName:@"UniInfoCoursePageViewController" bundle:nil];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] initWithNibName:@"CoursePageTabBarController" bundle:nil];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,reviewsCoursePageViewController,uniInfoCoursePageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell = [self.tableView cellForRowAtIndexPath:indexPath];

    coursePageTabBarController.navigationItem.title = @"Course";
    coursePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favouritesButton"] style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    favouritesButton.tintColor = [UIColor grayColor];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    if (self.universitySearchedString.length != 0) {
        NSLog(@"just about to pass: %@",self.universitySearchedUKPRN);
        courseInfoCoursePageViewController.uniCodeCourseInfo = self.universitySearchedUKPRN;
        uniInfoCoursePageViewController.uniCodeUniInfo = self.universitySearchedUKPRN;
        reviewsCoursePageViewController.uniCodeReviews = self.universitySearchedUKPRN;
        studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = self.universitySearchedUKPRN;
    } else {
        NSLog(@"got to here woo: %@",self.searchResultsUniversityCodes);
        courseInfoCoursePageViewController.uniCodeCourseInfo = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
        uniInfoCoursePageViewController.uniCodeUniInfo = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
        reviewsCoursePageViewController.uniCodeReviews = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
        studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
    }
    
    NSLog(@"just about to pass course code: %@,does anything exist? %@",[self.searchResultsCourseCodes objectAtIndex:indexPath.row],self.searchResultsCourseCodes);
    
    // push to the next view controllers the course code and ukprn
    
    courseInfoCoursePageViewController.courseCodeCourseInfo = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
    courseInfoCoursePageViewController.courseNameCourseInfo = cell.textLabel.text;
    courseInfoCoursePageViewController.uniNameCourseInfo = cell.detailTextLabel.text;
    
    reviewsCoursePageViewController.courseCodeReviews = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
    reviewsCoursePageViewController.courseNameReviews = cell.textLabel.text;
    reviewsCoursePageViewController.uniNameReviews = cell.detailTextLabel.text;
    
    studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
    studentSatisfactionCoursePageViewController.courseNameStudentSatisfaction = cell.textLabel.text;
    studentSatisfactionCoursePageViewController.uniNameStudentSatisfaction = cell.detailTextLabel.text;
    
    uniInfoCoursePageViewController.haveWeComeFromUniversities = NO;
    uniInfoCoursePageViewController.uniNameUniInfo = cell.detailTextLabel.text;

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
