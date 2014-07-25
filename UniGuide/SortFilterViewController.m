//
//  SortFilterViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 24/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SortFilterViewController.h"
#import "SearchResultsTableViewController.h"

@interface SortFilterViewController ()

@end

@implementation SortFilterViewController

@synthesize sortOptionsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Sort";
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFilterButton)];
        self.navigationItem.rightBarButtonItem = doneButton;
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *tableTitles = [[NSArray alloc]initWithObjects:@"Most Relevant",@"Alphabetical",@"Highest Entry Requirements",@"Lowest Entry Requirements", @"Closest", @"Furthest Away", @"Highest Reviewed", nil];
    
    cell.textLabel.text = [tableTitles objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)doneFilterButton {

    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
                    }
                    completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (int i = 0; i<8;i++)
    {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
