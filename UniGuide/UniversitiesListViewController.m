//
//  UniversitiesListViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesListViewController.h"
#import "University.h"
#import "UniInfoCoursePageViewController.h"
#import "CourseListTableViewController.h"
#import "OpenDaysUniversityPageTableViewController.h"
#import "ContactUniversityPageViewController.h"
#import <Parse/Parse.h>

@interface UniversitiesListViewController ()  {
    
    NSArray *_universities;
}

@end

@implementation UniversitiesListViewController

@synthesize filteredUniversityArray,universityListTableView,universitySearchBar,alphabetsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Universities";

    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    // Initialize the filteredUniversitiesArray with a capacity equal to the universityArray's capacity
    self.filteredUniversityArray = [NSMutableArray arrayWithCapacity:[_universities count]];
    
    
    alphabetsArray = [[NSMutableArray alloc] init];
    [alphabetsArray addObject:@"A"];
    [alphabetsArray addObject:@"B"];
    [alphabetsArray addObject:@"C"];
    [alphabetsArray addObject:@"D"];
    [alphabetsArray addObject:@"E"];
    [alphabetsArray addObject:@"F"];
    [alphabetsArray addObject:@"G"];
    [alphabetsArray addObject:@"H"];
    [alphabetsArray addObject:@"I"];
    [alphabetsArray addObject:@"J"];
    [alphabetsArray addObject:@"K"];
    [alphabetsArray addObject:@"L"];
    [alphabetsArray addObject:@"M"];
    [alphabetsArray addObject:@"N"];
    [alphabetsArray addObject:@"O"];
    [alphabetsArray addObject:@"P"];
    [alphabetsArray addObject:@"Q"];
    [alphabetsArray addObject:@"R"];
    [alphabetsArray addObject:@"S"];
    [alphabetsArray addObject:@"T"];
    [alphabetsArray addObject:@"U"];
    [alphabetsArray addObject:@"V"];
    [alphabetsArray addObject:@"W"];
    [alphabetsArray addObject:@"Y"];
    [alphabetsArray addObject:@"X"];
    [alphabetsArray addObject:@"Z"];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfSectionsInTableView:(UITableView *)universityListTableView {
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return 1;
//    } else {
//        return alphabetsArray.count;
//    }
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return @"";
//    } else {
//    return [alphabetsArray objectAtIndex:section];
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return the number of rows in the section.
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [filteredUniversityArray count];
//    } else {
//        switch (section) {
//            case 0: return 15;
//            case 1: return 54;
//            case 2: return 20;
//            case 3: return 20;
//                case 4: return 20;
//                case 5: return 20;
//                case 6: return 20;
//                case 7: return 20;
//                case 8: return 20;
//                case 9: return 20;
//                case 10: return 20;
//                case 11: return 20;
//                case 12: return 20;
//                case 13: return 20;
//                case 14: return 20;
//                case 15: return 20;
//                case 16: return 20;
//                case 17: return 20;
//                case 18: return 6;
//            case 19: return 5;
//                case 20: return 5;
//                case 21: return 5;
//                case 22: return 5;
//                case 23: return 5;
//                case 24: return 5;
//                case 25: return 5;
//                case 26: return 5;
//            default: return 1;
//        //return [_universities count];
//    }
    return 415;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [universityListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    //Create a new Universities Object
//    University *university = nil;
//    // Check to see whether the normal table or search results table is being displayed and set the Universities object from the appropriate array
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        university = [filteredUniversityArray objectAtIndex:indexPath.row];
//    } else {
//        
//    
//        
//        university = [_universities objectAtIndex:indexPath.row];
//    }
    
    
    // Configure the cell

//    cell.textLabel.text = university.name;
//    cell.textLabel.font = [UIFont fontWithName:@"Arial" size: 15];
//    return cell;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [universityListTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
    
    NSMutableArray *titlesArray = [[NSMutableArray alloc] init];
    
    PFQuery *universityQuery = [PFQuery queryWithClassName:@"Universities"];
    [universityQuery selectKeys:@[@"SortableName"]];
    [universityQuery setLimit:415];
    [universityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for (PFObject *object in objects) {
                [titlesArray addObject:object[@"SortableName"]];
               // NSLog(@"%@", titlesArray);
                //cell.textLabel.text = [titlesArray objectAtIndex:indexPath.row];
            }
           // [tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [tableView reloadData];
    
   // cell.textLabel.text = [titlesArray objectAtIndex:indexPath.row];
    
    
    
   // cell.textLabel.text = [universitiesArray objectAtIndex:indexPath.row];
    
    
    return cell;
    
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
    //Update the filtered array based on the search text
    //Remove all objects from the filtered search array
    [self.filteredUniversityArray removeAllObjects];
    //Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredUniversityArray = [NSMutableArray arrayWithArray:[_universities filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    //Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] init];
    
    OpenDaysUniversityPageTableViewController *openDaysUniversityPageTableViewController = [[OpenDaysUniversityPageTableViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListTableViewController,openDaysUniversityPageTableViewController,contactUniversityPageViewController,nil];
    
    University *tempUniversity = _universities[indexPath.row];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = tempUniversity.name;
    universityTitle.text = tempUniversity.name;
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
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

-(void)viewDidAppear:(BOOL)animated{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect statusBarFrame =  [[UIApplication sharedApplication] statusBarFrame];
        [self.universityListTableView setFrame:CGRectMake(self.universityListTableView.frame.origin.x, self.universityListTableView.frame.origin.y+statusBarFrame.size.height, self.universityListTableView.frame.size.width, self.universityListTableView.frame.size.height)];
        
    }
}
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return alphabetsArray;
//}


//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    University *university = nil;
//    
//    for (int i = 0; i< [_universities count]; i++) {
//        // Here you return the name
//        // and match the title for first letter of name
//        // and move to that row corresponding to that indexpath as below
//        university = [_universities objectAtIndex:i];
//        NSString *letterString = [university.name substringToIndex:1];
//        NSLog(@"%@",letterString);
//        if ([letterString isEqualToString:title]) {
//            //[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//            return i;
//            //break;
//        }
//    }
//    return 0;
//}



@end
