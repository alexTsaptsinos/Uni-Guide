//
//  UniversitiesTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 26/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesTableViewController.h"
#import "ContactUniversityPageViewController.h"
#import "CourseListTableViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "OpenDaysUniversityPageTableViewController.h"
#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface UniversitiesTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate> {
    
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, retain) NSMutableDictionary *sections;
@property (nonatomic, retain) NSMutableDictionary *sectionToLetterMap;

@end

@implementation UniversitiesTableViewController

@synthesize alphabetsArray;
@synthesize sections = _sections;
@synthesize  sectionToLetterMap = _sectionToLetterMap;;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //this table displays items in the universities class
        self.parseClassName = @"Universities";
        self.textKey = @"Name";
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = YES;
        self.objectsPerPage = 415;
        self.navigationItem.title = @"Universities";
        self.navigationController.navigationBar.translucent = NO;
        self.sections = [NSMutableDictionary dictionary];
        self.sectionToLetterMap = [NSMutableDictionary dictionary];
        self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

        
    }
    return self;
}

-(void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    [self.sections removeAllObjects];
    [self.sectionToLetterMap removeAllObjects];

    NSInteger section = 0;
    NSInteger rowIndex = 0;
    for (PFObject *object in self.objects) {
        NSString *universityName = [object objectForKey:@"SortableName"];
        NSString *letter = [[universityName substringToIndex:1] uppercaseString];
        NSMutableArray *objectsInSection = [self.sections objectForKey:letter];
        if (!objectsInSection) {
            objectsInSection = [NSMutableArray array];

            // this is the first time we see this sportType - increment the section index
            [self.sectionToLetterMap setObject:letter forKey:[NSNumber numberWithInt:section++]];
        }

        [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
        [self.sections setObject:objectsInSection forKey:letter];
}
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // if no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByAscending:@"SortableName"];

    return query;
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *letter = [self letterForSection:indexPath.section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:letter];
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    return [self.objects objectAtIndex:[rowIndex intValue]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = self.searchBar;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;

    
    self.searchResults = [NSMutableArray array];
    alphabetsArray = [[NSMutableArray alloc] init];
    [alphabetsArray addObject:@"A"];
    [alphabetsArray addObject:@"B"];
    [alphabetsArray addObject:@"C"];
    [alphabetsArray addObject:@"D"];
    [alphabetsArray addObject:@"E"];
    [alphabetsArray addObject:@"F"];
    [alphabetsArray addObject:@"G"];
    [alphabetsArray addObject:@"H"];
    [alphabetsArray addObject:@"I"];
    [alphabetsArray addObject:@"J"];
    [alphabetsArray addObject:@"K"];
    [alphabetsArray addObject:@"L"];
    [alphabetsArray addObject:@"M"];
    [alphabetsArray addObject:@"N"];
    [alphabetsArray addObject:@"O"];
    [alphabetsArray addObject:@"P"];
    [alphabetsArray addObject:@"Q"];
    [alphabetsArray addObject:@"R"];
    [alphabetsArray addObject:@"S"];
    [alphabetsArray addObject:@"T"];
    [alphabetsArray addObject:@"U"];
    [alphabetsArray addObject:@"V"];
    [alphabetsArray addObject:@"W"];
    [alphabetsArray addObject:@"X"];
    [alphabetsArray addObject:@"Y"];
    [alphabetsArray addObject:@"Z"];
}

#pragma mark - methods for sections and indexing

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
     return self.sections.allKeys.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
    NSString *letter = [self letterForSection:section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:letter];
    return rowIndecesInSection.count;
    }
    else
    {
        //NSLog(@"%d", self.searchResults.count);

        return self.searchResults.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        NSString *letter = [self letterForSection:section];
        return letter;
    }
    else {
        return @"";
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return alphabetsArray;
    } else {
        return NULL;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSArray *universityFirstLetters = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"W",@"Y", nil];
    return [universityFirstLetters indexOfObject:title];
}


- (NSString *)letterForSection:(NSInteger)section
{
    return [self.sectionToLetterMap objectForKey:[NSNumber numberWithInt:section]];
}

#pragma mark - methods for search feature

-(void)filterResults:(NSString *)searchTerm {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"SortableName" matchesRegex:searchTerm modifiers:@"i"];
    //query.limit = 415;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.searchResults removeAllObjects];
        [self.searchResults addObjectsFromArray:objects];
       [self.searchDisplayController.searchResultsTableView reloadData];
    }];
    
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterResults:searchString];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //configure the cell
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [object objectForKey:@"Name"];
    } else {
        PFObject *object2 = [PFObject objectWithClassName:@"Universities"];
        object2 = [self.searchResults objectAtIndex:indexPath.row];
        //cell.textLabel.text = [[self.searchResults objectAtIndex:indexPath.row]valueForKey:@"SortableName"];
        cell.textLabel.text = [object2 valueForKey:@"Name"];
    }

    return cell;
}

#pragma mark - methods for when select a row

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] initWithNibName:@"CourseListTableViewController" bundle:nil];
    
    OpenDaysUniversityPageTableViewController *openDaysUniversityPageTableViewController = [[OpenDaysUniversityPageTableViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListTableViewController,openDaysUniversityPageTableViewController,contactUniversityPageViewController,nil];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView != self.searchDisplayController.searchResultsTableView) {
            cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = cell.textLabel.text;
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    universityPageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];

    PFQuery *queryForUniversityCode = [PFQuery queryWithClassName:@"Universities"];
    [queryForUniversityCode whereKey:@"Name" equalTo:cell.textLabel.text];
    PFObject *universityObject = [queryForUniversityCode getFirstObject];
    courseListTableViewController.universityCode = [universityObject valueForKey:@"PUBUKPRN"];
    contactUniversityPageViewController.universityCode = [universityObject valueForKey:@"UKPRN"];
    contactUniversityPageViewController.universityName = cell.textLabel.text;
    openDaysUniversityPageTableViewController.universityName = cell.textLabel.text;
    uniInfoCoursePageViewController.universityObject = universityObject;
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
