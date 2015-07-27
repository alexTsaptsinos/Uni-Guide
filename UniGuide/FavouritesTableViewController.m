//
//  FavouritesTableViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "FavouritesTableViewController.h"

@interface FavouritesTableViewController ()

@end

@implementation FavouritesTableViewController

@synthesize uniCodes,uniNames,courseCodes,courseNames,courseInfoCoursePageViewController,favouritesButton,noFavouritesButton,noFavouritesLabel,favouriteObjects,reversed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    
    //set navigation title and edit button
    
    self.navigationItem.title = @"Favourites";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.favouriteObjects = [[NSMutableArray alloc] init];
    self.uniNames = [[NSMutableArray alloc] init];
    self.uniCodes = [[NSMutableArray alloc] init];
    self.courseNames = [[NSMutableArray alloc] init];
    self.courseCodes = [[NSMutableArray alloc] init];
    self.reversed = [[NSMutableArray alloc] init];
    [self updateArrays];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateArrays];
    [self.tableView reloadData];
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
    return self.courseCodes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.courseNames objectAtIndex:indexPath.row];
    
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.detailTextLabel.text = [self.uniNames objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    
    
    return cell;
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     NSLog(@"course codes: %@",self.courseCodes);
     
     [Favourites deleteObject:[self.favouriteObjects objectAtIndex:indexPath.row]];
     [Favourites saveDatabase];
     
     [self updateArrays];

     NSLog(@"course Codes two: %@",courseCodes);

     
     
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
   //  [tableView reloadData];
     
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     
     NSUInteger fromIndex = fromIndexPath.row;
     NSUInteger toIndex = toIndexPath.row;
     
     if (fromIndex == toIndex) {
         return;
     }
     
     Favourites *affectedObject = [self.reversed objectAtIndex:fromIndex];
     NSLog(@"Updated %@ / %@ from %@ to %lu", affectedObject.courseName, affectedObject.uniName, affectedObject.sortNumber, self.favouriteObjects.count - toIndex - 1);
     affectedObject.sortNumber = [NSNumber numberWithInt:self.favouriteObjects.count - toIndex - 1];

     
     NSUInteger start, end;
     int delta;
     
     if (fromIndex < toIndex) {
         // move was down, need to shift up
         delta = 1;
         start = fromIndex + 1;
         end = toIndex;
     } else { // fromIndex > toIndex
         // move was up, need to shift down
         delta = -1;
         start = toIndex;
         end = fromIndex - 1;
     }
     
     for (NSUInteger i = start; i <= end; i++) {
         Favourites *otherObject = [self.reversed objectAtIndex:i];
         NSNumber *tempSort = [NSNumber numberWithInt:[otherObject.sortNumber intValue]];
         NSLog(@"Updated %@ / %@ from %@ to %f", otherObject.courseName, otherObject.uniName, otherObject.sortNumber, [tempSort floatValue] + delta);
         otherObject.sortNumber = [NSNumber numberWithFloat:[tempSort floatValue] + delta];
     }
     
     //NSLog(@"favourite second: %@",favouriteObjects);
     [Favourites saveDatabase];
     
 }

-(void)viewDidDisappear:(BOOL)animated {
    [Favourites saveDatabase];
}

 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] initWithNibName:@"CourseInfoCoursePageViewController" bundle:nil];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]initWithNibName:@"StudentSatisfactionCoursePageViewController" bundle:nil];
    
    ReviewsCoursePageViewController *reviewsCoursePageViewController = [[ReviewsCoursePageViewController alloc] initWithNibName:@"ReviewsCoursePageViewController" bundle:nil];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] initWithNibName:@"UniInfoCoursePageViewController" bundle:nil];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] initWithNibName:@"CoursePageTabBarController" bundle:nil];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,reviewsCoursePageViewController,uniInfoCoursePageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    coursePageTabBarController.navigationItem.title = @"Course";
    coursePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [coursePageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    
    
   // [courseInfoCoursePageViewController.favouritesPopoverButton setTitle:@"Remove from Favourites" forState:UIControlStateNormal];

    favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
    favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
    [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
    
    
    
    
    // push to the next view controllers the course code and ukprn
    
    courseInfoCoursePageViewController.uniCodeCourseInfo = [self.uniCodes objectAtIndex:indexPath.row];
    courseInfoCoursePageViewController.courseCodeCourseInfo = [self.courseCodes objectAtIndex:indexPath.row];
    courseInfoCoursePageViewController.courseNameCourseInfo = cell.textLabel.text;
    courseInfoCoursePageViewController.uniNameCourseInfo = cell.detailTextLabel.text;
    courseInfoCoursePageViewController.haveComeFromFavourites = YES;
    courseInfoCoursePageViewController.isItFavourite = YES;
    
    reviewsCoursePageViewController.courseCodeReviews = [self.courseCodes objectAtIndex:indexPath.row];
    reviewsCoursePageViewController.courseNameReviews = cell.textLabel.text;
    reviewsCoursePageViewController.uniNameReviews = cell.detailTextLabel.text;
    reviewsCoursePageViewController.uniCodeReviews = [self.uniCodes objectAtIndex:indexPath.row];
    
    studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = [self.courseCodes objectAtIndex:indexPath.row];
    studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = [self.uniCodes objectAtIndex:indexPath.row];
    studentSatisfactionCoursePageViewController.courseNameStudentSatisfaction = cell.textLabel.text;
    studentSatisfactionCoursePageViewController.uniNameStudentSatisfaction = cell.detailTextLabel.text;
    
    uniInfoCoursePageViewController.haveWeComeFromUniversities = NO;
    uniInfoCoursePageViewController.uniNameUniInfo = cell.detailTextLabel.text;
    uniInfoCoursePageViewController.uniCodeUniInfo = [self.uniCodes objectAtIndex:indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
    
}

- (void)updateArrays
{
    [self.favouriteObjects removeAllObjects];
    [self.uniCodes removeAllObjects];
    [self.uniNames removeAllObjects];
    [self.courseCodes removeAllObjects];
    [self.courseNames removeAllObjects];
    [self.reversed removeAllObjects];

    [self.favouriteObjects addObjectsFromArray:[Favourites readObjectsWithPredicate:nil andSortKey:@"sortNumber"]];
    
    NSArray *temp = [self.favouriteObjects valueForKey:@"courseName"];
    
    int i;
    for (i=0; i < self.favouriteObjects.count; i++) {
        Favourites *tempObject = [self.favouriteObjects objectAtIndex:i];
        tempObject.sortNumber = [NSNumber numberWithInt:i];
    }
    [Favourites saveDatabase];
    
    NSArray *temp2 = [self.favouriteObjects valueForKey:@"sortNumber"];
    NSLog(@"temp: %@ and %@",temp,temp2);
    
    [self.reversed addObjectsFromArray:[[self.favouriteObjects reverseObjectEnumerator] allObjects]];

    [self.uniNames addObjectsFromArray:[reversed valueForKey:@"uniName"]];
    [self.uniCodes addObjectsFromArray:[reversed valueForKey:@"uniCode"]];
    [self.courseNames addObjectsFromArray:[reversed valueForKey:@"courseName"]];
    [self.courseCodes addObjectsFromArray:[reversed valueForKey:@"courseCode"]];
    
    // Add something if user has no favourites:
    if (self.favouriteObjects.count == 0) {
        NSLog(@"got here");
        noFavouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 280, 60)];
        noFavouritesLabel.text = @"You don't have any favourites at the moment";
        noFavouritesLabel.textColor = [UIColor grayColor];
        noFavouritesLabel.textAlignment = NSTextAlignmentCenter;
        noFavouritesLabel.numberOfLines = 1;
        noFavouritesLabel.font = [UIFont fontWithName:@"Helvetica"  size:14.0];
        [self.view addSubview:noFavouritesLabel];
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        CGFloat screenWidth = screenSize.width;
        
        self.noFavouritesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.noFavouritesButton.frame = CGRectMake(screenWidth/2 - 80, 136, 160, 37);
        [self.noFavouritesButton addTarget:self action:@selector(noFavouritesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        noFavouritesButton.exclusiveTouch = YES;
        noFavouritesButton.titleLabel.font = [UIFont fontWithName:@"Helvita" size:15.0];
        [self.noFavouritesButton setTitle:@"Add Favourites" forState:UIControlStateNormal];
        [noFavouritesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:self.noFavouritesButton];
        noFavouritesButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        CALayer *btnLayer = [noFavouritesButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
    }
    else {
        self.noFavouritesButton.hidden = YES;
        self.noFavouritesLabel.hidden = YES;
        
    }
    
    
}


-(void) callAnotherMethod {
    
    courseInfoCoursePageViewController.favouritesButton = self.favouritesButton;
    [courseInfoCoursePageViewController customBtnPressed];
}

- (void)noFavouritesButtonPressed:(UIButton*)button
{
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:searchViewController animated:YES];
    
    
}

@end
