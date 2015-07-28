//
//  CourseListTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 29/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseListTableViewController.h"


@interface CourseListTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>

{
    NSArray *_universityCourseNames;
    NSArray *_universityCourseCodes;
    NSArray *_universityCourseHonours;
    
}

@property (nonatomic, retain) NSMutableDictionary *sections;
@property (nonatomic, retain) NSArray *searchResults;

@end

@implementation CourseListTableViewController

@synthesize favouritesButton,universityCode,universityName,cellTitles,courseInfoCoursePageViewController,firstTimeLoad,noInternetImageView,noInternetLabel;
@synthesize sections = _sections;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"Course List", @"Course List");
        self.tabBarItem.image = [UIImage imageNamed:@"courses-32"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.cellTitles = [[NSMutableArray alloc] init];
    self.searchDisplayController.searchResultsTableView.backgroundColor  = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.firstTimeLoad = YES;
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    noInternetLabel.hidden = YES;
    noInternetImageView.hidden = YES;
    
    if (self.firstTimeLoad == YES) {
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(141, 170, 20, 20)];
        activityIndicator.color = [UIColor grayColor];
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.hidden = NO;
        [activityIndicator startAnimating];
        [self.tableView addSubview:activityIndicator];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Kiscourse"];
        [query whereKey:@"UKPRN" equalTo:self.universityCode];
        [query setLimit:600];
        [query whereKeyExists:@"TITLE"];
        [query orderByAscending:@"TITLE"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    NSString *fullName = [object valueForKey:@"TITLE"];
                    fullName = [fullName stringByAppendingString:@" - "];
                    fullName = [fullName stringByAppendingString:[object valueForKey:@"CourseHonour"]];
                    if (fullName != NULL) {
                        [self.cellTitles addObject:fullName];
                    }
                }
                _universityCourseNames = [objects valueForKey:@"TITLE"];
                _universityCourseCodes = [objects valueForKey:@"KISCOURSEID"];
                _universityCourseHonours = [objects valueForKey:@"CourseHonour"];
                _sections = [[NSMutableDictionary alloc] init]; ///Global Object
                //NSLog(@"No. of courses: %d and these are the courses: %@", _universityCourseNames.count,_universityCourseNames);
                
                
                BOOL found;
                
                for (NSString *temp in self.cellTitles)
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
                self.firstTimeLoad = NO;
                self.tableView.scrollEnabled = YES;
            }
            else {
                NSLog(@"error");
                noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 429)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
                self.tableView.scrollEnabled = NO;
            }
            [activityIndicator stopAnimating];

        }];
    }
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
            NSString *cellTitle = [_universityCourseNames objectAtIndex:indexPath.row];
            cellTitle = [cellTitle stringByAppendingString:@" - "];
            cellTitle = [cellTitle stringByAppendingString:[_universityCourseHonours objectAtIndex:indexPath.row]];
            cell.textLabel.text = cellTitle;
        } else {
            NSString *titleText = [[_sections valueForKey:[[[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
            cell.textLabel.text = titleText;
        }
    }
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

#pragma mark - methods for sections

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    if (tableView == self.tableView) {
        if (_universityCourseNames.count < 8) {
            return NULL;
        } else {
            tempLabel.text = [[[_sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
        }
    }
    else {
        tempLabel.text = @"";
    }
    
    [headerView addSubview:tempLabel];
    return headerView;
    
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
    
    self.searchResults = [self.cellTitles filteredArrayUsingPredicate:resultPredicate];
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
    courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] init];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]init];

    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] init];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] init];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,uniInfoCoursePageViewController,contactUniversityPageViewController,nil];
    [coursePageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    // Pass the selected object to the new view controller.
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    coursePageTabBarController.navigationItem.title = @"Course";
    
    
    
    
    int rowsOffset = 0;
    for (int section=0; section < indexPath.section; section++) {
        rowsOffset += [tableView numberOfRowsInSection:section];
    }
    
    
    
    NSLog(@"rows offset: %d",rowsOffset);
    
    courseInfoCoursePageViewController.uniCodeCourseInfo = self.universityCode;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSLog(@"search results: %@ and course name: %@",self.searchResults,self.cellTitles);
        id object = [self.searchResults objectAtIndex:indexPath.row];
        NSInteger originalIndexPath = [self.cellTitles indexOfObject:object];
        NSLog(@"%li", (long)originalIndexPath);
        courseInfoCoursePageViewController.courseCodeCourseInfo = [_universityCourseCodes objectAtIndex:originalIndexPath];
        studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = [_universityCourseCodes objectAtIndex:originalIndexPath];
        uniInfoCoursePageViewController.courseCodeUniInfo = [_universityCourseCodes objectAtIndex:originalIndexPath];
        contactUniversityPageViewController.courseCodeContact = [_universityCourseCodes objectAtIndex:originalIndexPath];
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",[_universityCourseCodes objectAtIndex:originalIndexPath],self.universityCode] andSortKey:@"courseName"];
        NSLog(@"has it worked? %@",[temp2 valueForKey:@"courseName"]);
        if (temp2.count != 0) {
            favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star-25"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
            favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
            [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
            courseInfoCoursePageViewController.isItFavourite = YES;
        } else {
            favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"star-24"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
            favouritesButton.tintColor = [UIColor whiteColor];
            [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
            courseInfoCoursePageViewController.isItFavourite = NO;
        }
        
        
    } else {
        courseInfoCoursePageViewController.courseCodeCourseInfo = [_universityCourseCodes objectAtIndex:rowsOffset + indexPath.row];
        studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = [_universityCourseCodes objectAtIndex:indexPath.row];
        uniInfoCoursePageViewController.courseCodeUniInfo = [_universityCourseCodes objectAtIndex:indexPath.row];
        contactUniversityPageViewController.courseCodeContact = [_universityCourseCodes objectAtIndex:indexPath.row];
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",[_universityCourseCodes objectAtIndex:rowsOffset +indexPath.row],self.universityCode] andSortKey:@"courseName"];
        NSLog(@"has it worked? %@",[temp2 valueForKey:@"courseName"]);
        if (temp2.count != 0) {
            favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
            favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
            courseInfoCoursePageViewController.isItFavourite = YES;
            [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
        } else {
            favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
            favouritesButton.tintColor = [UIColor whiteColor];
            courseInfoCoursePageViewController.isItFavourite = NO;
            [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
        }
        
    }
    contactUniversityPageViewController.universityCode = self.universityCode;
    contactUniversityPageViewController.universityName = self.universityName;
    
    uniInfoCoursePageViewController.uniCodeUniInfo = self.universityCode;
    uniInfoCoursePageViewController.uniNameUniInfo = self.universityName;
    courseInfoCoursePageViewController.courseNameCourseInfo = cell.textLabel.text;
    courseInfoCoursePageViewController.uniNameCourseInfo = self.universityName;
    courseInfoCoursePageViewController.haveComeFromFavourites = NO;
    
    studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = self.universityCode;
    studentSatisfactionCoursePageViewController.courseNameStudentSatisfaction = cell.textLabel.text;
    studentSatisfactionCoursePageViewController.uniNameStudentSatisfaction = self.universityName;
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
}

//-(void) customBtnPressed
//{
//    if (favouritesButton.image == [UIImage imageNamed:@"add_to_favorites-512.png"]) {
//        favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
//        favouritesButton.tintColor = [UIColor grayColor];
//    }
//    else if (favouritesButton.image == [UIImage imageNamed:@"add_to_favorites-512.png"]) {
//        favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
//        favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
//    }
//    
//}

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

-(void) callAnotherMethod {
    
    courseInfoCoursePageViewController.favouritesButton = self.favouritesButton;
    [courseInfoCoursePageViewController customBtnPressed];
}


@end
