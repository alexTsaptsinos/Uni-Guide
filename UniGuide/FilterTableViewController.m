//
//  FilterTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 24/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "FilterTableViewController.h"
#import "SearchResultsTableViewController.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneFilterButton)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.imageView.image = [UIImage imageNamed:@"unchecked_checkbox"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.imageView.image == [UIImage imageNamed:@"checked_checkbox"]) {
        cell.imageView.image = [UIImage imageNamed:@"unchecked_checkbox"];
    }
    else if (cell.imageView.image == [UIImage imageNamed:@"unchecked_checkbox"]) {
        cell.imageView.image = [UIImage imageNamed:@"checked_checkbox"];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    

}
//
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    if (cell.imageView.image == [UIImage imageNamed:@"checked_checkbox"]) {
//    }
//    if (cell.imageView.image == [UIImage imageNamed:@"unchecked_checkbox"]) {
//        cell.imageView.image = [UIImage imageNamed:@"checked_checkbox"];
//    }
//}


-(void)doneFilterButton {

    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
                    }
                    completion:nil];
}

@end
