//
//  SearchResultsTableViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchResultsTableViewController.h"


@class Courses;

@interface SearchResultsTableViewController ()


@property (nonatomic) int limit;
@property (nonatomic) int skip;
@property (nonatomic, strong) NSString *universitySearchedUKPRN;


@end

@implementation SearchResultsTableViewController

@synthesize allCourses,favouritesButton,tableView,universitySearchedString,courseSearchedString,locationSearchedString,searchResults,universityUKPRNString,searchResultsUniversityCodes,searchResultsCourseCodes,activityIndicator,limit,skip,courseDegreeTitles,universitySearchedUKPRN,haveFoundEverySeachValue,anyResults,courseInfoCoursePageViewController,firstTimeLoad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //set navigation bar title
        self.navigationItem.title = @"Results";

    }
    return self;
}

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.hidden = YES;
    //CGRect screenBound = [[UIScreen mainScreen] bounds];
    //self.tableView.frame = CGRectMake(0, 90, 320, screenBound.size.height - 90 - self.tabBarController.tabBar.frame.size.height - 64);
    [self.activityIndicator startAnimating];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.limit = 12;
    self.skip = 0;
    self.searchResults = [[NSMutableArray alloc] init];
    self.searchResultsCourseCodes = [[NSMutableArray alloc] init];
    self.courseSearchResultsKisAimCodes = [[NSMutableArray alloc] init];
    self.courseDegreeTitles = [[NSMutableArray alloc] init];
    self.universityNamesForSearchResults = [[NSMutableArray alloc] init];
    self.searchResultsUniversityCodes = [[NSMutableArray alloc] init];
    self.haveFoundEverySeachValue = NO;
    self.anyResults = YES;
    self.firstTimeLoad = YES;

    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View Will/Did Appear

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.firstTimeLoad == YES) {
        NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        
        if (data) {
            [self queryForSearchResults];
        } else {
            UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noInternetAlert show];
        }
        self.firstTimeLoad = NO;
    }
    
    

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
            NSRange range = [courseSearchedString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"()[]"]];
            NSLog(@"range: %lu and %lu",(unsigned long)range.location,(unsigned long)range.length);
            if (range.length == 0) {
                NSLog(@"No weird symbols");
                [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];

            } else {
                NSLog(@"weird symbols");
                [bigQuery whereKey:@"TITLE" equalTo:courseSearchedString];
            }
                                                 
            [bigQuery setLimit:self.limit];
            [bigQuery setSkip:self.skip];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                // NSLog(@"objects: %@",objects);
                if (!error) {
                    NSArray *tempNames = [objects valueForKey:@"TITLE"];
                    [self.searchResults addObjectsFromArray:tempNames];
                    [self.searchResultsCourseCodes addObjectsFromArray:[objects valueForKey:@"KISCOURSEID"]];
                    [self.courseSearchResultsKisAimCodes addObjectsFromArray:[objects valueForKey:@"KISAIMCODE"]];
                    [self.courseDegreeTitles addObjectsFromArray:[objects valueForKey:@"CourseHonour"]];
                    if (objects.count == 0) {
                        self.haveFoundEverySeachValue = YES;
                    }
                    NSLog(@"search results: %@",self.searchResults);
                    self.skip += self.limit;
                    NSLog(@"self.skip : %d",self.skip);
                    if (self.searchResults.count == 0) {
                        self.anyResults = NO;
                        [self.searchResults addObject:@"No Results"];
                        [self.courseDegreeTitles addObject:@""];
                    }
                    self.tableView.hidden = NO;
                    [self.activityIndicator stopAnimating];
                    [self.tableView reloadData];
                }
                
                else {
                    NSString *errorMessage = [NSString stringWithFormat:@"%@",[error localizedDescription]];
                    UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [noInternetAlert show];
                }
                
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
                if (!error) {
                    NSArray *tempNames = [objects valueForKey:@"TITLE"];
                    [self.searchResults addObjectsFromArray:tempNames];
                    [self.searchResultsCourseCodes addObjectsFromArray:[objects valueForKey:@"KISCOURSEID"]];
                    [self.courseSearchResultsKisAimCodes addObjectsFromArray:[objects valueForKey:@"KISAIMCODE"]];
                    [self.courseDegreeTitles addObjectsFromArray:[objects valueForKey:@"CourseHonour"]];
                    if (objects.count == 0) {
                        self.haveFoundEverySeachValue = YES;
                    }
                    NSLog(@"search results: %@",self.searchResults);
                    self.skip += self.limit;
                    NSLog(@"self.skip : %d",self.skip);
                    if (self.searchResults.count == 0) {
                        [self.searchResults addObject:@"No Results"];
                        [self.courseDegreeTitles addObject:@""];
                        [self.universityNamesForSearchResults addObject:@""];
                        self.anyResults = NO;
                    }
                    self.tableView.hidden = NO;
                    [self.activityIndicator stopAnimating];
                    [self.tableView reloadData];
                }
                else {
                    NSString *errorMessage = [NSString stringWithFormat:@"%@",[error localizedDescription]];
                    UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [noInternetAlert show];
                }
                
            }];
            
        }
    }
    
    //if the user has searched by course and location
    
    else if (self.universitySearchedString.length == 0)
    {
        
        
        NSLog(@"LOCAION: %@",self.locationSearchedString);
        //first get possible university UKPRNs using location
        if (self.locationSearchedString.length != 0) {
            
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
            NSLog(@"possible unis count: %lu",(unsigned long)locationUniversityUKPRNS.count);
            NSLog(@"number of possible unis: %lu",(unsigned long)locationUniversityUKPRNS.count);
            
            // we use the cumulative search results to keep adding results
            
            NSMutableArray *cumulativeSearchResults = [[NSMutableArray alloc] init];
            [cumulativeSearchResults removeAllObjects];
            
            for (int i=0; i < locationUniversityUKPRNS.count; i++) {
                // now query courses using ukprns
                NSLog(@"i value: %d",i);
                PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
                NSRange range = [courseSearchedString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"()[]"]];
                NSLog(@"range: %lu and %lu",(unsigned long)range.location,(unsigned long)range.length);
                if (range.length == 0) {
                    NSLog(@"No weird symbols");
                    [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
                    
                } else {
                    NSLog(@"weird symbols");
                    [bigQuery whereKey:@"TITLE" equalTo:courseSearchedString];
                }
                // find this number per university
                if (locationUniversityUKPRNS.count >5) {
                    [bigQuery setLimit:2];
                } else {
                    [bigQuery setLimit:5];
                }
                [bigQuery setSkip:self.skip];
                NSLog(@"ukprn: %@",[locationUniversityUKPRNS objectAtIndex:i]);
                [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
                [bigQuery orderByAscending:@"TITLE"];
                [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    // now find university name
                    if (!error) {
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
                        NSLog(@"cum search results count: %lu",(unsigned long)cumulativeSearchResults.count);
                        
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
                            [self.courseDegreeTitles addObjectsFromArray:[cumulativeSearchResults valueForKey:@"CourseHonour"]];
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
                            if (self.searchResults.count == 0) {
                                [self.searchResults addObject:@"No Results"];
                                [self.courseDegreeTitles addObject:@""];
                                [self.universityNamesForSearchResults addObject:@""];
                                self.anyResults = NO;
                            }
                            self.tableView.hidden = NO;
                            [self.activityIndicator stopAnimating];
                            [self.tableView reloadData];
                        }
                    }
                    else {
                        NSString *errorMessage = [NSString stringWithFormat:@"%@",[error localizedDescription]];
                        UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [noInternetAlert show];
                    }
                }];
                
            }
        }
        //if user has searched only by course
        else {
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            NSRange range = [courseSearchedString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"()[]"]];
            NSLog(@"range: %lu and %lu",(unsigned long)range.location,(unsigned long)range.length);
            if (range.length == 0) {
                NSLog(@"No weird symbols");
                [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
                
            } else {
                NSLog(@"weird symbols");
                [bigQuery whereKey:@"TITLE" equalTo:courseSearchedString];
            }
            // find this number per university
            [bigQuery setLimit:12];
            [bigQuery setSkip:self.skip];
            [bigQuery whereKeyExists:@"UKPRN"];
            [bigQuery orderByAscending:@"TITLE"];
            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                // now find university name
                if (!error) {
                    for (PFObject *object in objects) {
                        PFQuery *universityNameQuery = [PFQuery queryWithClassName:@"Institution1213"];
                        [universityNameQuery whereKey:@"UKPRN" equalTo:[object valueForKey:@"UKPRN"]];
                        [universityNameQuery selectKeys:[NSArray arrayWithObject:@"Institution"]];
                        PFObject *tempObject = [universityNameQuery getFirstObject];
                        if (tempObject != NULL) {
                            NSString *universityNameTemp = [tempObject valueForKey:@"Institution"];
                            NSLog(@"uni name temp: %@",universityNameTemp);
                            NSLog(@"university code: %@, course codes: %@, course names: %@",[object valueForKey:@"UKPRN"],self.searchResultsCourseCodes,self.searchResults);
                            [self.universityNamesForSearchResults addObject:universityNameTemp];
                            [self.searchResultsUniversityCodes addObject:[object valueForKey:@"UKPRN"]];
                            [self.searchResults addObject:[object valueForKey:@"TITLE"]];
                            [self.searchResultsCourseCodes addObject:[object valueForKey:@"KISCOURSEID"]];
                            [self.courseSearchResultsKisAimCodes addObject:[object valueForKey:@"KISAIMCODE"]];
                            [self.courseDegreeTitles addObject:[object valueForKey:@"CourseHonour"]];
                            NSLog(@"SECOND IME university code: %@, course codes: %@, course names: %@",[object valueForKey:@"UKPRN"],self.searchResultsCourseCodes,self.searchResults);
                            
                        }
                        
                    }
                    
                    if (objects.count == 0) {
                        self.haveFoundEverySeachValue = YES;
                    }
                    NSLog(@"search results: %@",self.searchResults);
                    self.skip += 10;
                    NSLog(@"self.skip : %d",self.skip);
                    if (self.searchResults.count == 0) {
                        [self.searchResults addObject:@"No Results"];
                        [self.courseDegreeTitles addObject:@""];
                        [self.universityNamesForSearchResults addObject:@""];
                        self.anyResults = NO;
                    }
                    self.tableView.hidden = NO;
                    [self.activityIndicator stopAnimating];
                    [self.tableView reloadData];
                }
                else {
                    NSString *errorMessage = [NSString stringWithFormat:@"%@",[error localizedDescription]];
                    UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [noInternetAlert show];
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
    NSLog(@"count: %lu",(unsigned long)self.searchResults.count);
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
    NSLog(@"course names count: %lu and course codes count: %lu",(unsigned long)self.searchResults.count,(unsigned long)self.courseDegreeTitles.count);
    
    NSString *courseName = [self.searchResults objectAtIndex:indexPath.row];
    courseName = [courseName stringByAppendingString:@" - "];
    courseName = [courseName stringByAppendingString:[self.courseDegreeTitles objectAtIndex:indexPath.row]];
    cell.textLabel.text = courseName;
    if (self.anyResults == NO) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"No results";
    }
    else {
       // cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if ([self.universitySearchedString isEqualToString:@""]) {
            cell.detailTextLabel.text = [self.universityNamesForSearchResults objectAtIndex:indexPath.row];
        } else {
            cell.detailTextLabel.text = self.universitySearchedString;
        }
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    return cell;
}



#pragma mark - Table view delegate

//In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller. we create a tab bar controller
    if (self.anyResults == NO) {
        
    } else {
        
        courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] initWithNibName:@"CourseInfoCoursePageViewController" bundle:nil];
        
        StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]initWithNibName:@"StudentSatisfactionCoursePageViewController" bundle:nil];
        
        ContactUniversityPageViewController*contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] initWithNibName:@"ContactUniversityPageViewController" bundle:nil];
        
        UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] initWithNibName:@"UniInfoCoursePageViewController" bundle:nil];
        
        UITabBarController *coursePageTabBarController = [[UITabBarController alloc] initWithNibName:@"CoursePageTabBarController" bundle:nil];
        
        coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,uniInfoCoursePageViewController,contactUniversityPageViewController,nil];
        
        // Pass the selected object to the new view controller.
        
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        coursePageTabBarController.navigationItem.title = @"Course";
        coursePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [coursePageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
        
        
        if (self.universitySearchedString.length != 0) {
            NSLog(@"just about to pass: %@",self.universitySearchedUKPRN);
            courseInfoCoursePageViewController.uniCodeCourseInfo = self.universitySearchedUKPRN;
            uniInfoCoursePageViewController.uniCodeUniInfo = self.universitySearchedUKPRN;
            contactUniversityPageViewController.universityCode = self.universitySearchedUKPRN;
            studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = self.universitySearchedUKPRN;
            NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",[self.searchResultsCourseCodes objectAtIndex:indexPath.row],self.universitySearchedUKPRN] andSortKey:@"courseName"];
            NSLog(@"has it worked? %@",[temp2 valueForKey:@"courseName"]);
            if (temp2.count != 0) {
                favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
                favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
                [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
                courseInfoCoursePageViewController.isItFavourite = YES;
            } else {
                favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
                favouritesButton.tintColor = [UIColor whiteColor];
                [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
                courseInfoCoursePageViewController.isItFavourite = NO;
            }
            
        } else {
            NSLog(@"got to here woo: %@",self.searchResultsUniversityCodes);
            courseInfoCoursePageViewController.uniCodeCourseInfo = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
            uniInfoCoursePageViewController.uniCodeUniInfo = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
            contactUniversityPageViewController.universityCode = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
            studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = [self.searchResultsUniversityCodes objectAtIndex:indexPath.row];
            NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",[self.searchResultsCourseCodes objectAtIndex:indexPath.row],[self.searchResultsUniversityCodes objectAtIndex:indexPath.row]] andSortKey:@"courseName"];
            NSLog(@"has it worked? %@",[temp2 valueForKey:@"courseName"]);
            if (temp2.count != 0) {
                favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
                favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
                courseInfoCoursePageViewController.isItFavourite = YES;
                [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
            } else {
                favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
                favouritesButton.tintColor = [UIColor whiteColor];
                courseInfoCoursePageViewController.isItFavourite = NO;
                [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
            }
        }
        
        //NSLog(@"just about to pass course code: %@,does anything exist? %@",[self.searchResultsCourseCodes objectAtIndex:indexPath.row],self.searchResultsCourseCodes);
        
        // push to the next view controllers the course code and ukprn
        
        courseInfoCoursePageViewController.courseCodeCourseInfo = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
        courseInfoCoursePageViewController.courseNameCourseInfo = cell.textLabel.text;
        courseInfoCoursePageViewController.uniNameCourseInfo = cell.detailTextLabel.text;
        courseInfoCoursePageViewController.haveComeFromFavourites = NO;
        
        contactUniversityPageViewController.universityName = cell.detailTextLabel.text;
        
        studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
        studentSatisfactionCoursePageViewController.courseNameStudentSatisfaction = cell.textLabel.text;
        studentSatisfactionCoursePageViewController.uniNameStudentSatisfaction = cell.detailTextLabel.text;
        
        uniInfoCoursePageViewController.haveWeComeFromUniversities = NO;
        uniInfoCoursePageViewController.uniNameUniInfo = cell.detailTextLabel.text;
        
        NSLog(@"course code: %@",[self.searchResultsCourseCodes objectAtIndex:indexPath.row]);
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        // Push the view controller.
        [self.navigationController pushViewController:coursePageTabBarController animated:YES];
    }
}

-(void) callAnotherMethod {
    
    courseInfoCoursePageViewController.favouritesButton = self.favouritesButton;
    [courseInfoCoursePageViewController customBtnPressed];
}


@end
