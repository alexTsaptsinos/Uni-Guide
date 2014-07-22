//
//  SearchResultsTableViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "Courses.h"





@class Courses;

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

@synthesize allCourses,favouritesButton,tableView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.title = NSLocalizedString(@"Results", @"Table");
//    }
//    return self;
//}

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    [self addFirstCourses];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    allCourses = [Courses getAll];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - 
#pragma mark View Will/Did Disappear

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    return [allCourses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Courses *tempCourse = allCourses[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",tempCourse.courseName,tempCourse.university];
    cell.textLabel.font=[UIFont systemFontOfSize:15.0];

    
    // Configure the cell...
    
    
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

 //In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    CourseInfoCoursePageViewController *courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] init];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]init];
    
    ReviewsCoursePageViewController *reviewsCoursePageViewController = [[ReviewsCoursePageViewController alloc] init];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] init];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] init];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,reviewsCoursePageViewController,uniInfoCoursePageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    Courses *tempCourse = allCourses[indexPath.row];
    
    courseInfoCoursePageViewController.courseNameLabel.text = tempCourse.courseName;
    courseInfoCoursePageViewController.universityNameLabel.text =tempCourse.university;
    
    
    coursePageTabBarController.navigationItem.title = tempCourse.courseName;
    
    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favouritesButton"] style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    favouritesButton.tintColor = [UIColor grayColor];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
}

- (void) addFirstCourses{
    
    Courses * newCourse = [[Courses alloc] init];
    newCourse.courseName = @"Accounting";
    newCourse.university = @"Loughborough University";
    [Courses add:newCourse];
    
    newCourse = [[Courses alloc] init];
    newCourse.courseName = @"Business";
    newCourse.university = @"Newcastle University";
    [Courses add:newCourse];
    
    newCourse = [[Courses alloc] init];
    newCourse.courseName = @"Chemistry";
    newCourse.university = @"Oxford University";
    [Courses add:newCourse];
    
    
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



@end
