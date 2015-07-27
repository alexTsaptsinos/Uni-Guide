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

@synthesize compareCollectionView,firstCommonJobsTableView,secondCommonJobsTableView,sectionTableView,firstJobsArray,secondJobsArray,firstPercentagesArray,secondPercentagesArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    firstJobsArray = [[NSMutableArray alloc] initWithObjects:@"This is a long Job title",@"Job 2",@"Job 3",@"Job 4",@"Job 5",@"Job 7",@"Job 8",@"Job 9",@"Job 10", nil];
    secondJobsArray = [[NSMutableArray alloc] initWithObjects:@"WOw 1",@"wow2",@"wow3",@"wow4", nil];
    firstPercentagesArray = [[NSMutableArray alloc] initWithObjects:@"50",@"20",@"5",@"5",@"3",@"3",@"4",@"3",@"3",@"4", nil];
    secondPercentagesArray = [[NSMutableArray alloc] initWithObjects:@"60",@"20",@"10",@"10", nil];
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
    return 3;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
        cell.uniNameLabel.text = @"University Name";
        cell.courseNameLabel.text = @"Course Name";
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
    shortJobLabel.frame = CGRectMake(50, 2, 100, 40);
    shortJobLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    if (tableView == firstCommonJobsTableView) {
        shortJobLabel.text = [self.firstJobsArray objectAtIndex:indexPath.row];
        NSString *tempPercentage =[NSString stringWithFormat:@"%@%%",[self.firstPercentagesArray objectAtIndex:indexPath.row]];
        if ([tempPercentage isEqualToString:@"%"]) {
            cell.percentageLabel.text = @"";
        } else {
            cell.percentageLabel.text = tempPercentage;
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
    return 50;
    
    
}

@end
