//
//  StudentSatisfactionCompareViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 25/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "StudentSatisfactionCompareViewController.h"

@interface StudentSatisfactionCompareViewController ()

@end

@implementation StudentSatisfactionCompareViewController

@synthesize compareCollectionView,questionResults,questionResults2,courseObject;

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
    return 23;
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
    
    NSArray *questionNames = [[NSArray alloc] initWithObjects:@"Staff are good at explaining things",@"Staff have made the subject interesting",@"Staff are enthusiastic about what they are teaching",@"The course is intellectually stimulating",@"The criteria used in marking have been clear in advance",@"Assessment arrangements and marking have been fair",@"Feedback on my work has been promt",@"I have received detailed comments on my work",@"Feedback on my work has helped me clarify things I did not understand",@"I have received sufficient advice and support with my studies",@"I have been able to contact staff when I needed to",@"Good advice was available when I needed to make study choices",@"The timetable works efficiently as far as my activities are concerned",@"Any changes in the course or teaching have been communicated effectively",@"The course is well organised and is running smoothly",@"The library resources and services are good enough for my needs",@"I have been able to access general IT resources when I needed to",@"I have been able to access specialised equipment, facilities or rooms when I needed to",@"The course has helped me present myself with confidence",@"My communication skills have improved",@"As a results of the course, I feel confident in tackling unfamiliar problems",@"Overall, I am satisfied with the quality of the course", nil];
    
    NSArray *comparesArray = [Compares readAllObjects];
    if (indexPath.row == 0) {
        self.courseObject = [comparesArray objectAtIndex:0];
//        self.questionResults1 = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:courseObject.degreeClasses]];
    } else if (indexPath.row == 2) {
        self.courseObject = [comparesArray objectAtIndex:1];
//        self.questionResults2 = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:courseObject.degreeClasses]];
    }
    self.questionResults = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:courseObject.nSSScores]];
    
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
            cell.uniNameLabel.text = @"Source: KIS";
            cell.uniNameLabel.font = [UIFont fontWithName:@"System" size:5];
            cell.uniNameLabel.textAlignment = NSTextAlignmentLeft;
            cell.courseNameLabel.hidden = YES;
            cell.yearAbroadLabel.hidden = YES;
            cell.yearIndustryLabel.hidden = YES;
            
            UILabel *cellExplanationLabel = [[UILabel alloc] init];
            cellExplanationLabel.frame = CGRectMake(3, 30, widthFloat/3 - 20, 50);
            cellExplanationLabel.text = @"Percentage of students who \"agree\" or \"strongly agree\"";
            cellExplanationLabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellExplanationLabel.textAlignment = NSTextAlignmentCenter;
            cellExplanationLabel.font = [UIFont fontWithName:@"Arial" size:10];
            cellExplanationLabel.numberOfLines = 0;
            [cell addSubview:cellExplanationLabel];
            
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

    }   else {
        // STUDENT SATISFACTION CELLS
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
            
            UILabel *cellTitleLabel = [[UILabel alloc] init];
            cellTitleLabel.frame = CGRectMake(0, 0, widthFloat/3 - 14, 80);
            cellTitleLabel.text = [questionNames objectAtIndex:indexPath.section - 1];
            cellTitleLabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellTitleLabel.textAlignment = NSTextAlignmentCenter;
            cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11.5];
            cellTitleLabel.numberOfLines = 0;
            [cell addSubview:cellTitleLabel];
            
        } else {
            
            if (questionResults.count == 0 ) {
                // NO DATA SO PUT MESSAGE
                if (indexPath.section == 1) {
                    // Put a no data message
                    cell.backgroundColor = [UIColor lightGrayColor];
                    UILabel *cellTitleLabel = [[UILabel alloc] init];
                    cellTitleLabel.frame = CGRectMake(6, 0, widthFloat/3-8, 80);
                    cellTitleLabel.text = @"We're sorry, but we appear to have no data for this course.";
                    cellTitleLabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                    cellTitleLabel.textAlignment = NSTextAlignmentCenter;
                    cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:12];
                    cellTitleLabel.numberOfLines = 0;
                    [cell addSubview:cellTitleLabel];
                } else {
                    cell.backgroundColor = [UIColor lightGrayColor];
                }
            } else {
            
            UIImageView *cellImageView = [[UIImageView alloc] init];
            cellImageView.frame = CGRectMake(5, 30, widthFloat/3, 20);
            cellImageView.image = [UIImage imageNamed:@"ui-17"];
            [cell addSubview:cellImageView];
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *myNumber;
            
//            if (indexPath.row == 0) {
//                myNumber = [f numberFromString:[self.questionResults1 objectAtIndex:indexPath.section-1]];
//            } else {
//                myNumber = [f numberFromString:[self.questionResults2 objectAtIndex:indexPath.section-1]];
//            }
            NSLog(@"question results; %@ and count: %lu",questionResults,(unsigned long)questionResults.count);
            myNumber = [f numberFromString:[self.questionResults objectAtIndex:indexPath.section - 1]];
            
            //  NSLog(@"number: %@",myNumber);
            
            NSNumber *widthOfPart1 = [NSNumber numberWithFloat:([myNumber floatValue] / 100.0f)];
            // NSLog(@"divided by 100: %@",widthOfPart1);
            widthOfPart1 = [NSNumber numberWithFloat:([widthOfPart1 floatValue] * cellImageView.frame.size.width)];
            //  NSLog(@"width of part 1: %@",widthOfPart1);
            UIImageView *part1 = [[UIImageView alloc] init];
            part1.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1 floatValue], cellImageView.frame.size.height);
            part1.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
            [cellImageView addSubview:part1];
            NSNumber *widthOfPart2 = [NSNumber numberWithFloat:(cellImageView.frame.size.width - [widthOfPart1 floatValue])];
            
            UIImageView *part2 = [[UIImageView alloc] init];
            part2.frame = CGRectMake(part1.frame.size.width, 0, [widthOfPart2 floatValue], cellImageView.frame.size.height);
            part2.backgroundColor = [UIColor colorWithRed:203.0f/255.0f green:83.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
            [cellImageView addSubview:part2];
            
            UILabel *questionPercentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, cellImageView.frame.size.height)];
            if (indexPath.row == 0) {
                questionPercentage.text = [NSString stringWithFormat:@"%@%%",[self.questionResults objectAtIndex:indexPath.section-1]];
            } else {
                questionPercentage.text = [NSString stringWithFormat:@"%@%%",[self.questionResults objectAtIndex:indexPath.section-1]];

            }
            questionPercentage.font = [UIFont fontWithName:@"Arial" size:14];
            questionPercentage.textColor = [UIColor whiteColor];
            [cellImageView addSubview:questionPercentage];
            cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            }
            
        }
        [cell.contentView layoutIfNeeded];
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
