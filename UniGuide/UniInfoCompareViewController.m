//
//  UniInfoCompareViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 25/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "UniInfoCompareViewController.h"

@interface UniInfoCompareViewController ()

@end

@implementation UniInfoCompareViewController

@synthesize compareCollectionView,courseObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingInterestingHappened:) name:@"desiredEventHappend" object:nil];

    self.tabBarController.tabBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20 - self.tabBarController.tabBar.frame.size.height;
    
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
    
    NSArray *comparesArray = [Compares readAllObjects];
    if (comparesArray.count == 0) {
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
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
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
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    
    NSArray *comparesArray = [Compares readAllObjects];
    if (indexPath.row == 0) {
        self.courseObject = [comparesArray objectAtIndex:0];
        //self.courseObject = [comparesArray objectAtIndex:0];
    } else if (indexPath.row == 2) {
        self.courseObject = [comparesArray objectAtIndex:1];
    }
    
    if (indexPath.section == 0) {
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
            cell.uniNameLabel.text = @"Source: HESA";
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
    } else if (indexPath.section == 6) {
        // UNION SATISFACTION
        NSString *cellTitleIdentifier = [NSString stringWithFormat:@"CompareCollectionViewCell%li%li", (long)indexPath.row,(long)indexPath.section];
        [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellTitleIdentifier];
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellTitleIdentifier forIndexPath:indexPath];
        
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        if (indexPath.row == 1) {
            // MIDDLE
            
            UILabel *cellTitleLabel = [[UILabel alloc] init];
            cellTitleLabel.frame = CGRectMake(0, 0, widthFloat/3 - 14, 80);
            cellTitleLabel.text = @"Satisfaction with union";
            cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellTitleLabel.textAlignment = NSTextAlignmentCenter;
            cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:13];
            cellTitleLabel.numberOfLines = 0;
            [cell addSubview:cellTitleLabel];
        } else {
            
            UIImageView *unionSatisfactionImageView = [[UIImageView alloc] init];
            UIImageView *unionSatisfactionImageViewFull = [[UIImageView alloc] init];
            unionSatisfactionImageViewFull.frame = CGRectMake(28, 0, 55, 75);
            unionSatisfactionImageViewFull.contentMode = UIViewContentModeTop;
            unionSatisfactionImageView.image = [UIImage imageNamed:@"ui-19emptysmaller"];
            unionSatisfactionImageViewFull.image = [UIImage imageNamed:@"ui-19fillsmaller"];
            [cell addSubview:unionSatisfactionImageViewFull];
            
            NSLog(@"heasfasdf: %@",courseObject.unionSatisfaction);
            UILabel *unionSatisfactionNumberLabel = [[UILabel alloc] init];
            if ([courseObject.unionSatisfaction isEqualToString:@""]) {
                unionSatisfactionNumberLabel.text = @"N/A";
            } else {
            unionSatisfactionNumberLabel.text = [NSString stringWithFormat:@"%@%%",courseObject.unionSatisfaction];
            }
            unionSatisfactionNumberLabel.textAlignment = NSTextAlignmentCenter;
            unionSatisfactionNumberLabel.frame = CGRectMake(27, 17, 40, 20);
            unionSatisfactionNumberLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:13];
            unionSatisfactionNumberLabel.numberOfLines = 1;
            unionSatisfactionNumberLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            [cell addSubview:unionSatisfactionNumberLabel];
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber * unionPercentage = [f numberFromString:courseObject.unionSatisfaction];
            unionPercentage = [NSNumber numberWithFloat:([unionPercentage floatValue] / 100.0f)];
            unionPercentage = [NSNumber numberWithFloat:(1.0f - [unionPercentage floatValue])];
            
            [unionSatisfactionImageView setFrame:CGRectMake(unionSatisfactionImageViewFull.frame.origin.x, unionSatisfactionImageViewFull.frame.origin.y, unionSatisfactionImageViewFull.frame.size.width, unionSatisfactionImageViewFull.frame.size.height * [unionPercentage floatValue])];
            unionSatisfactionImageView.contentMode = UIViewContentModeTop; // This determines position of image
            unionSatisfactionImageView.clipsToBounds = YES;
            [cell addSubview:unionSatisfactionImageView];
        }
        return cell;
        
    } else {
        // GENERAL UNI INFO
        
        NSString *cellTitleIdentifier = [NSString stringWithFormat:@"CompareCollectionViewCell%li%li", (long)indexPath.row,(long)indexPath.section];
        [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellTitleIdentifier];
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellTitleIdentifier forIndexPath:indexPath];
        
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        if (indexPath.row == 1) {
            // MIDDLE
            NSArray *questionNames = [[NSArray alloc] initWithObjects:@"Number of students",@"Number of staff",@"Number of institute owned rooms",@"Average cost of institute accommodation",@"Average cost of private accommodation", nil];
            
            UILabel *cellTitleLabel = [[UILabel alloc] init];
            cellTitleLabel.frame = CGRectMake(0, 0, widthFloat/3 - 14, 80);
            cellTitleLabel.text = [questionNames objectAtIndex:indexPath.section - 1];
            cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellTitleLabel.textAlignment = NSTextAlignmentCenter;
            cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:13];
            cellTitleLabel.numberOfLines = 0;
            [cell addSubview:cellTitleLabel];
        } else {
            UIImageView *cellImageView = [[UIImageView alloc] init];
            cellImageView.frame = CGRectMake(22, 6, 66, 66);
            cellImageView.image = [UIImage imageNamed:@"ui-17"];
            [cell addSubview:cellImageView];
            
            UILabel *cellNumberLabel = [[UILabel alloc] init];
            cellNumberLabel.frame = CGRectMake(25, 28, 60, 20);
            NSMutableArray *uniDataTemp = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:courseObject.uniInfoData]];
            cellNumberLabel.text = [uniDataTemp objectAtIndex:indexPath.section - 1];
            cellNumberLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            cellNumberLabel.textAlignment = NSTextAlignmentCenter;
            cellNumberLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
            cellNumberLabel.numberOfLines = 1;
            [cell addSubview:cellNumberLabel];
        }
        return cell;
        
    }
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
