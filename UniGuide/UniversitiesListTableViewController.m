//
//  UniversitiesListTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesListTableViewController.h"
//#import "Universities.h"
#import "University.h"

@interface UniversitiesListTableViewController () {
    
    HomeModel *_homeModel;
    NSArray *_feedItems;
}

@end

@implementation UniversitiesListTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc]init];
    
    //create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc]init];
    
    //set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    //call the download items method of the home model object
    [_homeModel downloadItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //dispose of any resources that can be recreated
}

-(void)itemsDownloaded:(NSArray *)items
{
    //this delegate method will get called when the items are finished downloading
    
    //set the downloaded items to the array
    _feedItems = items;
    
    //reload the table view
    [self.tableView reloadData];
    
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //get the university to be shown
    University *item=_feedItems[indexPath.row];
    
    //get references to labels of cell
    myCell.textLabel.text = item.universityName;
    
    return myCell;
}

@end


//@interface UniversitiesListTableViewController ()
//
//@end
//
//@implementation UniversitiesListTableViewController
//
//@synthesize universityArray,filteredUniversityArray,universitySearchBar;
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    // Sample Data for universityArray
//    
//    universityArray = [NSArray arrayWithObjects:[Universities universityOfTownOrCampus:@"Town" universityName:@"Bristol University"],
//                       [Universities universityOfTownOrCampus:@"Campus" universityName:@"Bath University"],
//                       [Universities universityOfTownOrCampus:@"Town" universityName:@"Oxford University"],
//[Universities universityOfTownOrCampus:@"Town" universityName:@"Cambridge University"],
//[Universities universityOfTownOrCampus:@"Campus" universityName:@"Loughborough University"],
//                       [Universities universityOfTownOrCampus:@"Campus" universityName:@"Nottingham University"],
//                       [Universities universityOfTownOrCampus:@"Town" universityName:@"Leeds University"],
//                       [Universities universityOfTownOrCampus:@"Campus" universityName:@"Kent University"],
//                       [Universities universityOfTownOrCampus:@"Town" universityName:@"Imperial College London"],
//                       [Universities universityOfTownOrCampus:@"Town" universityName:@"Durham University"],
//                       [Universities universityOfTownOrCampus:@"Campus" universityName:@"Birmingham University"],
//[Universities universityOfTownOrCampus:@"Campus" universityName:@"Canterbury Christ Church University"],
//                       [Universities universityOfTownOrCampus:@"Town" universityName:@"Reading University"],nil];
//    
//    
//    // Initialize the filteredUniversitiesArray with a capacity equal to the universityArray's capacity
//    self.filteredUniversityArray = [NSMutableArray arrayWithCapacity:[universityArray count]];
//    
//    //Reload the table
//    [self.tableView reloadData];
//    
//    self.navigationItem.title = @"Universities";
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//    // Return the number of rows in the section.
//    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [filteredUniversityArray count];
//    } else {
//        return [universityArray count];
//    }
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    //Create a new Universities Object
//    Universities *university = nil;
//    // Check to see whether the normal table or search results table is being displayed and set the Universities object from the appropriate array
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        university = [filteredUniversityArray objectAtIndex:indexPath.row];
//    } else {
//        university = [universityArray objectAtIndex:indexPath.row];
//    }
//    // Configure the cell
//    cell.textLabel.text = university.universityName;
//    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    return cell;
//}
//
//#pragma mark Content Filtering
//-(void)filterContentForSearchText:(NSString*)searchText {
//    //Update the filtered array based on the search text
//    //Remove all objects from the filtered search array
//    [self.filteredUniversityArray removeAllObjects];
//    //Filter the array using NSPredicate
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.universityName contains[c] %@",searchText];
//    filteredUniversityArray = [NSMutableArray arrayWithArray:[universityArray filteredArrayUsingPredicate:predicate]];
//}
//
//#pragma mark - UISearchDisplayController Delegate Methods
//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
//    //Tells the table data source to reload when text changes
//    [self filterContentForSearchText:searchString];
//    // Return YES to cause the search result table view to be reloaded
//    return YES;
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//@end
