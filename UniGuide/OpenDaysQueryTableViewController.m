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

@end

@implementation OpenDaysQueryTableViewController

@synthesize openDayDates,openDays,startTimes,endTimes,details,links,searchResults,i,firstTimeForDates,allObjects;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //this table displays items in the universities class
        self.parseClassName = @"OpenDays";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 1000;
        self.navigationItem.title = @"Open Days";
        self.navigationController.navigationBar.translucent = NO;
        self.tableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
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
    NSDate *today = [NSDate date];
    NSLog(@"today: %@",today);
    [query whereKey:@"ParseDate" greaterThanOrEqualTo:today];
    
    return query;
}

-(void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    UILabel *noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 60)];
    noInternetLabel.textAlignment = NSTextAlignmentCenter;
    noInternetLabel.textColor = [UIColor blackColor];
    noInternetLabel.numberOfLines = 0;
    noInternetLabel.text = @"We're sorry but Open Days\nare not available offline";
    noInternetLabel.hidden = YES;
    [self.view addSubview:noInternetLabel];
    
    if (error != nil) {
        noInternetLabel.hidden = NO;
    } else {
        noInternetLabel.hidden = YES;
    }
    
    self.allObjects = self.objects;
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
            
            NSString *temp  =[self.searchResults objectAtIndex:indexPath.row];
            cell.textLabel.text = temp;
            
            if (indexPath.row == 0 && self.firstTimeForDates == YES) {
                i = 0;
                self.firstTimeForDates = NO;
            }
            if (i < self.openDays.count) {
                NSLog(@"i first: %i",i);
                NSRange range = NSMakeRange(i, self.openDays.count - i);
                NSLog(@"range %i and length %i",range.location,range.length);
                NSInteger indexPath = [self.openDays indexOfObject:temp inRange:range];
                NSLog(@"index path: %i",indexPath);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd-MM-yy"];
                cell.detailTextLabel.text = [formatter stringFromDate:[openDayDates objectAtIndex:indexPath]];
                i = indexPath+1;
                NSLog(@"i: %i",i);
            }
            
            
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
    
    self.tableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.searchResults = [NSMutableArray array];
    
}

-(void)filterResults:(NSString *)searchTerm {
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchTerm];
    self.searchResults = [self.openDays filteredArrayUsingPredicate:resultPredicate];
    [self.searchDisplayController.searchResultsTableView reloadData];
    
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterResults:searchString];
    self.firstTimeForDates = YES;
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
//    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // if (data) {
    SpecificOpenDayViewController *specificOpenDayViewController = [[SpecificOpenDayViewController alloc] initWithNibName:@"SpecificOpenDayViewController" bundle:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        specificOpenDayViewController.date = [formatter stringFromDate:[openDayDates objectAtIndex:indexPath.row]];
        specificOpenDayViewController.details = [details objectAtIndex:indexPath.row];
        specificOpenDayViewController.endTime = [endTimes objectAtIndex:indexPath.row];
        specificOpenDayViewController.startTime = [startTimes objectAtIndex:indexPath.row];
        specificOpenDayViewController.uniName = cell.textLabel.text;
        specificOpenDayViewController.link = [links objectAtIndex:indexPath.row];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
        
        NSLog(@"textabc: %@",cell.detailTextLabel.text);
        NSDate *date = [formatter dateFromString:cell.detailTextLabel.text];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
        NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date];

        [components setHour: 0];
        [components setMinute: 0];
        [components setSecond: 0];
        [components setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        NSDate *newDate = [gregorian dateFromComponents: components];
        NSLog(@"datedate: %@",newDate);
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(University == %@) AND (ParseDate == %@)",cell.textLabel.text,newDate];
        NSArray *results = [self.allObjects filteredArrayUsingPredicate:pred];
        NSLog(@"resultswoo: %@",results);
        
        specificOpenDayViewController.date = [formatter stringFromDate:[[results valueForKey:@"ParseDate"] objectAtIndex:0]];
        specificOpenDayViewController.details = [[results valueForKey:@"Details"] objectAtIndex:0];
        specificOpenDayViewController.endTime = [[results valueForKey:@"TimeEnd"] objectAtIndex:0];
        specificOpenDayViewController.startTime = [[results valueForKey:@"TimeStart"] objectAtIndex:0];
        specificOpenDayViewController.uniName = cell.textLabel.text;
        specificOpenDayViewController.link = [[results valueForKey:@"BookingLink"] objectAtIndex:0];
    }
    
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    universityTitle.text = cell.textLabel.text;
    universityTitle.backgroundColor = [UIColor clearColor];
    universityTitle.textColor = [UIColor whiteColor];
    universityTitle.font = [UIFont boldSystemFontOfSize:16.0];
    //universityTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    universityTitle.textAlignment = NSTextAlignmentCenter;
    specificOpenDayViewController.navigationItem.titleView = universityTitle;
    
    
    [self.navigationController pushViewController:specificOpenDayViewController animated:YES];
    //    } else {
    //        NSLog(@"no internet");
    //        UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [noInternetAlert show];
    //    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
