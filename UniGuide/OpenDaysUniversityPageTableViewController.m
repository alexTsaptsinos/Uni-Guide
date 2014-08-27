//
//  OpenDaysUniversityPageTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "OpenDaysUniversityPageTableViewController.h"
#import "SpecificOpenDayViewController.h"

@interface OpenDaysUniversityPageTableViewController ()

@end

@implementation OpenDaysUniversityPageTableViewController

@synthesize universityUKPRN,openDays,openDayDates,startTimes,endTimes,details,links,foundAnyBool,firstTimeLoad,noInternetImageView,noInternetLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    //self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.firstTimeLoad = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    noInternetLabel.hidden = YES;
    noInternetImageView.hidden = YES;
    
    if (self.firstTimeLoad == YES) {
        
        //NSLog(@"university name: %@", self.universityName);
        PFQuery *query = [PFQuery queryWithClassName:@"OpenDays"];
        [query whereKey:@"UKPRN" equalTo:self.universityUKPRN];
        NSDate *today = [NSDate date];
        [query whereKey:@"ParseDate" greaterThanOrEqualTo:today];
        [query orderByAscending:@"ParseDate"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
            if (!error) {
                openDays = [objects valueForKey:@"University"];
                openDayDates = [objects valueForKey:@"ParseDate"];
                startTimes = [objects valueForKey:@"TimeStart"];
                endTimes = [objects valueForKey:@"TimeEnd"];
                details = [objects valueForKey:@"Details"];
                links = [objects valueForKey:@"BookingLink"];
                //NSLog(@"open days: %@ and dates %@", openDays, openDayDates);
                if (openDays.count == 0) {
                    openDays = [[NSMutableArray alloc]initWithObjects:@"Placeholder", nil];
                    openDayDates = [[NSMutableArray alloc] initWithObjects:@"Placeholder", nil];
                    self.foundAnyBool = NO;
                } else {
                    self.foundAnyBool = YES;
                }
                [self.tableView reloadData];
            }
            else {
                NSLog(@"error");
                noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, 320, 429)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
                self.tableView.scrollEnabled = NO;
            }
            
        }];
        
        self.tableView.scrollEnabled = YES;
        
    }
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Open Days", @"University Open Days");
        self.tabBarItem.image = [UIImage imageNamed:@"calendar-32"];
    }
    return self;
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
    return self.openDays.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.foundAnyBool == NO) {
        
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.text = @"None found";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
        
    } else { static NSString *cellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yy"];
        cell.textLabel.text = [formatter stringFromDate:[openDayDates objectAtIndex:indexPath.row]];
        NSString *timings = [startTimes objectAtIndex:indexPath.row];
        timings = [timings stringByAppendingString:@" - "];
        timings = [timings stringByAppendingString:[endTimes objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = timings;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.foundAnyBool == NO) {
        
        
    } else {
        SpecificOpenDayViewController *specificOpenDayViewController = [[SpecificOpenDayViewController alloc] initWithNibName:@"SpecificOpenDayViewController" bundle:nil];
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        universityTitle.text = [openDays objectAtIndex:indexPath.row];
        universityTitle.backgroundColor = [UIColor clearColor];
        universityTitle.textColor = [UIColor whiteColor];
        universityTitle.font = [UIFont boldSystemFontOfSize:16.0];
        //universityTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        universityTitle.textAlignment = NSTextAlignmentCenter;
        specificOpenDayViewController.navigationItem.titleView = universityTitle;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yy"];
        specificOpenDayViewController.date = [formatter stringFromDate:[openDayDates objectAtIndex:indexPath.row]];
        specificOpenDayViewController.details = [details objectAtIndex:indexPath.row];
        specificOpenDayViewController.endTime = [endTimes objectAtIndex:indexPath.row];
        specificOpenDayViewController.startTime = [startTimes objectAtIndex:indexPath.row];
        specificOpenDayViewController.uniName = [openDays objectAtIndex:indexPath.row];
        specificOpenDayViewController.link = [links objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:specificOpenDayViewController animated:YES];
    }
}

@end
