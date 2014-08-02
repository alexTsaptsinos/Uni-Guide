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

@synthesize allCourses,favouritesButton,tableView,customFilterButton,universitySearchedString,courseSearchedString,locationSearchedString,searchResults,universityUKPRNString,searchResultsUniversityCodes,searchResultsCourseCodes,activityIndicator,limit,skip,courseDegreeTitles,universitySearchedUKPRN;

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
    
    //    NSLog(@"searched university: %@ and searched course: %@ and locaton searched: %@", self.universitySearchedString,self.courseSearchedString,self.locationSearchedString);
    //
    //    // if user has searched for university, first get UKPRN (location has automatically loaded)
    //
    //    if (self.universitySearchedString.length != 0) {
    //
    //        PFQuery *queryForUKPRN = [PFQuery queryWithClassName:@"Institution1213"];
    //        [queryForUKPRN whereKey:@"Institution" equalTo:self.universitySearchedString];
    //        [queryForUKPRN selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
    //        PFObject *ukprnObject = [queryForUKPRN getFirstObject];
    //        NSString *ukprn = [ukprnObject valueForKey:@"UKPRN"];
    //
    //        //if the user has searched for university (and location) and course (location automatically loaded)
    //
    //        if (self.courseSearchedString.length != 0) {
    //            NSLog(@"code to search: %@ and course to search: %@", ukprn,courseSearchedString);
    //            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
    //            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
    //            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
    //            [bigQuery setLimit:100];
    //            [bigQuery whereKeyExists:@"TITLE"];
    //            [bigQuery orderByAscending:@"TITLE"];
    //            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
    //                NSLog(@"objects: %@",objects);
    //                self.searchResults = [objects valueForKey:@"TITLE"];
    //                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
    //                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
    //                //NSLog(@"search results: %@",self.searchResults);
    //                self.tableView.hidden = NO;
    //                [self.activityIndicator stopAnimating];
    //                [self.tableView reloadData];
    //            }];
    //        }
    //
    //        // if the user has searched for university and location but not course (location automatically loaded)
    //
    //        else if (self.courseSearchedString.length == 0) {
    //
    //            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
    //            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
    //            [bigQuery whereKeyExists:@"TITLE"];
    //            [bigQuery setLimit:600];
    //            [bigQuery orderByAscending:@"TITLE"];
    //            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
    //                //NSLog(@"objects: %@",objects);
    //                self.searchResults = [objects valueForKey:@"TITLE"];
    //                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
    //                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
    //                //NSLog(@"search results: %@",self.searchResults);
    //                self.tableView.hidden = NO;
    //                [self.activityIndicator stopAnimating];
    //                [self.tableView reloadData];
    //            }];
    //
    //        }
    //    }
    //
    //    //if the user has searched by course and location
    //
    //    else if (self.universitySearchedString.length == 0) {
    //
    //        //first get possible university UKPRNs using location
    //
    //        NSDictionary *locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
    //
    //        NSArray *locationIDArray = [locationDict allKeysForObject:self.locationSearchedString];
    //        NSString *locationID = [locationIDArray objectAtIndex:0];
    //        NSLog(@"array: %@ and ID: %@",locationIDArray,locationID);
    //
    //        PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Institution1213"];
    //        [locationsQuery whereKeyExists:@"UKPRN"];
    //        [locationsQuery selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
    //        [locationsQuery whereKey:@"RegionOfInstitution" equalTo:locationID];
    //        NSArray *locationUniversityObjects = [locationsQuery findObjects];
    //        NSArray *locationUniversityUKPRNS = [locationUniversityObjects valueForKey:@"UKPRN"];
    //        NSLog(@"possible unis: %@",locationUniversityUKPRNS);
    //
    //        NSLog(@"number of possible unis: %d",locationUniversityUKPRNS.count);
    //
    //        NSMutableArray *cumulativeSeachResults = [[NSMutableArray alloc] init];
    //
    //        for (int i=0; i < locationUniversityUKPRNS.count; i++) {
    //            // now query courses using ukprns
    //            NSLog(@"i value: %d",i);
    //            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
    //            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
    //            [bigQuery setLimit:1000];
    //            NSLog(@"ukprn: %@",[locationUniversityUKPRNS objectAtIndex:i]);
    //            [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
    //            [bigQuery whereKeyExists:@"TITLE"];
    //            [bigQuery orderByAscending:@"TITLE"];
    //           // NSArray *tempResults = [bigQuery findObjects];
    //            [cumulativeSeachResults addObjectsFromArray:[bigQuery findObjects]];
    //            NSLog(@"search results: %@ and count: %d",cumulativeSeachResults,cumulativeSeachResults.count);
    //            if (i == locationUniversityUKPRNS.count - 1) {
    //                self.searchResults = [cumulativeSeachResults valueForKey:@"TITLE"];
    //                self.searchResultsUniversityCodes = [cumulativeSeachResults valueForKey:@"UKPRN"];
    //                self.courseSearchResultsKisAimCodes = [cumulativeSeachResults valueForKey:@"KISAIMCODE"];
    //                self.searchResultsCourseCodes = [cumulativeSeachResults valueForKey:@"KISCODE"];
    //                self.tableView.hidden = NO;
    //                [self.activityIndicator stopAnimating];
    //                [self.tableView reloadData];
    //            }
    
    
    //            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
    //               // NSLog(@"objects: %@",objects);
    //                [cumulativeSeachResults addObjectsFromArray:[objects valueForKey:@"TITLE"]];
    //                //self.searchResults = [objects valueForKey:@"TITLE"];
    //                //self.searchResultsUniversityCodes = [objects valueForKey:@"UKPRN"];
    //               // self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
    //               // self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
    //                NSLog(@"search results: %@ and count: %d",cumulativeSeachResults,cumulativeSeachResults.count);
    //                if (i == locationUniversityUKPRNS.count - 1) {
    //                    self.searchResults = cumulativeSeachResults;
    //                    self.tableView.hidden = NO;
    //                    [self.activityIndicator stopAnimating];
    //                    [self.tableView reloadData];
    //                }
    //
    //            }];
    //   }
    
    
    
    //  }
    
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
    self.limit = 5;
    self.skip = 0;
    [self queryForSearchResults];
    self.searchResults = [[NSMutableArray alloc] init];
    self.searchResultsCourseCodes = [[NSMutableArray alloc] init];
    self.courseSearchResultsKisAimCodes = [[NSMutableArray alloc] init];
    self.courseDegreeTitles = [[NSMutableArray alloc] init];
    
//    NSLog(@"searched university: %@ and searched course: %@ and locaton searched: %@", self.universitySearchedString,self.courseSearchedString,self.locationSearchedString);
//    
//    // if user has searched for university, first get UKPRN (location has automatically loaded)
//    
//    if (self.universitySearchedString.length != 0) {
//        
//        PFQuery *queryForUKPRN = [PFQuery queryWithClassName:@"Institution1213"];
//        [queryForUKPRN whereKey:@"Institution" equalTo:self.universitySearchedString];
//        [queryForUKPRN selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
//        PFObject *ukprnObject = [queryForUKPRN getFirstObject];
//        NSString *ukprn = [ukprnObject valueForKey:@"UKPRN"];
//        
//        //if the user has searched for university (and location) and course (location automatically loaded)
//        
//        if (self.courseSearchedString.length != 0) {
//            NSLog(@"code to search: %@ and course to search: %@", ukprn,courseSearchedString);
//            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
//            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
//            [bigQuery setLimit:100];
//            [bigQuery whereKeyExists:@"TITLE"];
//            [bigQuery orderByAscending:@"TITLE"];
//            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
//                NSLog(@"objects: %@",objects);
//                self.searchResults = [objects valueForKey:@"TITLE"];
//                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
//                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
//                //NSLog(@"search results: %@",self.searchResults);
//                self.tableView.hidden = NO;
//                [self.activityIndicator stopAnimating];
//                [self.tableView reloadData];
//            }];
//        }
//        
//        // if the user has searched for university and location but not course (location automatically loaded)
//        
//        else if (self.courseSearchedString.length == 0) {
//            
//            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//            [bigQuery whereKey:@"UKPRN" equalTo:ukprn];
//            [bigQuery whereKeyExists:@"TITLE"];
//            [bigQuery setLimit:600];
//            [bigQuery orderByAscending:@"TITLE"];
//            [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
//                //NSLog(@"objects: %@",objects);
//                self.searchResults = [objects valueForKey:@"TITLE"];
//                self.courseSearchResultsKisAimCodes = [objects valueForKey:@"KISAIMCODE"];
//                self.searchResultsCourseCodes = [objects valueForKey:@"KISCODE"];
//                //NSLog(@"search results: %@",self.searchResults);
//                self.tableView.hidden = NO;
//                [self.activityIndicator stopAnimating];
//                [self.tableView reloadData];
//            }];
//            
//        }
//    }
//    
//    //if the user has searched by course and location
//    
//    else if (self.universitySearchedString.length == 0) {
//        
//        //first get possible university UKPRNs using location
//        
//        NSDictionary *locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
//        
//        NSArray *locationIDArray = [locationDict allKeysForObject:self.locationSearchedString];
//        NSString *locationID = [locationIDArray objectAtIndex:0];
//        NSLog(@"array: %@ and ID: %@",locationIDArray,locationID);
//        
//        PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Institution1213"];
//        [locationsQuery whereKeyExists:@"UKPRN"];
//        [locationsQuery selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
//        [locationsQuery whereKey:@"RegionOfInstitution" equalTo:locationID];
//        NSArray *locationUniversityObjects = [locationsQuery findObjects];
//        NSArray *locationUniversityUKPRNS = [locationUniversityObjects valueForKey:@"UKPRN"];
//        NSLog(@"possible unis: %@",locationUniversityUKPRNS);
//        
//        NSLog(@"number of possible unis: %d",locationUniversityUKPRNS.count);
//        
//        NSMutableArray *cumulativeSeachResults = [[NSMutableArray alloc] init];
//        
//        for (int i=0; i < locationUniversityUKPRNS.count; i++) {
//            // now query courses using ukprns
//            NSLog(@"i value: %d",i);
//            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
//            [bigQuery setLimit:1000];
//            NSLog(@"ukprn: %@",[locationUniversityUKPRNS objectAtIndex:i]);
//            [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
//            [bigQuery whereKeyExists:@"TITLE"];
//            [bigQuery orderByAscending:@"TITLE"];
//            // NSArray *tempResults = [bigQuery findObjects];
//            [cumulativeSeachResults addObjectsFromArray:[bigQuery findObjects]];
//            NSLog(@"search results: %@ and count: %d",cumulativeSeachResults,cumulativeSeachResults.count);
//            if (i == locationUniversityUKPRNS.count - 1) {
//                self.searchResults = [cumulativeSeachResults valueForKey:@"TITLE"];
//                self.searchResultsUniversityCodes = [cumulativeSeachResults valueForKey:@"UKPRN"];
//                self.courseSearchResultsKisAimCodes = [cumulativeSeachResults valueForKey:@"KISAIMCODE"];
//                self.searchResultsCourseCodes = [cumulativeSeachResults valueForKey:@"KISCODE"];
//                self.tableView.hidden = NO;
//                [self.activityIndicator stopAnimating];
//                [self.tableView reloadData];
//            }
//        }
//    }
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
                for (NSString *aimCodes in self.courseSearchResultsKisAimCodes) {
                    PFQuery *queryForHonourReceived = [PFQuery queryWithClassName:@"Kisaim"];
                    [queryForHonourReceived whereKey:@"KISAIMCODE" equalTo:aimCodes];
                    PFObject *object = [queryForHonourReceived getFirstObject];
                    NSString *courseHonour = [object valueForKey:@"KISAIMLABEL"];
                    [self.courseDegreeTitles addObject:courseHonour];
                    
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
        
        NSArray *locationIDArray = [locationDict allKeysForObject:self.locationSearchedString];
        NSString *locationID = [locationIDArray objectAtIndex:0];
        NSLog(@"array: %@ and ID: %@",locationIDArray,locationID);
        
        PFQuery *locationsQuery = [PFQuery queryWithClassName:@"Institution1213"];
        [locationsQuery whereKeyExists:@"UKPRN"];
        [locationsQuery selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
        [locationsQuery whereKey:@"RegionOfInstitution" equalTo:locationID];
        NSArray *locationUniversityObjects = [locationsQuery findObjects];
        NSArray *locationUniversityUKPRNS = [locationUniversityObjects valueForKey:@"UKPRN"];
        NSLog(@"possible unis: %@",locationUniversityUKPRNS);
        
        NSLog(@"number of possible unis: %d",locationUniversityUKPRNS.count);
        
        NSMutableArray *cumulativeSeachResults = [[NSMutableArray alloc] init];
        
        for (int i=0; i < locationUniversityUKPRNS.count; i++) {
            // now query courses using ukprns
            NSLog(@"i value: %d",i);
            PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
            [bigQuery whereKey:@"TITLE" matchesRegex:courseSearchedString modifiers:@"i"];
            [bigQuery setLimit:self.limit];
            [bigQuery setSkip:self.skip];
            NSLog(@"ukprn: %@",[locationUniversityUKPRNS objectAtIndex:i]);
            [bigQuery whereKey:@"UKPRN" equalTo:[locationUniversityUKPRNS objectAtIndex:i]];
            [bigQuery whereKeyExists:@"TITLE"];
            [bigQuery orderByAscending:@"TITLE"];
            // NSArray *tempResults = [bigQuery findObjects];
            [cumulativeSeachResults addObjectsFromArray:[bigQuery findObjects]];
            NSLog(@"search results: %@ and count: %d",cumulativeSeachResults,cumulativeSeachResults.count);
            if (i == locationUniversityUKPRNS.count - 1) {
                self.searchResults = [cumulativeSeachResults valueForKey:@"TITLE"];
                self.searchResultsUniversityCodes = [cumulativeSeachResults valueForKey:@"UKPRN"];
                self.courseSearchResultsKisAimCodes = [cumulativeSeachResults valueForKey:@"KISAIMCODE"];
                self.searchResultsCourseCodes = [cumulativeSeachResults valueForKey:@"KISCOURSEID"];
                self.skip += self.limit;
                NSLog(@"self.skip : %d",self.skip);
                self.tableView.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
            }
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
        [self queryForSearchResults];
    }
    
    //    // Configure the cell...
    
    NSString *courseName = [self.searchResults objectAtIndex:indexPath.row];
    courseName = [courseName stringByAppendingString:@" - "];
    courseName = [courseName stringByAppendingString:[self.courseDegreeTitles objectAtIndex:indexPath.row]];
    NSLog(@"course name; %@",courseName);
    cell.textLabel.text = courseName;
    
    //cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
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
    
    if (self.universitySearchedString != 0) {
        NSLog(@"just about to pass: %@",self.universitySearchedUKPRN);
        courseInfoCoursePageViewController.uniCodeCourseInfo = self.universitySearchedUKPRN;
    }
    
    NSLog(@"just about to pass course code: %@,does anything exist? %@",[self.searchResultsCourseCodes objectAtIndex:indexPath.row],self.searchResultsCourseCodes);
    
    courseInfoCoursePageViewController.courseCodeCourseInfo = [self.searchResultsCourseCodes objectAtIndex:indexPath.row];
    
//    PFQuery *queryForUniversityCode = [PFQuery queryWithClassName:@"Institution1213"];
//    [queryForUniversityCode whereKey:@"Institution" equalTo:cell.detailTextLabel.text];
//    PFObject *universityObject = [queryForUniversityCode getFirstObject];
//    uniInfoCoursePageViewController.universityObject = universityObject;
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
