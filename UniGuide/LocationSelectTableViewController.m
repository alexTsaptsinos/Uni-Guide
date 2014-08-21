//
//  LocationSelectTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 19/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "LocationSelectTableViewController.h"

@interface LocationSelectTableViewController ()

@end

@implementation LocationSelectTableViewController

@synthesize locations;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        title.text = @"Location";
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:20.0];

        self.navigationItem.titleView = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locations = [[NSArray alloc] initWithObjects: @"East Of England", @"West Midlands", @"South West", @"London", @"East Midlands", @"North West", @"Yorkshire And The Humber", @"South East", @"North East", @"Wales", @"Scotland", @"Northern Ireland",nil];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return self.locations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [self.locations objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.previousViewController.locationButton.titleLabel.text = [self.locations objectAtIndex:indexPath.row];
    self.previousViewController.locationButton.titleLabel.textColor = [UIColor blackColor];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
