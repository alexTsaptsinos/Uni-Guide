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

@interface RightPanelViewController ()

@end

@implementation RightPanelViewController

@synthesize sortCell,filterControllersTable;

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    NSArray *tableTitles = [[NSArray alloc]initWithObjects:@"Courses",@"Universitidjhfasjdfgkasjhdfgakjshdgfkasjhdfgkajshdgfkajshdgfkajshdgfkjashdgfkajshdfes",@"Location",@"Tariff Points", nil];
    NSLog(@"%@",tableTitles);
    
    cell.textLabel.text = [tableTitles objectAtIndex:indexPath.row];
    return cell;
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
@end
