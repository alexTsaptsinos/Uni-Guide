//
//  CommonJobsCompareViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 25/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "CommonJobsCompareViewController.h"

@interface CommonJobsCompareViewController ()

@end

@implementation CommonJobsCompareViewController

@synthesize compareCollectionView,firstCommonJobsTableView,secondCommonJobsTableView,sectionTableView,firstJobsArray,secondJobsArray,firstPercentagesArray,secondPercentagesArray,courseObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingInterestingHappened:) name:@"desiredEventHappend" object:nil];
    
    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20 - self.tabBarController.tabBar.frame.size.height - 45;
    
    CompareCollectionViewLayout *layout = [[CompareCollectionViewLayout alloc] init];
    compareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, widthFloat, heightFloat) collectionViewLayout:layout];
    NSLog(@"test height: %f",self.navigationController.navigationBar.frame.size.height);
    [compareCollectionView setDataSource:self];
    [compareCollectionView setDelegate:self];
    [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CompareCellIdentifier"];

    [compareCollectionView setBackgroundColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f]];
    compareCollectionView.showsHorizontalScrollIndicator = NO;
    compareCollectionView.showsVerticalScrollIndicator = NO;
    compareCollectionView.scrollEnabled = YES;
    compareCollectionView.pagingEnabled = NO;
    compareCollectionView.directionalLockEnabled = YES;
    
    [self.view addSubview:compareCollectionView];
    
    sectionTableView = [[UITableView alloc] init];
    sectionTableView.frame = CGRectMake(0, 80, widthFloat, 30);
    sectionTableView.delegate = self;
    sectionTableView.dataSource = self;
    sectionTableView.bounces = YES;
    sectionTableView.scrollEnabled = NO;
    sectionTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:sectionTableView];
    
    
    
    firstCommonJobsTableView = [[UITableView alloc] init];
    firstCommonJobsTableView.frame = CGRectMake(0, 110, widthFloat/2, heightFloat-65);
    firstCommonJobsTableView.delegate = self;
    firstCommonJobsTableView.dataSource = self;
    firstCommonJobsTableView.bounces = YES;
    firstCommonJobsTableView.scrollEnabled = YES;
    firstCommonJobsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:firstCommonJobsTableView];
    
    secondCommonJobsTableView = [[UITableView alloc] init];
    secondCommonJobsTableView.frame = CGRectMake(widthFloat/2, 110, widthFloat/2, heightFloat-65);
    secondCommonJobsTableView.delegate = self;
    secondCommonJobsTableView.dataSource = self;
    secondCommonJobsTableView.bounces = YES;
    secondCommonJobsTableView.scrollEnabled = YES;
    secondCommonJobsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:secondCommonJobsTableView];
    
    NSArray *comparesArray = [Compares readAllObjects];
    if (comparesArray.count == 0) {
        firstCommonJobsTableView.hidden = YES;
        secondCommonJobsTableView.hidden = YES;
        sectionTableView.hidden = YES;
        
        // THERE ARE NO COMPARES SO SET UP A MESSAGE AND A BUTTON TO ADD FROM FAVOURITES
        UILabel *noFavouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 280, 60)];
        noFavouritesLabel.text = @"You don't have any courses added to compare at the moment";
        noFavouritesLabel.textColor = [UIColor grayColor];
        noFavouritesLabel.textAlignment = NSTextAlignmentCenter;
        noFavouritesLabel.numberOfLines = 0;
        noFavouritesLabel.font = [UIFont fontWithName:@"Helvetica"  size:16.0];
        [self.view addSubview:noFavouritesLabel];
        
        UIButton *noComparesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        noComparesButton.frame = CGRectMake(widthFloat/2 - 90, 136, 180, 37);
        [noComparesButton addTarget:self action:@selector(noComparesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        noComparesButton.exclusiveTouch = YES;
        noComparesButton.titleLabel.font = [UIFont fontWithName:@"Helvita" size:15.0];
        [noComparesButton setTitle:@"Add from Favourites" forState:UIControlStateNormal];
        [noComparesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:noComparesButton];
        noComparesButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        CALayer *btnLayer = [noComparesButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
    } else if (comparesArray.count == 1) {
        firstCommonJobsTableView.hidden = NO;
        secondCommonJobsTableView.hidden = YES;
        Compares *firstCourse = [comparesArray objectAtIndex:0];
        firstJobsArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:firstCourse.commonJobs]];
        firstPercentagesArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:firstCourse.commonJobsPercentages]];
        if (firstJobsArray.count < 5) {
            firstCommonJobsTableView.scrollEnabled = NO;
        }
        
        // ONLY ONE COMPARE
        UILabel *oneFavouriteLabel = [[UILabel alloc] initWithFrame:CGRectMake(widthFloat*2/3 - 5, 43, widthFloat/3, 200)];
        oneFavouriteLabel.text = @"You only have one course added to compare";
        oneFavouriteLabel.textColor = [UIColor grayColor];
        oneFavouriteLabel.textAlignment = NSTextAlignmentCenter;
        oneFavouriteLabel.numberOfLines = 0;
        oneFavouriteLabel.font = [UIFont fontWithName:@"Helvetica"  size:16.0];
        [self.view addSubview:oneFavouriteLabel];
        
        UIButton *oneCompareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        oneCompareButton.frame = CGRectMake(widthFloat*2/3, 220, widthFloat/3-10, 50);
        [oneCompareButton addTarget:self action:@selector(noComparesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        oneCompareButton.exclusiveTouch = YES;
        oneCompareButton.titleLabel.font = [UIFont fontWithName:@"Helvita" size:15.0];
        oneCompareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [oneCompareButton setTitle:@"Add from Favourites" forState:UIControlStateNormal];
        [oneCompareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        oneCompareButton.titleLabel.numberOfLines = 0;
        [self.view addSubview:oneCompareButton];
        oneCompareButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        CALayer *btnLayer = [oneCompareButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
    } else {
        firstCommonJobsTableView.hidden = NO;
        secondCommonJobsTableView.hidden = NO;
        Compares *firstCourse = [comparesArray objectAtIndex:0];
        Compares *secondCourse = [comparesArray objectAtIndex:1];
        firstJobsArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:firstCourse.commonJobs]];
        firstPercentagesArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:firstCourse.commonJobsPercentages]];
        secondJobsArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:secondCourse.commonJobs]];
        secondPercentagesArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:secondCourse.commonJobsPercentages]];
        if (firstJobsArray.count < 5) {
            firstCommonJobsTableView.scrollEnabled = NO;
        }
        if (secondJobsArray.count < 5) {
            secondCommonJobsTableView.scrollEnabled = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *comparesArray = [Compares readAllObjects];
    if (comparesArray.count == 0) {
        return 0;
    } else if (comparesArray.count == 1) {
        return 2;
    } else {
        return 3;
    }
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *comparesArray = [Compares readAllObjects];
    if (indexPath.row == 0) {
        self.courseObject = [comparesArray objectAtIndex:0];
        //self.courseObject = [comparesArray objectAtIndex:0];
    } else if (indexPath.row == 2) {
        self.courseObject = [comparesArray objectAtIndex:1];
    }
    
    if (indexPath.row == 1) {
        // TOP MIDDLE
        NSString *cellTitleIdentifier = [NSString stringWithFormat:@"CompareCollectionViewCell%li", (long)indexPath.row];
        [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellTitleIdentifier];
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellTitleIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = NO;
        cell.uniNameLabel.text = @"Source: KIS";
        cell.uniNameLabel.font = [UIFont fontWithName:@"System" size:5];
        cell.uniNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        [cell.contentView layoutIfNeeded];
        return cell;
    } else {
        // TOP ROW TITLES
        NSString *cellTitleIdentifier = [NSString stringWithFormat:@"CompareCollectionViewCell%li", (long)indexPath.row];
        [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellTitleIdentifier];
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellTitleIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.text = courseObject.uniName;
        cell.courseNameLabel.text = courseObject.courseName;
        NSString *yearAbroad = courseObject.yearAbroad;
        NSString *yearIndustry = courseObject.sandwichYear;
        if ([yearAbroad isEqualToString:@"1"]) {
            cell.yearAbroadLabel.text = @"Year abroad optional";
        } else if ([yearAbroad isEqualToString:@"2"]) {
            cell.yearAbroadLabel.text = @"Year abroad compulsory";
        } else {
            cell.yearAbroadLabel.text = @"Year abroad not available";
        }
        
        if ([yearIndustry isEqualToString:@"1"]) {
            cell.yearIndustryLabel.text = @"Year in industry optional";
        } else if ([yearIndustry isEqualToString:@"2"]) {
            cell.yearIndustryLabel.text = @"Year in industry compulsory";
        } else {
            cell.yearIndustryLabel.text = @"Year in industry not available";
        }
        cell.uniNameLabel.hidden = NO;
        cell.courseNameLabel.hidden = NO;
        cell.yearAbroadLabel.hidden = NO;
        cell.yearIndustryLabel.hidden = NO;
        [cell.contentView layoutIfNeeded];
        return cell;
    }
}

// TABLE CODE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == sectionTableView) {
        return 0;
    } else {
        NSNumber *temp1 = [NSNumber numberWithInteger:firstJobsArray.count];
        NSNumber *temp2 = [NSNumber numberWithInteger:secondJobsArray.count];
        NSUInteger i;
        if ([temp1 isGreaterThan:temp2]) {
            for (i = secondJobsArray.count; i<firstJobsArray.count; i++) {
                [secondJobsArray addObject:@""];
                [secondPercentagesArray addObject:@""];
            }
            return firstJobsArray.count;
        } else {
            for (i = firstJobsArray.count; i<secondJobsArray.count; i++) {
                [firstJobsArray addObject:@""];
                [secondPercentagesArray addObject:@""];
            }
            return secondJobsArray.count;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == sectionTableView) {
        return 22;
    } else {
        return 0;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.text=@"Common jobs for graduates:";

    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifierJobs = [NSString stringWithFormat:@"CommonJobsCustomCellView%li",(long)indexPath.row];
    
    CommonJobsCustomCellView *cell = (CommonJobsCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierJobs];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommonJobsCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.percentageLabel.textAlignment = NSTextAlignmentLeft;
    cell.percentageLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    cell.percentageLabel.font = [UIFont fontWithName:@"Arial" size:16];
    
    UILabel *shortJobLabel = [[UILabel alloc] init];
    shortJobLabel.frame = CGRectMake(40, 2, 110, 60);
    shortJobLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    if (tableView == firstCommonJobsTableView) {
        shortJobLabel.text = [self.firstJobsArray objectAtIndex:indexPath.row];
        if (!firstPercentagesArray) {
            NSString *tempPercentage =[NSString stringWithFormat:@"%@%%",[self.firstPercentagesArray objectAtIndex:indexPath.row]];
            if ([tempPercentage isEqualToString:@"%"]) {
                cell.percentageLabel.text = @"";
            } else {
                cell.percentageLabel.text = tempPercentage;
            }
        } else {
            cell.percentageLabel.text = @"";
        }
        
        
    } else {
        shortJobLabel.text = [self.secondJobsArray objectAtIndex:indexPath.row];
        NSString *tempPercentage =[NSString stringWithFormat:@"%@%%",[self.secondPercentagesArray objectAtIndex:indexPath.row]];
        if ([tempPercentage isEqualToString:@"%"]) {
            cell.percentageLabel.text = @"";
        } else {
            cell.percentageLabel.text = tempPercentage;
        }
    }
    shortJobLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    shortJobLabel.textAlignment = NSTextAlignmentRight;
    shortJobLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [cell addSubview:shortJobLabel];
    cell.jobLabel.hidden = YES;
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)noComparesButtonClicked {
    
    AddFromFavouritesTableViewController *addFromFavouritesTableViewController = [[AddFromFavouritesTableViewController alloc] initWithNibName:@"AddFromFavouritesTableViewController" bundle:nil];
    UINavigationController *addFromFavouritesNavigationController = [[UINavigationController alloc]initWithRootViewController:addFromFavouritesTableViewController];
    [self presentViewController:addFromFavouritesNavigationController animated:YES completion:nil];
}

- (void)someThingInterestingHappened:(NSNotification *)info
{
    
    [self viewDidLoad];
    
}

@end
