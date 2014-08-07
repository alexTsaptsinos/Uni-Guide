//
//  OpenDaysQueryTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 31/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "OpenDaysQueryTableViewController.h"

@interface OpenDaysQueryTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>
{
    
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation OpenDaysQueryTableViewController

@synthesize openDayDates,openDays,startTimes,endTimes,details,links;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //this table displays items in the universities class
        self.parseClassName = @"OpenDays";
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = YES;
        self.objectsPerPage = 50;
        self.navigationItem.title = @"Open Days";
        self.navigationController.navigationBar.translucent = NO;

        self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        
        
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.text = @"Coming Up:";
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        return self.objects.count;
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
    [query orderByAscending:@"ParseDate"];

    
    
    return query;
}

-(void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    openDays = [self.objects valueForKey:@"University"];
    openDayDates = [self.objects valueForKey:@"ParseDate"];
    startTimes = [self.objects valueForKey:@"TimeStart"];
    endTimes = [self.objects valueForKey:@"TimeEnd"];
    details = [self.objects valueForKey:@"Details"];
    links = [self.objects valueForKey:@"BookingLink"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *cellIdentifier = @"Cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = object[@"University"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yy"];
        cell.detailTextLabel.text = [formatter stringFromDate:object[@"ParseDate"]];
    } else {
        if ([self.searchBar.text length] == 0 ) {
            
        } else {
        PFObject *object2 = [PFObject objectWithClassName:@"OpenDays"];
        NSLog(@"search results: %@",self.searchResults);
        object2 = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [object2 valueForKey:@"University"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yy"];
        cell.detailTextLabel.text = [formatter stringFromDate:object2[@"ParseDate"]];
        }
    }
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    return cell;
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

-(void)filterResults:(NSString *)searchTerm {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"University" matchesRegex:searchTerm modifiers:@"i"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.searchResults removeAllObjects];
        [self.searchResults addObjectsFromArray:objects];
        NSLog(@"search results two: %@", self.searchResults);
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
    
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterResults:searchString];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecificOpenDayViewController *specificOpenDayViewController = [[SpecificOpenDayViewController alloc] initWithNibName:@"SpecificOpenDayViewController" bundle:nil];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    universityTitle.numberOfLines = 2;
    universityTitle.text = cell.textLabel.text;
    universityTitle.textAlignment = NSTextAlignmentCenter;
    specificOpenDayViewController.navigationItem.titleView = universityTitle;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    specificOpenDayViewController.date = [formatter stringFromDate:[openDayDates objectAtIndex:indexPath.row]];
    specificOpenDayViewController.details = [details objectAtIndex:indexPath.row];
    specificOpenDayViewController.endTime = [endTimes objectAtIndex:indexPath.row];
    specificOpenDayViewController.startTime = [startTimes objectAtIndex:indexPath.row];
    specificOpenDayViewController.uniName = cell.textLabel.text;
    specificOpenDayViewController.link = [links objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:specificOpenDayViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
