//
//  UniversitiesListViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesListViewController.h"
#import "University.h"
#import "UniversityManager.h"
#import "UniversityCommunicator.h"
#import "UniInfoCoursePageViewController.h"
#import "CourseListTableViewController.h"
#import "OpenDaysUniversityPageTableViewController.h"
#import "ContactUniversityPageViewController.h"

@interface UniversitiesListViewController () <UniversityManagerDelegate> {
    
    NSArray *_universities;
    UniversityManager *_manager;
}

@end

@implementation UniversitiesListViewController

@synthesize filteredUniversityArray,universityListTableView,universitySearchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Universities";
    _manager = [[UniversityManager alloc] init];
    _manager.communicator = [[UniversityCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [_manager fetchAllUniversities];
    
    
    
    NSLog(@"time check");
    
    // Initialize the filteredUniversitiesArray with a capacity equal to the universityArray's capacity
    self.filteredUniversityArray = [NSMutableArray arrayWithCapacity:[_universities count]];
}

//- (void)startFetchingUniversities:(NSNotification *)notification
//{
//    [_manager fetchAllUniversities];
//}

-(void)didReceiveUniversities:(NSArray *)universities
{
    _universities = universities;
    [self.universityListTableView reloadData];
}

-(void)fetchingUniversitiesFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)universityListTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    //Return the number of rows in the section.
//    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
//    if (universityListTableView2 == self.searchDisplayController.searchResultsTableView) {
//        return [filteredUniversityArray count];
//    } else {
//        return [_universities count];
//    }
    
    return _universities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [universityListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //Create a new Universities Object
    University *university = nil;
    // Check to see whether the normal table or search results table is being displayed and set the Universities object from the appropriate array
//    if (universityListTableView2 == self.searchDisplayController.searchResultsTableView) {
//        university = [filteredUniversityArray objectAtIndex:indexPath.row];
//    } else {
//        university = [_universities objectAtIndex:indexPath.row];
//    }
    
    university = [_universities objectAtIndex:indexPath.row];
    
    // Configure the cell
    cell.textLabel.text = university.name;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size: 15];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
    //Update the filtered array based on the search text
    //Remove all objects from the filtered search array
    [self.filteredUniversityArray removeAllObjects];
    //Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredUniversityArray = [NSMutableArray arrayWithArray:[_universities filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    //Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] init];
    
    OpenDaysUniversityPageTableViewController *openDaysUniversityPageTableViewController = [[OpenDaysUniversityPageTableViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListTableViewController,openDaysUniversityPageTableViewController,contactUniversityPageViewController,nil];
    
    University *tempUniversity = _universities[indexPath.row];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = tempUniversity.name;
    universityTitle.text = tempUniversity.name;
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
