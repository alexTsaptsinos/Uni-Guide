//
//  RightPanelViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "RightPanelViewController.h"
#import "SortFilterViewController.h"
#import "MainViewController.h"
#import "SearchResultsTableViewController.h"
#import "FilterTableViewController.h"

@interface RightPanelViewController ()

@end

@implementation RightPanelViewController

@synthesize sortCell,filterControllersTable,russellGroupOnlyButton,nineteenNinetyFourGroupOnlyButton,campusButton,townButton;

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Filter";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(cancelFilterButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFilterButton)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [self.campusButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    [self.townButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    [self.russellGroupOnlyButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    [self.nineteenNinetyFourGroupOnlyButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *tableTitles = [[NSArray alloc]initWithObjects:@"Courses",@"University",@"Location",@"Tariff Points", nil];
    
    cell.textLabel.text = [tableTitles objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterTableViewController *filterTableViewController = [[FilterTableViewController alloc] initWithNibName:@"FilterTableViewController" bundle:nil];
    
    NSArray *tableTitles = [[NSArray alloc]initWithObjects:@"Courses",@"University",@"Location",@"Tariff Points", nil];

    filterTableViewController.navigationItem.title = [tableTitles objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:filterTableViewController animated:YES];
}


#pragma mark
#pragma mark View Will/Did Appear

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark
#pragma mark View Will/Did Disappear

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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

- (IBAction)sortCellPressed:(id)sender {
    
    SortFilterViewController *sortFilterViewController = [[SortFilterViewController alloc] initWithNibName:@"SortFilterViewController" bundle:nil];
    
    [self.navigationController pushViewController:sortFilterViewController animated:YES];
}



-(void)cancelFilterButton {
    
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
    
}

-(void)doneFilterButton {

    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
}


- (IBAction)campusButtonPressed:(id)sender {
    
    if (self.campusButton.currentImage == [UIImage imageNamed:@"unchecked_checkbox"]) {
        [self.campusButton setImage:[UIImage imageNamed:@"checked_checkbox"] forState:UIControlStateNormal];
    }
    
    else if (self.campusButton.currentImage == [UIImage imageNamed:@"checked_checkbox"]) {
        [self.campusButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)townButtonPressed:(id)sender {
    
    if (self.townButton.currentImage == [UIImage imageNamed:@"unchecked_checkbox"]) {
        [self.townButton setImage:[UIImage imageNamed:@"checked_checkbox"] forState:UIControlStateNormal];
    }
    
    else if (self.townButton.currentImage == [UIImage imageNamed:@"checked_checkbox"]) {
        [self.townButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    }
}
- (IBAction)russellGroupOnlyButtonPressed:(id)sender {
    
    if (self.russellGroupOnlyButton.currentImage == [UIImage imageNamed:@"unchecked_checkbox"]) {
        [self.russellGroupOnlyButton setImage:[UIImage imageNamed:@"checked_checkbox"] forState:UIControlStateNormal];
    }
    
    else if (self.russellGroupOnlyButton.currentImage == [UIImage imageNamed:@"checked_checkbox"]) {
        [self.russellGroupOnlyButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    }
}

- (IBAction)nineteenNinetyFourGroupOnlyButtonPressed:(id)sender {
    
    if (self.nineteenNinetyFourGroupOnlyButton.currentImage == [UIImage imageNamed:@"unchecked_checkbox"]) {
        [self.nineteenNinetyFourGroupOnlyButton setImage:[UIImage imageNamed:@"checked_checkbox"] forState:UIControlStateNormal];
    }
    
    else if (self.nineteenNinetyFourGroupOnlyButton.currentImage == [UIImage imageNamed:@"checked_checkbox"]) {
        [self.nineteenNinetyFourGroupOnlyButton setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
    }
}
@end
