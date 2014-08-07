//
//  CourseInfoCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseInfoCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "ContactUniversityPageViewController.h"

@interface CourseInfoCoursePageViewController ()

@end

@implementation CourseInfoCoursePageViewController

@synthesize uniCodeCourseInfo,courseCodeCourseInfo,commonJobs,commonJobsPercentages,commonJobsTableView,firstTimeLoad,courseInfoTableView,courseUrl,ucasCourseCode,averageTariffString,proportionInWork,instituteSalary,nationalSalary,scroll,degreeStatistics,assessmentMethods,timeSpent,uniNameCourseInfo,courseNameCourseInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Course Info", @"Course Info");
        self.tabBarItem.image = [UIImage imageNamed:@"info-32"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:scroll];
    //[scroll setContentSize:CGSizeMake(320, 2000)];
    scroll.showsHorizontalScrollIndicator = YES;
    scroll.scrollEnabled = YES;
    scroll.delegate = self;
    scroll.bounces = NO;
    scroll.userInteractionEnabled = YES;
    self.firstTimeLoad = YES;
    
    courseInfoTableView = [[UITableView alloc] init];
    courseInfoTableView.frame = CGRectMake(0, 90, 320, 2000);
    courseInfoTableView.delegate = self;
    courseInfoTableView.dataSource = self;
    courseInfoTableView.bounces = NO;
    courseInfoTableView.scrollEnabled = NO;
    courseInfoTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [scroll addSubview:courseInfoTableView];
    
    commonJobsTableView = [[UITableView alloc] init];
    commonJobsTableView.delegate = self;
    commonJobsTableView.dataSource = self;
    commonJobsTableView.bounces = NO;
    commonJobsTableView.scrollEnabled = NO;
    commonJobsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    
    [scroll addSubview:commonJobsTableView];
    
    
    
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.firstTimeLoad == YES) {
        
        NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        UILabel *universityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 320, 30)];
        universityNameLabel.text = self.uniNameCourseInfo;
        universityNameLabel.textAlignment = NSTextAlignmentCenter;
        universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [scroll addSubview:universityNameLabel];
        
        UILabel *courseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 320, 30)];
        courseNameLabel.text = self.courseNameCourseInfo;
        courseNameLabel.textAlignment = NSTextAlignmentCenter;
        courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        [scroll addSubview:courseNameLabel];
        
        // query for ucas course id/course url/year abroad/sandwich year
        PFQuery *queryKiscourse = [PFQuery queryWithClassName:@"Kiscourse"];
        [queryKiscourse whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryKiscourse selectKeys:[NSArray arrayWithObjects:@"CRSEURL",@"UCASCOURSEID",@"YEARABROAD",@"SANDWICH", nil]];
        PFObject *tempKiscourseObject = [queryKiscourse getFirstObject];
        courseUrl = [tempKiscourseObject valueForKey:@"CRSEURL"];
        if (courseUrl.length == 0) {
            courseUrl = @"N/A";
        }
        ucasCourseCode = [tempKiscourseObject valueForKey:@"UCASCOURSEID"];
        if (ucasCourseCode.length == 0) {
            ucasCourseCode = @"N/A";
        }
        UILabel *yearAbroadLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 320, 30)];
        yearAbroadLabel.textAlignment = NSTextAlignmentCenter;
        yearAbroadLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        yearAbroadLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [scroll addSubview:yearAbroadLabel];
        
        UILabel *yearIndustryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, 320, 30)];
        yearIndustryLabel.textAlignment = NSTextAlignmentCenter;
        yearIndustryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        yearIndustryLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [scroll addSubview:yearIndustryLabel];
        
        NSString *yearAbroad = [tempKiscourseObject valueForKey:@"YEARABROAD"];
        NSString *sandwichYear = [tempKiscourseObject valueForKey:@"SANDWICH"];
        if ([yearAbroad isEqualToString:@"1"]) {
            yearAbroadLabel.text = @"Year abroad optional";
        } else if ([yearAbroad isEqualToString:@"2"]) {
            yearAbroadLabel.text = @"Year abroad compulsory";
        } else {
            yearAbroadLabel.text = @"Year abroad not available";
        }
        
        if ([sandwichYear isEqualToString:@"1"]) {
            yearIndustryLabel.text = @"Year in industry optional";
        } else if ([sandwichYear isEqualToString:@"2"]) {
            yearIndustryLabel.text = @"Year in industry compulsory";
        } else {
            yearIndustryLabel.text = @"Year in industry not available";
        }
        
        // query for degree class
        PFQuery *queryDegreeClass = [PFQuery queryWithClassName:@"DegreeClass"];
        [queryDegreeClass whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryDegreeClass selectKeys:[NSArray arrayWithObjects:@"UFIRST",@"ULOWER",@"UNA",@"UORDINARY",@"UOTHER",@"UUPPER", nil]];
        PFObject *tempDegreeClassObject = [queryDegreeClass getFirstObject];
        NSString *degreeClassFirst = [tempDegreeClassObject valueForKey:@"UFIRST"];
        NSString *degreeClassUpperSecond = [tempDegreeClassObject valueForKey:@"UUPPER"];
        NSString *degreeClassLowerSecond = [tempDegreeClassObject valueForKey:@"ULOWER"];
        NSString *degreeClassOther = [tempDegreeClassObject valueForKey:@"UOTHER"];
        NSString *degreeClassOrdinary = [tempDegreeClassObject valueForKey:@"UORDINARY"];
        NSString *degreeClassNA = [tempDegreeClassObject valueForKey:@"UNA"];
        
        NSNumber *degreeClassFirstNumber = [f numberFromString:degreeClassFirst];
        NSNumber *degreeClassUpperSecondNumber = [f numberFromString:degreeClassUpperSecond];
        NSNumber *degreeClassLowerSecondNumber = [f numberFromString:degreeClassLowerSecond];
        NSNumber *degreeClassOtherNumber = [f numberFromString:degreeClassOther];
        NSNumber *degreeClassOrdinaryNumber = [f numberFromString:degreeClassOrdinary];
        NSNumber *degreeClassNANumber = [f numberFromString:degreeClassNA];
        self.degreeStatistics = [[NSMutableArray alloc] initWithObjects:degreeClassFirstNumber,degreeClassOtherNumber,degreeClassUpperSecondNumber,degreeClassOrdinaryNumber,degreeClassLowerSecondNumber,degreeClassNANumber, nil];

        
        
        // query for employment
        PFQuery *queryEmployment = [PFQuery queryWithClassName:@"Employment"];
        [queryEmployment whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryEmployment selectKeys:[NSArray arrayWithObjects:@"BOTH",@"ASSUNEMP",@"STUDY",@"WORK", nil]];
        PFObject *tempEmploymentObject = [queryEmployment getFirstObject];
        NSString *bothWorkAndStudy = [tempEmploymentObject valueForKey:@"BOTH"];
        NSString *workingOnly = [tempEmploymentObject valueForKey:@"WORK"];
        if (tempEmploymentObject == NULL) {
            self.proportionInWork = @"N/A";
        } else {
            NSNumber *workAndStudyNumber = [f numberFromString:bothWorkAndStudy];
            NSNumber *workOnlyNumber = [f numberFromString:workingOnly];
            workOnlyNumber = [NSNumber numberWithFloat:([workAndStudyNumber floatValue] + [workOnlyNumber floatValue])];
            self.proportionInWork = [workOnlyNumber stringValue];
            self.proportionInWork = [self.proportionInWork stringByAppendingString:@"%"];
        }
        
        //query for salary
        PFQuery *querySalary = [PFQuery queryWithClassName:@"Salary"];
        [querySalary whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [querySalary selectKeys:[NSArray arrayWithObjects:@"INSTMED",@"MED", nil]];
        PFObject *tempSalaryObject = [querySalary getFirstObject];
        if (tempSalaryObject == NULL) {
            instituteSalary = @"N/A";
            nationalSalary = @"N/A";
        } else {
        instituteSalary = [tempSalaryObject valueForKey:@"INSTMED"];
        nationalSalary = [tempSalaryObject valueForKey:@"MED"];
        }
        
        NSLog(@"SALARIES %@ and %@",instituteSalary,nationalSalary);
        
        // query for tariff
        PFQuery *queryTariff = [PFQuery queryWithClassName:@"Tariff"];
        [queryTariff whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryTariff selectKeys:[NSArray arrayWithObjects:@"T1",@"T120",@"T160",@"T200",@"T240",@"T280",@"T320",@"T360",@"T400",@"T440",@"T480",@"T520",@"T560",@"T600", nil]];
        PFObject *tempTariffObject = [queryTariff getFirstObject];
        if (tempTariffObject == NULL) {
            //NSLog(@"got here");
            averageTariffString = @"N/A";
        } else {
            
            NSNumber * t1 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
            NSNumber * t120 = [f numberFromString:[tempTariffObject valueForKey:@"T120"]];
            NSNumber * t160 = [f numberFromString:[tempTariffObject valueForKey:@"T160"]];
            NSNumber * t200 = [f numberFromString:[tempTariffObject valueForKey:@"T200"]];
            NSNumber * t240 = [f numberFromString:[tempTariffObject valueForKey:@"T240"]];
            NSNumber * t280 = [f numberFromString:[tempTariffObject valueForKey:@"T280"]];
            NSNumber * t320 = [f numberFromString:[tempTariffObject valueForKey:@"T320"]];
            NSNumber * t360 = [f numberFromString:[tempTariffObject valueForKey:@"T360"]];
            NSNumber * t400 = [f numberFromString:[tempTariffObject valueForKey:@"T400"]];
            NSNumber * t440 = [f numberFromString:[tempTariffObject valueForKey:@"T440"]];
            NSNumber * t480 = [f numberFromString:[tempTariffObject valueForKey:@"T480"]];
            NSNumber * t520 = [f numberFromString:[tempTariffObject valueForKey:@"T520"]];
            NSNumber * t560 = [f numberFromString:[tempTariffObject valueForKey:@"T560"]];
            NSNumber * t600 = [f numberFromString:[tempTariffObject valueForKey:@"T600"]];
            
            NSNumber *tt1 = [NSNumber numberWithFloat:([t1 floatValue] * 120)];
            NSNumber *tt120 = [NSNumber numberWithFloat:([t120 floatValue] * 140)];
            NSNumber *tt160 = [NSNumber numberWithFloat:([t160 floatValue] * 180)];
            NSNumber *tt200 = [NSNumber numberWithFloat:([t200 floatValue] * 220)];
            NSNumber *tt240 = [NSNumber numberWithFloat:([t240 floatValue] * 260)];
            NSNumber *tt280 = [NSNumber numberWithFloat:([t280 floatValue] * 300)];
            NSNumber *tt320 = [NSNumber numberWithFloat:([t320 floatValue] * 340)];
            NSNumber *tt360 = [NSNumber numberWithFloat:([t360 floatValue] * 380)];
            NSNumber *tt400 = [NSNumber numberWithFloat:([t400 floatValue] * 420)];
            NSNumber *tt440 = [NSNumber numberWithFloat:([t440 floatValue] * 460)];
            NSNumber *tt480 = [NSNumber numberWithFloat:([t480 floatValue] * 500)];
            NSNumber *tt520 = [NSNumber numberWithFloat:([t520 floatValue] * 540)];
            NSNumber *tt560 = [NSNumber numberWithFloat:([t560 floatValue] * 580)];
            NSNumber *tt600 = [NSNumber numberWithFloat:([t600 floatValue] * 600)];
            
            NSNumber *numberOfEntries = [NSNumber numberWithFloat:([t1 floatValue] + [t120 floatValue] + [t160 floatValue] + [t200 floatValue] + [t240 floatValue] + [t280 floatValue] + [t320 floatValue] + [t360 floatValue] + [t400 floatValue] + [t440 floatValue] + [t480 floatValue] + [t520 floatValue] + [t560 floatValue] + [t600 floatValue])];
            NSLog(@"numberofentries: %@",numberOfEntries);
            NSNumber *averageTariff = [NSNumber numberWithFloat:([tt1 floatValue] + [tt120 floatValue] + [tt160 floatValue] + [tt200 floatValue] + [tt240 floatValue] + [tt280 floatValue] + [tt320 floatValue] + [tt360 floatValue] + [tt400 floatValue] + [tt440 floatValue] + [tt480 floatValue] + [tt520 floatValue] + [tt560 floatValue] + [tt600 floatValue])];
            NSLog(@"average 1: %@",averageTariff);
            averageTariff = [NSNumber numberWithFloat:([averageTariff floatValue] / [numberOfEntries floatValue])];
            NSLog(@"average 2: %@",averageTariff);
            int privateRounded = lroundf([averageTariff floatValue]);
            averageTariffString = [NSString stringWithFormat:@"%d",privateRounded];
        }
        
        
        //query for jobs after graduation
        self.commonJobsPercentages = [[NSMutableArray alloc] init];
        self.commonJobs = [[NSMutableArray alloc] init];
        PFQuery *queryForGraduationJobs = [PFQuery queryWithClassName:@"Joblist"];
        [queryForGraduationJobs whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryForGraduationJobs selectKeys:[NSArray arrayWithObjects:@"JOB",@"ORDER",@"PERC", nil]];
        [queryForGraduationJobs orderByAscending:@"ORDER"];
        [queryForGraduationJobs setLimit:10];
        [queryForGraduationJobs findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            [self.commonJobs addObjectsFromArray:[objects valueForKey:@"JOB"]];
            [self.commonJobsPercentages addObjectsFromArray:[objects valueForKey:@"PERC"]];
            //  NSLog(@"common jobs perc: %@",self.commonJobsPercentages);
            if (objects.count == 0) {
                [self.commonJobs addObject:@"Sorry we appear to have no data"];
                [self.commonJobsPercentages addObject:@""];
                self.commonJobsTableView.frame = CGRectMake(0, 910, 320, 70);
                self.scroll.contentSize = CGSizeMake(320, 950 + self.commonJobsTableView.frame.size.height + self.tabBarController.tabBar.frame.size.height + 18);
            }
            else  {
                if (objects.count == 10) {
                    NSString *temp = [self.commonJobs objectAtIndex:1];
                    [self.commonJobs removeObjectAtIndex:1];
                    [self.commonJobs addObject:temp];
                    NSString *tempPerc = [self.commonJobsPercentages objectAtIndex:1];
                    [self.commonJobsPercentages removeObjectAtIndex:1];
                    [self.commonJobsPercentages addObject:tempPerc];
                }
                self.commonJobsTableView.frame = CGRectMake(0, 910, 320, 40 * objects.count + 70);
                self.scroll.contentSize = CGSizeMake(320, 910 + self.commonJobsTableView.frame.size.height + self.tabBarController.tabBar.frame.size.height + 18);
            }
            // NSLog(@"common jobs perc2: %@",self.commonJobsPercentages);
            [self.commonJobsTableView reloadData];
        }];
        
        // query for time spent/assessment methods
        PFQuery *queryCourseStage = [PFQuery queryWithClassName:@"CourseStage"];
        [queryCourseStage whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryCourseStage selectKeys:[NSArray arrayWithObjects:@"COURSEWORK",@"INDEPENDENT",@"PLACEMENT",@"PRACTICAL",@"SCHEDULED",@"STAGE",@"WRITTEN", nil]];
        [queryCourseStage orderByAscending:@"STAGE"];
        [queryCourseStage findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            NSLog(@"count: %d",objects.count);
            if (objects.count==0) {
                // do something for no data
            } else {
                // assessment in written/practical/coursework
                NSArray *courseworkPercentages= [objects valueForKey:@"COURSEWORK"];
                NSArray *practicalPercentages = [objects valueForKey:@"PRACTICAL"];
                NSArray *writtenPercentages = [objects valueForKey:@"WRITTEN"];
                NSNumber *sumOfCourseworkPercentages = [courseworkPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *sumOfPracticalPercentages = [practicalPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *sumOfWrittenPercentages = [writtenPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *averageCoursework = [NSNumber numberWithFloat:([sumOfCourseworkPercentages floatValue] / objects.count)];
                NSNumber *averagePractical = [NSNumber numberWithFloat:([sumOfPracticalPercentages floatValue] / objects.count)];
                NSNumber *averageWritten = [NSNumber numberWithFloat:([sumOfWrittenPercentages floatValue] / objects.count)];
                NSLog(@"array: %@, sum: %@,average: %@",averagePractical,averageWritten,averageCoursework);
                self.assessmentMethods = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:averageWritten,averageCoursework,averagePractical, nil]];
                
                // time spent in independent study/placements/scheduled learning
                NSArray *independentStudyPercentages= [objects valueForKey:@"INDEPENDENT"];
                NSArray *placementPercentages = [objects valueForKey:@"PLACEMENT"];
                NSArray *scheduledPercentages = [objects valueForKey:@"SCHEDULED"];
                NSNumber *sumOfIndependentStudyPercentages = [independentStudyPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *sumOfPlacementPercentages = [placementPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *sumOfScheduledPercentages = [scheduledPercentages valueForKeyPath:@"@sum.self"];
                NSNumber *averageIndependentStudy = [NSNumber numberWithFloat:([sumOfIndependentStudyPercentages floatValue] / objects.count)];
                NSNumber *averagePlacement = [NSNumber numberWithFloat:([sumOfPlacementPercentages floatValue] / objects.count)];
                NSNumber *averageScheduled = [NSNumber numberWithFloat:([sumOfScheduledPercentages floatValue] / objects.count)];
                NSLog(@"array: %@, sum: %@,average: %@",averageIndependentStudy,averagePlacement,averageScheduled);
                self.timeSpent = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:averageIndependentStudy,averagePlacement,averageScheduled, nil]];
                
            }
            [self.courseInfoTableView reloadData];
        }];
        self.firstTimeLoad = NO;
    }
    else {
        
    }
    
    
    
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.commonJobsTableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, commonJobsTableView.bounds.size.width, 30)];
        
        [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,0,commonJobsTableView.bounds.size.width,22)];
        
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.text=@"Common Jobs For Graduates:";
        
        [headerView addSubview:tempLabel];
        return headerView;
    }
    else if (tableView == self.courseInfoTableView){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, courseInfoTableView.bounds.size.width, 30)];
        
        [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,courseInfoTableView.bounds.size.width,22)];
        
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.text=@"Details:";
        
        [headerView addSubview:tempLabel];
        return headerView;
    } else {
        return NULL;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.commonJobsTableView) {
        return self.commonJobs.count;
    } else {
        return 8;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.commonJobsTableView) {
        static NSString *cellIdentifier = @"CommonJobsCustomCellView";
        
        CommonJobsCustomCellView *cell = (CommonJobsCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommonJobsCustomCellView" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.percentageLabel.textAlignment = NSTextAlignmentLeft;
        cell.percentageLabel.text = [NSString stringWithFormat:@"%@%%",[self.commonJobsPercentages objectAtIndex:indexPath.row]];
        cell.percentageLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        cell.percentageLabel.font = [UIFont fontWithName:@"Arial" size:18];
        
        cell.jobLabel.text = [self.commonJobs objectAtIndex:indexPath.row];
        cell.jobLabel.font = [UIFont fontWithName:@"Arial" size:13];
        cell.jobLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        cell.jobLabel.textAlignment = NSTextAlignmentRight;
        cell.jobLabel.numberOfLines = 0;
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        return cell;
    } else if (tableView == self.courseInfoTableView) {
        
        static NSString *cellIdentifier = @"CourseInfoTextCustomCellView";
        static NSString *cellImageIdentifier = @"UniInfoCustomCellView";
        static NSString *cellPieIdentifier = @"CourseInfoPieCustomCellView";
        static NSString *cellSalaryIdentifier = @"CourseInfoSalaryCustomCellView";
        
        
        CourseInfoTextCustomCellView *cellText = (CourseInfoTextCustomCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UniInfoCustomCellView *cellImage = (UniInfoCustomCellView*)[tableView dequeueReusableCellWithIdentifier:cellImageIdentifier];
        CourseInfoPieCustomCellView *cellPie = (CourseInfoPieCustomCellView*)[tableView dequeueReusableCellWithIdentifier:cellPieIdentifier];
        CourseInfoSalaryCustomCellView *cellSalary = (CourseInfoSalaryCustomCellView*)[tableView dequeueReusableCellWithIdentifier:cellSalaryIdentifier];
        
        if (cellText == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoTextCustomCellView" owner:self options:nil];
            cellText = [nib objectAtIndex:0];
        }
        if (cellImage == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UniInfoCustomCellView" owner:self options:nil];
            cellImage = [nib objectAtIndex:0];
        }
        if (cellPie == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoPieCustomCellView" owner:self options:nil];
            cellPie = [nib objectAtIndex:0];
        }
        if (cellSalary == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseInfoSalaryCustomCellView" owner:self options:nil];
            cellSalary = [nib objectAtIndex:0];
        }
        cellPie.legendTitles = [[NSMutableArray alloc] init];
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            cellText.textCellLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellText.textCellLabel.font = [UIFont fontWithName:@"Arial" size:14];
            if (indexPath.row == 0) {
                cellText.textCellLabel.text = @"UCAS Course Code:";
                cellText.textCellDataLabel.text = self.ucasCourseCode;
            } else if (indexPath.row == 1) {
                cellText.textCellLabel.text = @"Course URL:";
                cellText.textCellDataLabel.text = self.courseUrl;
                cellText.textCellDataLabel.numberOfLines = 0;
                cellText.textCellDataLabel.font = [UIFont fontWithName:@"Arial" size:10];
            }
            cellText.selectionStyle = UITableViewCellSelectionStyleNone;
            cellText.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellText.textCellLabel.textAlignment = NSTextAlignmentLeft;
            
            cellText.textCellDataLabel.textAlignment = NSTextAlignmentRight;
            cellText.textCellDataLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            
            return cellText;
        }
        
        else if (indexPath.row == 3 || indexPath.row == 6) {
            
            cellImage.imageViewUniInfo.image = [UIImage imageNamed:@"ui-17"];
            cellImage.uniInfoTypeLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellImage.uniInfoTypeLabel.textAlignment = NSTextAlignmentLeft;
            cellImage.uniInfoTypeLabel.font = [UIFont fontWithName:@"Arial" size:14];
            cellImage.uniInfoTypeLabel.numberOfLines = 0;
            cellImage.imageViewUniInfo.frame = CGRectMake(220, 10, 80, 80);
            
            cellImage.numberDataLabelUniInfo.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            cellImage.numberDataLabelUniInfo.textAlignment = NSTextAlignmentCenter;
            cellImage.numberDataLabelUniInfo.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
            cellImage.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellImage.selectionStyle = UITableViewCellSelectionStyleNone;

            
            if (indexPath.row == 3) {
                cellImage.uniInfoTypeLabel.text = @"Average tariff points of entrants:";
                cellImage.numberDataLabelUniInfo.text = self.averageTariffString;
            }
            if (indexPath.row == 6) {
                cellImage.uniInfoTypeLabel.text = @"Proportion of students employed after 6 months:";
                cellImage.numberDataLabelUniInfo.text = self.proportionInWork;
            }
            
            
            return cellImage;
        }
        
        else if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
            
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:14];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellPie.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row == 2) {
                cellPie.cellTitleLabel.text = @"Degree classes obtained:";
                //cellPie.legendTitles = [[NSMutableArray alloc] initWithObjects:@"1st",@"Upper 2nd",@"Lower 2nd",@"Other",@"Ordinary",@"N/A", nil];
                [cellPie.legendTitles removeAllObjects];
                [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"First",@"Other",@"Upper Second",@"Ordinary",@"Lower Second",@"N/A", nil]];
                cellPie.sectionData = self.degreeStatistics;
                cellPie.legendPoint = CGPointMake(-148, 18.0);
                cellPie.whichPieChart = 1;
            }
            if (indexPath.row == 4) {
                cellPie.cellTitleLabel.text = @"Assessment methods breakdown:";
                //cellPie.legendTitles = [[NSMutableArray alloc] initWithObjects:@"Written",@"Coursework",@"Practical", nil];
                [cellPie.legendTitles removeAllObjects];
                [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Written",@"Coursework",@"Practical", nil]];
                cellPie.sectionData = self.assessmentMethods;
                cellPie.legendPoint = CGPointMake(-155, 40);
                cellPie.whichPieChart = 2;
            }
            if (indexPath.row == 5) {
                cellPie.cellTitleLabel.text = @"Learning time breakdown:";
                //cellPie.legendTitles = [[NSMutableArray alloc] initWithObjects:@"Independent",@"Placements",@"Scheduled", nil];
                [cellPie.legendTitles removeAllObjects];
                [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Independent",@"Placements",@"Scheduled", nil]];
                cellPie.sectionData = self.timeSpent;
                cellPie.legendPoint = CGPointMake(-146, 40);
                cellPie.whichPieChart = 3;
            }
            
            return cellPie;
        }
        
        else if (indexPath.row == 7) {
            cellSalary.centreLabel.text = @"Average salary 6 months after graduating";
            cellSalary.centreLabel.numberOfLines = 0;
            cellSalary.centreLabel.font = [UIFont fontWithName:@"Arial" size:14];
            cellSalary.imageViewLeft.image = [UIImage imageNamed:@"ui-17"];
            cellSalary.imageViewRight.image = [UIImage imageNamed:@"ui-17"];
            cellSalary.centreLabel.textAlignment = NSTextAlignmentCenter;
            cellSalary.centreLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellSalary.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellSalary.leftLabel.text = @"Course";
            cellSalary.rightLabel.text = @"UK";
            cellSalary.leftLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellSalary.rightLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellSalary.leftLabel.textAlignment = NSTextAlignmentCenter;
            cellSalary.rightLabel.textAlignment = NSTextAlignmentCenter;
            
            cellSalary.leftDataLabel.textAlignment = NSTextAlignmentCenter;
            cellSalary.rightDataLabel.textAlignment = NSTextAlignmentCenter;
            cellSalary.leftDataLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            cellSalary.rightDataLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            cellSalary.leftDataLabel.text = [NSString stringWithFormat:@"£%@",self.instituteSalary];
            cellSalary.rightDataLabel.text = [NSString stringWithFormat:@"£%@",self.nationalSalary];
            cellSalary.leftDataLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
            cellSalary.rightDataLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
            cellSalary.selectionStyle = UITableViewCellSelectionStyleNone;

            return cellSalary;

        }
        
        
    }
    
    
    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.commonJobsTableView) {
        return 40;
    }
    else if (tableView == self.courseInfoTableView) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            return 40;
        }
        else if (indexPath.row == 3 || indexPath.row == 6) {
            return 100;
        }
        else if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 7) {
            return 130;
        }
    }
    return 40;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
