//
//  CompareViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 17/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "CompareViewController.h"

@interface CompareViewController ()

@end

@implementation CompareViewController

@synthesize compareCollectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Compare";
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    CompareCollectionViewLayout *layout = [[CompareCollectionViewLayout alloc] init];
    compareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, widthFloat, heightFloat) collectionViewLayout:layout];
    NSLog(@"test height: %f",self.navigationController.navigationBar.frame.size.height);
    [compareCollectionView setDataSource:self];
    [compareCollectionView setDelegate:self];
    [self.compareCollectionView registerNib:[UINib nibWithNibName:@"CompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CompareCellIdentifier"];

    //[compareCollectionView registerClass:[CompareCollectionViewCell class] forCellWithReuseIdentifier:@"CompareCellIdentifier"];
    [compareCollectionView setBackgroundColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f]];
    compareCollectionView.showsHorizontalScrollIndicator = NO;
    compareCollectionView.showsVerticalScrollIndicator = NO;
    compareCollectionView.scrollEnabled = YES;
    compareCollectionView.pagingEnabled = NO;
    compareCollectionView.directionalLockEnabled = YES;
    
    [self.view addSubview:compareCollectionView];
    
    // SET UP EXAMPLE DATA TO USE FOR BUILDING PURPOSES
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// METHODS FOR COLLECTION VIEW

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // TOP LEFT CORNER
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
            cell.uniNameLabel.font = [UIFont fontWithName:@"System" size:11];
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
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // FIRST ROW - DEGREE CLASSES

            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];

            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            
            cellPie.cellTitleLabel.text = @"Degree classes:";
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"First",@"Other",@"2:1",@"Ordinary",@"2:2",@"N/A", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27",@"28",@"29",@"30", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-207, 50);
            cellPie.whichPieChart = 1;
            cellPie.onlyPieChart = 0;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        } else {
        
            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];
            
            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            
            cellPie.cellTitleLabel.hidden = YES;
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"First",@"Other",@"2:1",@"Ordinary",@"2:2",@"N/A", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27",@"28",@"29",@"30", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-207, 50);
            cellPie.whichPieChart = 1;
            cellPie.onlyPieChart = YES;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        }
        
    }   else if (indexPath.section == 2) {
        // NOT DONE YET
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CompareCellIdentifier" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        cell.backgroundColor = [UIColor redColor];
        [cell.contentView layoutIfNeeded];
        return cell;
        
    } else if (indexPath.section == 3) {
        // THIRD ROW - EXAM METHODS
        
        if (indexPath.row == 0) {
            
            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];
            
            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.numberOfLines = 2;
            
            cellPie.cellTitleLabel.text = @"Exam methods:";
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Written",@"Coursework",@"Practical", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-217, 50);
            cellPie.whichPieChart = 2;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        } else {
            
            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];
            
            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            
            cellPie.cellTitleLabel.hidden = YES;
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Written",@"Coursework",@"Practical", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-207, 50);
            cellPie.whichPieChart = 2;
            cellPie.onlyPieChart = YES;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        }
        
    }   else if (indexPath.section == 4) {
        // FOURTH ROW - LEARNING TIME
        
        if (indexPath.row == 0) {
            
            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];
            
            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            
            cellPie.cellTitleLabel.text = @"Learning time:";
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Independent",@"Placements",@"Scheduled", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-215.5, 50);
            cellPie.whichPieChart = 3;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        } else {
            
            NSString *cellPieIdentifier = [NSString stringWithFormat:@"PieCompareCollectionViewCell%li", (long)indexPath.row];
            [self.compareCollectionView registerNib:[UINib nibWithNibName:@"PieCompareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellPieIdentifier];
            
            PieCompareCollectionViewCell *cellPie = (PieCompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellPieIdentifier forIndexPath:indexPath];
            
            if (cellPie == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PieCompareCollectionViewCell" owner:self options:nil];
                cellPie = [nib objectAtIndex:0];
            }
            cellPie.legendTitles = [[NSMutableArray alloc] init];
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:11];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            
            cellPie.cellTitleLabel.hidden = YES;
            [cellPie.legendTitles removeAllObjects];
            [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Independent",@"Placements",@"Scheduled", nil]];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:@"25",@"26",@"27", nil];
            //cellPie.sectionData = self.degreeStatistics;
            cellPie.sectionData = tempArray;
            cellPie.legendPoint = CGPointMake(-207, 50);
            cellPie.whichPieChart = 3;
            cellPie.onlyPieChart = YES;
            
            [cellPie.contentView layoutIfNeeded];
            return cellPie;
        }
        
    }   else if (indexPath.section == 5) {
        //NOT DONE YET
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CompareCellIdentifier" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        cell.backgroundColor = [UIColor redColor];
        [cell.contentView layoutIfNeeded];
        return cell;
        
    }   else if (indexPath.section == 6) {
        //NOT DONE YET
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CompareCellIdentifier" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        cell.backgroundColor = [UIColor redColor];
        [cell.contentView layoutIfNeeded];
        return cell;
        
    }   else{
        // NOT DONE YET - FINAL ROW
        
        CompareCollectionViewCell *cell = (CompareCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CompareCellIdentifier" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareCollectionViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.uniNameLabel.hidden = YES;
        cell.courseNameLabel.hidden = YES;
        cell.yearAbroadLabel.hidden = YES;
        cell.yearIndustryLabel.hidden = YES;
        cell.backgroundColor = [UIColor redColor];
        [cell.contentView layoutIfNeeded];
        return cell;
    }
}


@end
