//
//  CourseListTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 29/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseListTableViewController.h"
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"

@interface CourseListTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>

{
    NSArray *_universityCourses;
    NSArray *_universityCourseNames;
}

@property (nonatomic, retain) NSMutableDictionary *sections;
@property (nonatomic,retain) NSMutableDictionary *sectionToLetterMap;
@property (nonatomic, retain) NSArray *searchResults;

@end

@implementation CourseListTableViewController

@synthesize favouritesButton,universityCode;
@synthesize sections = _sections;
@synthesize sectionToLetterMap = _sectionToLetterMap;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"Course List", @"Course List");
        self.tabBarItem.image = [UIImage imageNamed:@"courses-32"];
        self.sectionToLetterMap = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Kiscourse"];
    [query whereKey:@"UKPRN" equalTo:self.universityCode];
    [query setLimit:600];
    [query orderByAscending:@"TITLE"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        _universityCourseNames = [objects valueForKey:@"TITLE"];
        _sections = [[NSMutableDictionary alloc] init]; ///Global Object
        //NSLog(@"No. of courses: %d and these are the courses: %@", _universityCourseNames.count,_universityCourseNames);
        
        
        BOOL found;
        
        for (NSString *temp in _universityCourseNames)
        {
            //NSLog(@"temp: %@",temp);
            if (temp == (id)[NSNull null] || temp.length == 0 ) {
                //ignore it
            } else {
                NSString *c = [temp substringToIndex:1];
                
                found = NO;
                
                for (NSString *str in [_sections allKeys])
                {
                    if ([str isEqualToString:c])
                    {
                        found = YES;
                    }
                }
                
                
                if (!found)
                {
                    [_sections setValue:[[NSMutableArray alloc] init] forKey:c];
                }

                [[_sections objectForKey:[temp substringToIndex:1]] addObject:temp];
            }
        }
        
       // NSLog(@"Sections: %@", _sections);
        
        [self.tableView reloadData];
        
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     //Return the number of sections.
    if (tableView == self.tableView) {
    if (_universityCourseNames.count < 8) {
            return 1;
        } else {
    return [[_sections allKeys]count];
      }
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
    if (_universityCourseNames.count <8) {
            return _universityCourseNames.count;
        } else {
    return [[_sections valueForKey:[[[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        if (_universityCourseNames.count < 8) {
            cell.textLabel.text = [_universityCourseNames objectAtIndex:indexPath.row];
        } else {
            NSString *titleText = [[_sections valueForKey:[[[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
            
            cell.textLabel.text = titleText; [_universityCourseNames objectAtIndex:indexPath.row];
    }
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

#pragma mark - methods for sections

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
    if (_universityCourseNames.count < 8) {
            return NULL;
        } else {
    return [[[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
      }
    } else {
        return NULL;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
    if (_universityCourseNames.count <8) {
            return NULL;
        } else {
    return [[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
      }
    } else {
        return NULL;
    }
}

#pragma mark - methods for search

- (void)filterContentForSearchText:(NSString*)searchText
{
    //NSLog(@"%@", _universityCourseNames);
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResults = [_universityCourseNames filteredArrayUsingPredicate:resultPredicate];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    CourseInfoCoursePageViewController *courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] init];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]init];
    
    ReviewsCoursePageViewController *reviewsCoursePageViewController = [[ReviewsCoursePageViewController alloc] init];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] init];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] init];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,reviewsCoursePageViewController,uniInfoCoursePageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    UILabel *courseTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    courseTitle.numberOfLines = 2;
    courseTitle.text = cell.textLabel.text;
    courseTitle.textAlignment = NSTextAlignmentCenter;
    
    coursePageTabBarController.navigationItem.titleView = courseTitle;
    
    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favouritesButton"] style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    favouritesButton.tintColor = [UIColor grayColor];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
}

-(void) customBtnPressed
{
    if (favouritesButton.tintColor == [UIColor yellowColor]) {
        favouritesButton.tintColor = [UIColor grayColor];
    }
    else if (favouritesButton.tintColor == [UIColor grayColor]) {
        favouritesButton.tintColor = [UIColor yellowColor];
    }
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.navigationController.navigationBar.translucent = YES;

    [UIView animateWithDuration:0.2 animations: ^{
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        double yDiff = self.navigationController.navigationBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height - statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(0, yDiff, 320, self.navigationController.navigationBar.frame.size.height);
    }];
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        double yDiff = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(0, yDiff, 320, self.navigationController.navigationBar.frame.size.height);
    }];
}


@end
