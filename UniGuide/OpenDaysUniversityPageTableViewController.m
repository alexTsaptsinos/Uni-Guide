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

@synthesize universityName,openDays,openDayDates,startTimes,endTimes,details,links,foundAnyBool;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    
    //NSLog(@"university name: %@", self.universityName);
    PFQuery *query = [PFQuery queryWithClassName:@"OpenDays"];
    [query whereKey:@"University" equalTo:self.universityName];
    [query orderByAscending:@"Date"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        openDays = [objects valueForKey:@"University"];
        openDayDates = [objects valueForKey:@"Date2"];
        startTimes = [objects valueForKey:@"TimeStart"];
        endTimes = [objects valueForKey:@"TimeEnd"];
        details = [objects valueForKey:@"Details"];
        links = [objects valueForKey:@"BookingLink"];
         //NSLog(@"open days: %@ and dates %@", openDays, openDayDates);
        if (openDays.count == 0) {
            openDays = [[NSMutableArray alloc]initWithObjects:@"None coming up LOL", nil];
            openDayDates = [[NSMutableArray alloc] initWithObjects:@"Sorry", nil];
            self.foundAnyBool = NO;
        } else {
            self.foundAnyBool = YES;
        }
        [self.tableView reloadData];
    }];
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Coming Up:";
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
    universityTitle.numberOfLines = 2;
    universityTitle.text = self.universityName;
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
