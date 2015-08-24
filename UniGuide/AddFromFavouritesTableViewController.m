//
//  AddFromFavouritesTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 31/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "AddFromFavouritesTableViewController.h"

@interface AddFromFavouritesTableViewController ()

@end

@implementation AddFromFavouritesTableViewController

@synthesize courseCodes,courseNames,uniCodes,uniNames,favouriteObjects,reversed;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnPressed)];
    
    [self.navigationItem setRightBarButtonItem:cancelButton];
    
    UILabel *addReviewTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    addReviewTitle.text = @"Add from Favourites";
    addReviewTitle.backgroundColor = [UIColor clearColor];
    addReviewTitle.textColor = [UIColor whiteColor];
    addReviewTitle.font = [UIFont boldSystemFontOfSize:20.0];
    addReviewTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    addReviewTitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = addReviewTitle;
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.favouriteObjects = [[NSMutableArray alloc] init];
    self.uniNames = [[NSMutableArray alloc] init];
    self.uniCodes = [[NSMutableArray alloc] init];
    self.courseNames = [[NSMutableArray alloc] init];
    self.courseCodes = [[NSMutableArray alloc] init];
    self.reversed = [[NSMutableArray alloc] init];
    [self updateArrays];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.courseCodes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.courseNames objectAtIndex:indexPath.row];
    
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.detailTextLabel.text = [self.uniNames objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    NSString *courseCodeTemp = [courseCodes objectAtIndex:indexPath.row];
    NSString *uniCodeTemp = [uniCodes objectAtIndex:indexPath.row];
    
    NSArray * temp2 = [Compares readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",courseCodeTemp,uniCodeTemp] andSortKey:@"courseName"];
    if (temp2.count != 0) {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.userInteractionEnabled = NO;

    } else {
    
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    }
    
    
    
    return cell;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *courseSelectedCode = [courseCodes objectAtIndex:indexPath.row];
    NSString *uniSelectedCode = [uniCodes objectAtIndex:indexPath.row];
    

    NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",courseSelectedCode,uniSelectedCode] andSortKey:@"courseName"];
    Favourites *tempFavourites = [temp2 objectAtIndex:0];

    Compares * tempCompares = [Compares createObject];
    tempCompares.courseCode = tempFavourites.courseCode;
    tempCompares.courseName = tempFavourites.courseName;
    tempCompares.uniName = tempFavourites.uniName;
    tempCompares.uniCode = tempFavourites.uniCode;
    tempCompares.yearAbroad = tempFavourites.yearAbroad;
    tempCompares.sandwichYear = tempFavourites.sandwichYear;
    tempCompares.ucasCode = tempFavourites.ucasCode;
    tempCompares.courseUrl = tempFavourites.courseUrl;
    tempCompares.degreeClasses = tempFavourites.degreeClasses;
    tempCompares.averageTariffString = tempFavourites.averageTariffString;
    tempCompares.assessmentMethods = tempFavourites.assessmentMethods;
    tempCompares.timeSpent = tempFavourites.timeSpent;
    tempCompares.proportionInWork = tempFavourites.proportionInWork;
    tempCompares.commonJobs = tempFavourites.commonJobs;
    tempCompares.commonJobsPercentages = tempFavourites.commonJobsPercentages;
    tempCompares.instituteSalary = tempFavourites.instituteSalary;
    
    tempCompares.nSSScores = tempFavourites.nSSScores;
    tempCompares.uniInfoData = tempFavourites.uniInfoData;
    tempCompares.unionSatisfaction = tempFavourites.unionSatisfaction;
    
    [Compares saveDatabase];
//    CompareViewController *parent = (CompareViewController *)self.parentViewController;
//    [parent refreshData];
    //[self.parentViewController viewDidLoad];

   // [self.parentViewController reloadInputViews];
//    CompareViewController *parent = [[CompareViewController alloc] init];
//    [self.parentViewController viewDidLoad];
//    [parent refreshData];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"desiredEventHappend" object:nil];

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    


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
        UILabel *noFavouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 280, 60)];
        noFavouritesLabel.text = @"You don't have any favourites at the moment";
        noFavouritesLabel.textColor = [UIColor grayColor];
        noFavouritesLabel.textAlignment = NSTextAlignmentCenter;
        noFavouritesLabel.numberOfLines = 1;
        noFavouritesLabel.font = [UIFont fontWithName:@"Helvetica"  size:14.0];
        [self.view addSubview:noFavouritesLabel];
        
    }
    else {
        
    }
    
    
}

-(void) doneBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
