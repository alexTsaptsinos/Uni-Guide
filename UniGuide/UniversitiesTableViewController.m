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

@interface UniversitiesTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate> {
    
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *allResults;

@end

@implementation UniversitiesTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //this table displays items in the universities class
        self.parseClassName = @"Universities";
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = YES;
        self.objectsPerPage = 415;
        self.navigationItem.title = @"Universities";
    }
    return self;
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [self.objects count];
    } else {
        return [self.searchResults count];
    }
}

-(void)filterResults:(NSString *)searchTerm {
    [self.searchResults removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    //[query whereKeyExists:@"SortableName"]; //this is based on whatever query you are trying to accomplish
    [query whereKey:@"SortableName" containsString:searchTerm];
    query.limit = 415;
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.searchResults addObjectsFromArray:objects];
       [self.searchDisplayController.searchResultsTableView reloadData];
    }];
    
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterResults:searchString];
    return YES;
}

//-(void)objectsWillLoad
//{
//    [super objectsWillLoad];
//}
//
//-(void)objectsDidLoad:(NSError *)error
//{
//    [super objectsDidLoad:error];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    //    static NSString *cellIdentifier = @"Cell";
    //
    //    PFTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    if (!cell) {
    //        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    //    }
    //
    //    //configure the cell
    //    cell.textLabel.text = object[@"Name"];
    //
    //    return cell;
    
    NSString *uniqueIdentifier = @"universityCell";
    UITableViewCell *cell = nil;
    
    cell = (UITableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    
//    if (!cell) {
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UITableViewCell" owner:nil options:nil];
//        
//        for (id currentObject in topLevelObjects) {
//            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
//                cell = (PFTableViewCell *)currentObject;
//                break;
//            }
//        }
//    }
    if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier];
            }
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        NSString *universityName = [object objectForKey:@"Name"];
        cell.textLabel.text = universityName;
    }
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        
        PFObject *obj2 = [self.searchResults objectAtIndex:indexPath.row];
        PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
        PFObject *searchUniversity = [query getObjectWithId:obj2.objectId];
        NSString *name = [searchUniversity objectForKey:@"Name"];
        cell.textLabel.text = name;
    }
    return cell;
    
    //attempt 3
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
//    
//    static NSString *cellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    //configure the cell
//    if (tableView != self.searchDisplayController.searchResultsTableView) {
//        cell.textLabel.text = [object objectForKey:@"Name"];
//    } else {
//        PFObject *object2 = [PFObject objectWithClassName:@"Universities"];
//        object2 = [self.searchResults objectAtIndex:indexPath.row];
//        //cell.textLabel.text = [[self.searchResults objectAtIndex:indexPath.row]valueForKey:@"SortableName"];
//        cell.textLabel.text = [object2 valueForKey:@"Name"];
//    }
//
//    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] init];
    
    OpenDaysUniversityPageTableViewController *openDaysUniversityPageTableViewController = [[OpenDaysUniversityPageTableViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListTableViewController,openDaysUniversityPageTableViewController,contactUniversityPageViewController,nil];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = cell.textLabel.text;
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
