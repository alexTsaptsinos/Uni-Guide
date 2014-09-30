//
//  UniInfoCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniInfoCoursePageViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface UniInfoCoursePageViewController (){
    
}




@end

@implementation UniInfoCoursePageViewController


@synthesize uniCodeUniInfo,studentSatisfactionPercentage,tableViewUniInfo,uniInfoDataSets,haveWeComeFromUniversities,uniNameUniInfo,firstTimeLoad,uniInfoDataNumbers,universityNameLabel,scroll,activityIndicator,noInternetLabel,noInternetImageView,sourceLabel;

#pragma mark - UIViewController lifecycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Uni Info", @"Uni Info");
        self.tabBarItem.image = [UIImage imageNamed:@"city_hall-32"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.uniInfoDataSets = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Number of students:",@"Number of staff:",@"Number of institute owned rooms:",@"Average cost of institute accommodation:",@"Average cost of private accommodation:", nil]];
    self.firstTimeLoad = YES;
    self.scroll.hidden = YES;
    self.sourceLabel.hidden = YES;
    self.universityNameLabel.hidden = YES;
    [self.activityIndicator startAnimating];
    
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstTimeLoad == YES) {
        
        NSLog(@"code: %@", self.uniCodeUniInfo);
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        
        // scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBound.size.height)];
        
        [self.view addSubview:scroll];
        scroll.showsHorizontalScrollIndicator = YES;
        scroll.scrollEnabled = YES;
        scroll.delegate = self;
        scroll.bounces = YES;
        scroll.userInteractionEnabled = YES;
        scroll.hidden = YES;
        
        UIImageView *unionSatisfactionImageView = [[UIImageView alloc] init];
        UIImageView *unionSatisfactionImageViewFull = [[UIImageView alloc] init];
        unionSatisfactionImageViewFull.contentMode = UIViewContentModeTop;
        unionSatisfactionImageView.image = [UIImage imageNamed:@"ui-19emptysmall"];
        unionSatisfactionImageViewFull.image = [UIImage imageNamed:@"ui-19fillsmall"];
        unionSatisfactionImageView.hidden = YES;
        unionSatisfactionImageViewFull.hidden = YES;
        [scroll addSubview:unionSatisfactionImageViewFull];
        
        UILabel *unionSatisfactionNumberLabel = [[UILabel alloc] init];
        UILabel *unionSatisfactionLabel = [[UILabel alloc] init];
        unionSatisfactionLabel.hidden = YES;
        unionSatisfactionNumberLabel.hidden = YES;
        
        if (self.haveWeComeFromUniversities == YES) {
            [scroll setContentSize:CGSizeMake(320, 850)];
            tableViewUniInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, 530)];
            sourceLabel.hidden = YES;
            universityNameLabel.hidden = YES;
            [unionSatisfactionImageViewFull setFrame:CGRectMake(190, self.tableViewUniInfo.frame.size.height + 30.0f, 120, 182)];
            [unionSatisfactionNumberLabel setFrame:CGRectMake(220, self.tableViewUniInfo.frame.size.height + 85.0f, 50, 20)];
            [unionSatisfactionLabel setFrame:CGRectMake(20, self.tableViewUniInfo.frame.size.height + 90.0f, 150.0f, 50.0f)];
            
        }
        else if (self.haveWeComeFromUniversities == NO) {
            [scroll setContentSize:CGSizeMake(320, 890)];
            tableViewUniInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 530)];
            universityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 20)];
            NSLog(@"hello alex: %@",self.uniNameUniInfo);
            universityNameLabel.text = self.uniNameUniInfo;
            universityNameLabel.hidden = NO;
            universityNameLabel.textAlignment = NSTextAlignmentCenter;
            universityNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            universityNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
            [unionSatisfactionImageViewFull setFrame:CGRectMake(190, self.tableViewUniInfo.frame.size.height + 50.0f, 120, 182)];
            [unionSatisfactionNumberLabel setFrame:CGRectMake(220, self.tableViewUniInfo.frame.size.height + 105.0f, 50, 20)];
            [unionSatisfactionLabel setFrame:CGRectMake(20, self.tableViewUniInfo.frame.size.height + 110.0f, 150.0f, 50.0f)];
            [scroll addSubview:universityNameLabel];
        }
        
        tableViewUniInfo.scrollEnabled = NO;
        tableViewUniInfo.delegate = self;
        tableViewUniInfo.dataSource = self;
        tableViewUniInfo.bounces = NO;
        tableViewUniInfo.hidden = YES;
        tableViewUniInfo.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        [scroll addSubview:tableViewUniInfo];
        
        
        
        unionSatisfactionLabel.textAlignment = NSTextAlignmentLeft;
        unionSatisfactionLabel.text = @"Satisfaction with union:";
        unionSatisfactionLabel.numberOfLines = 0;
        unionSatisfactionLabel.font = [UIFont fontWithName:@"Arial" size:16];
        unionSatisfactionLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        [scroll addSubview:unionSatisfactionLabel];
        
        unionSatisfactionNumberLabel.textAlignment = NSTextAlignmentCenter;
        unionSatisfactionNumberLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        [scroll addSubview:unionSatisfactionNumberLabel];
        
        // query to get satisfaction with union
        PFQuery *queryForStudentSatisfaction = [PFQuery queryWithClassName:@"Institution"];
        [queryForStudentSatisfaction whereKey:@"UKPRN" equalTo:self.uniCodeUniInfo];
        [queryForStudentSatisfaction whereKeyExists:@"Q24"];
        [queryForStudentSatisfaction findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSArray *temp = [objects objectAtIndex:0];
                studentSatisfactionPercentage = [temp valueForKey:@"Q24"];
                if (studentSatisfactionPercentage != NULL) {
                    unionSatisfactionNumberLabel.text = [NSString stringWithFormat:@"%@%%",studentSatisfactionPercentage];
                } else {
                    unionSatisfactionNumberLabel.text = @"N/A";
                }
                
                
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber * unionPercentage = [f numberFromString:studentSatisfactionPercentage];
                unionPercentage = [NSNumber numberWithFloat:([unionPercentage floatValue] / 100.0f)];
                unionPercentage = [NSNumber numberWithFloat:(1.0f - [unionPercentage floatValue])];
                NSLog(@"union percentage: %@",unionPercentage);
                
                [unionSatisfactionImageView setFrame:CGRectMake(unionSatisfactionImageViewFull.frame.origin.x, unionSatisfactionImageViewFull.frame.origin.y, unionSatisfactionImageViewFull.frame.size.width, unionSatisfactionImageViewFull.frame.size.height * [unionPercentage floatValue])];
                unionSatisfactionImageView.contentMode = UIViewContentModeTop; // This determines position of image
                unionSatisfactionImageView.clipsToBounds = YES;
                [scroll addSubview:unionSatisfactionImageView];
                
                // query to get total number of students
                PFQuery *queryForTotalNumberOfStudents = [PFQuery queryWithClassName:@"Institution1213"];
                [queryForTotalNumberOfStudents whereKey:@"UKPRN" equalTo:self.uniCodeUniInfo];
                [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"TotalAllStudents"]];
                PFObject *tempObject1 = [queryForTotalNumberOfStudents getFirstObject];
                NSString *totalNumberOfStudents = [tempObject1 valueForKey:@"TotalAllStudents"];
                
                
                
                
                // query to get total number of staff
                PFQuery *queryForTotalNumberOfStaff = [PFQuery queryWithClassName:@"StaffInst1213"];
                [queryForTotalNumberOfStaff whereKey:@"UKPRN" equalTo:self.uniCodeUniInfo];
                [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"Total"]];
                PFObject *tempObject2 = [queryForTotalNumberOfStaff getFirstObject];
                NSString *totalNumberOfStaff = [tempObject2 valueForKey:@"Total"];
                
                
                
                //query to get data on total number of beds
                PFQuery *queryForAccomodation = [PFQuery queryWithClassName:@"Location"];
                [queryForAccomodation whereKeyExists:@"INSTBEDS"];
                [queryForAccomodation whereKey:@"UKPRN" equalTo:self.uniCodeUniInfo];
                NSArray *object = [queryForAccomodation findObjects];
                NSArray *numberOfBeds = [object valueForKey:@"INSTBEDS"];
                NSString *totalNumberOfBedsString;
                if (numberOfBeds.count != 0) {
                    NSNumber * totalNumberOfBeds = [numberOfBeds valueForKeyPath:@"@sum.self"];
                    totalNumberOfBedsString = [totalNumberOfBeds stringValue];
                } else {
                    totalNumberOfBedsString = @"N/A";
                }
                
                
                
                
                //calculate average cost for private accom.
                NSArray *lowerQuartileCostOfPrivateBeds = [object valueForKey:@"PRIVATELOWER"];
                NSArray *upperQuartileCostOfPrivateBeds = [object valueForKey:@"PRIVATEUPPER"];
                NSString *averageCostOfLivingPrivateString;
                NSString *averageCostOfLivingInstituteString;
                // NSLog(@"anything exist? %@ and %@",lowerQuartileCostOfPrivateBeds,upperQuartileCostOfPrivateBeds);
                if (lowerQuartileCostOfPrivateBeds.count != 0 && upperQuartileCostOfPrivateBeds.count != 0) {
                    NSNumber *sumOfLowerQuartiles = [lowerQuartileCostOfPrivateBeds valueForKeyPath:@"@sum.self"];
                    NSNumber *sumOfUpperQuartiles = [upperQuartileCostOfPrivateBeds valueForKeyPath:@"@sum.self"];
                    // NSLog(@"lower quartiles sum: %@, upper quartiles sum: %@", sumOfLowerQuartiles,sumOfUpperQuartiles);
                    NSNumber *sumOfQuartiles = [NSNumber numberWithFloat:([sumOfLowerQuartiles floatValue] + [sumOfUpperQuartiles floatValue])];
                    // NSLog(@"sum: %@",sumOfQuartiles);
                    NSNumber *totalNumberOfValues = [NSNumber numberWithFloat:(lowerQuartileCostOfPrivateBeds.count + upperQuartileCostOfPrivateBeds.count)];
                    // NSLog(@"total values %@",totalNumberOfValues);
                    NSNumber *averageCostOfLivingPrivate = [NSNumber numberWithFloat:([sumOfQuartiles floatValue] / [totalNumberOfValues floatValue])];
                    int privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
                    averageCostOfLivingPrivateString = @"£";
                    averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%d", privateRounded]];
                } else {
                    averageCostOfLivingPrivateString = @"N/A";
                }
                
                
                //calculate average cost for institute accom.
                
                NSArray *lowerQuartileCostOfInstituteBeds = [object valueForKey:@"INSTLOWER"];
                NSArray *upperQuartileCostOfInstituteBeds = [object valueForKey:@"INSTUPPER"];
                if (lowerQuartileCostOfInstituteBeds.count != 0 && upperQuartileCostOfInstituteBeds.count != 0) {
                    NSNumber *sumOfLowerQuartiles = [lowerQuartileCostOfInstituteBeds valueForKeyPath:@"@sum.self"];
                    NSNumber *sumOfUpperQuartiles = [upperQuartileCostOfInstituteBeds valueForKeyPath:@"@sum.self"];
                    //NSLog(@"lower quartiles sum: %@, upper quartiles sum: %@", sumOfLowerQuartiles,sumOfUpperQuartiles);
                    NSNumber *sumOfQuartiles = [NSNumber numberWithFloat:([sumOfLowerQuartiles floatValue] + [sumOfUpperQuartiles floatValue])];
                    //NSLog(@"sum: %@",sumOfQuartiles);
                    NSNumber *totalNumberOfValues = [NSNumber numberWithFloat:(lowerQuartileCostOfInstituteBeds.count + upperQuartileCostOfInstituteBeds.count)];
                    //NSLog(@"total values %@",totalNumberOfValues);
                    NSNumber *averageCostOfLivingInstitute = [NSNumber numberWithFloat:([sumOfQuartiles floatValue] / [totalNumberOfValues floatValue])];
                    int instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
                    averageCostOfLivingInstituteString = @"£";
                    averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%d", instituteRounded]];
                    NSLog(@"averageL %@",averageCostOfLivingInstituteString);
                } else {
                    averageCostOfLivingInstituteString = @"N/A";
                    
                }
                
                NSLog(@"1: %@ 2: %@ 3: %@ 4: %@ 5: %@",totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString);
                
                self.uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];
                NSLog(@"numbers: %@",self.uniInfoDataNumbers);
                
                self.firstTimeLoad = NO;
                self.scroll.hidden = NO;
                self.sourceLabel.hidden = NO;
                unionSatisfactionLabel.hidden = NO;
                unionSatisfactionNumberLabel.hidden = NO;
                unionSatisfactionImageView.hidden = NO;
                unionSatisfactionImageViewFull.hidden = NO;
                [self.activityIndicator stopAnimating];
                [self.tableViewUniInfo reloadData];
                self.tableViewUniInfo.hidden = NO;
                
            }
            else {
                NSLog(@"no internet");
                
                
                noInternetImageView = [[UIImageView alloc] init];
                
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
                
                if (self.haveWeComeFromUniversities == NO) {
                    noInternetImageView.frame = CGRectMake(0, 90, 320, 429);
                    universityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 20)];
                    universityNameLabel.text = self.uniNameUniInfo;
                    universityNameLabel.textAlignment = NSTextAlignmentCenter;
                    universityNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
                    universityNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                    [self.view addSubview:universityNameLabel];
                    self.universityNameLabel.hidden = NO;
                } else {
                    self.universityNameLabel.hidden = YES;
                    noInternetImageView.frame = CGRectMake(0, 22, 320, 500);
                    
                }
                
                
                self.sourceLabel.hidden = NO;
            }
            
        }];
        
    }
    else {
        NSLog(@"not first time load");
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableViewUniInfo.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    //  [headerView setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,0,tableViewUniInfo.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.text=@"Details:";
    
    [headerView addSubview:tempLabel];
    return headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UniInfoCustomCellView";
    
    UniInfoCustomCellView *cell = (UniInfoCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UniInfoCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.uniInfoTypeLabel.text = [self.uniInfoDataSets objectAtIndex:indexPath.row];
    cell.uniInfoTypeLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    cell.uniInfoTypeLabel.textAlignment = NSTextAlignmentLeft;
    cell.uniInfoTypeLabel.numberOfLines = 0;
    cell.imageViewUniInfo.frame = CGRectMake(220, 10, 80, 80);
    
    cell.imageViewUniInfo.image = [UIImage imageNamed:@"ui-17"];
    //NSLog(@"numbers: %@",self.uniInfoDataNumbers);
    
    cell.numberDataLabelUniInfo.text = [self.uniInfoDataNumbers objectAtIndex:indexPath.row];
    cell.numberDataLabelUniInfo.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    cell.numberDataLabelUniInfo.textAlignment = NSTextAlignmentCenter;
    cell.numberDataLabelUniInfo.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    
    
    
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
