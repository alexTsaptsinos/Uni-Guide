//
//  TypeOfComplaintsTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "TypeOfComplaintsTableViewController.h"
#import "ReviewComplaintViewController.h"

@interface TypeOfComplaintsTableViewController ()

@end

@implementation TypeOfComplaintsTableViewController

@synthesize typeOfComplaintArray;
@synthesize previousView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.title = @"Type";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.typeOfComplaintArray = [[NSArray alloc] initWithObjects:@"Offensive Material",@"This review is not a review or is off-topic",@"I disagree with this review",@"My concern isn't listed here", nil];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    
    [self.navigationItem setLeftBarButtonItem:cancelButton];
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
    return typeOfComplaintArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [typeOfComplaintArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    previousView.selectTypeButton.titleLabel.text = [typeOfComplaintArray objectAtIndex:indexPath.row];
    previousView.hasSelectedTypeOfComplaint = YES;

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
