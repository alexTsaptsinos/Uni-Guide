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

@synthesize alphabetsArray,hasSearchingCommenced;
@synthesize sections = _sections;
@synthesize  sectionToLetterMap = _sectionToLetterMap;;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //this table displays items in the universities class
        self.parseClassName = @"Institution1213";
        self.textKey = @"Institution";
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = YES;
        self.objectsPerPage = 161;
        self.navigationItem.title = @"Universities";
        self.navigationController.navigationBar.translucent = NO;
        self.sections = [NSMutableDictionary dictionary];
        self.sectionToLetterMap = [NSMutableDictionary dictionary];
        self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        self.hasSearchingCommenced = NO;

        
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
        NSString *universityName = [object objectForKey:@"Institution"];
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
    [query orderByAscending:@"Institution"];

    return query;
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (hasSearchingCommenced == NO) {
        NSString *letter = [self letterForSection:indexPath.section];
        NSArray *rowIndecesInSection = [self.sections objectForKey:letter];
        NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
        return [self.objects objectAtIndex:[rowIndex intValue]];
    } else {
        return NULL;
    }
   
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
    self.searchBar.delegate = self;

    
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    if (tableView == self.tableView) {
        NSString *letter = [self letterForSection:section];
        tempLabel.text = letter;
    } else {
        tempLabel.text = @"";
    }
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return alphabetsArray;
    } else {
        return NULL;
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.hasSearchingCommenced = NO;
    [self objectAtIndexPath:self.tableView.indexPathForSelectedRow];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSArray *universityFirstLetters = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"K",@"L",@"M",@"N",@"O",@"Q",@"R",@"S",@"T",@"U",@"W",@"Y", nil];
    return [universityFirstLetters indexOfObject:title];
}


- (NSString *)letterForSection:(NSInteger)section
{
    return [self.sectionToLetterMap objectForKey:[NSNumber numberWithInt:section]];
}

#pragma mark - methods for search feature

-(void)filterResults:(NSString *)searchTerm {
    
    self.hasSearchingCommenced = YES;
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"Institution" matchesRegex:searchTerm modifiers:@"i"];
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
        cell.textLabel.text = [object objectForKey:@"Institution"];
        
    } else {
        PFObject *object2 = [PFObject objectWithClassName:@"Institution1213"];
        object2 = [self.searchResults objectAtIndex:indexPath.row];
        //cell.textLabel.text = [[self.searchResults objectAtIndex:indexPath.row]valueForKey:@"SortableName"];
        cell.textLabel.text = [object2 valueForKey:@"Institution"];
    }
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

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
    [universityPageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView != self.searchDisplayController.searchResultsTableView) {
            cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = cell.textLabel.text;
    universityTitle.textColor = [UIColor whiteColor];
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    universityPageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];

    PFQuery *queryForUniversityCode = [PFQuery queryWithClassName:@"Institution1213"];
    [queryForUniversityCode whereKey:@"Institution" equalTo:cell.textLabel.text];
    PFObject *universityObject = [queryForUniversityCode getFirstObject];
    courseListTableViewController.universityCode = [universityObject valueForKey:@"UKPRN"];
    contactUniversityPageViewController.universityCode = [universityObject valueForKey:@"UKPRN"];
    contactUniversityPageViewController.universityName = cell.textLabel.text;
    openDaysUniversityPageTableViewController.universityUKPRN = [universityObject valueForKey:@"UKPRN"];
    uniInfoCoursePageViewController.uniCodeUniInfo = [universityObject valueForKey:@"UKPRN"];
    uniInfoCoursePageViewController.haveWeComeFromUniversities = YES;
    uniInfoCoursePageViewController.uniNameUniInfo = cell.textLabel.text;
    courseListTableViewController.universityName = cell.textLabel.text;
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
