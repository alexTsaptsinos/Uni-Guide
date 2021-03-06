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

@synthesize uniCodeCourseInfo,courseCodeCourseInfo,commonJobs,commonJobsPercentages,firstTimeLoad,courseInfoTableView,courseUrl,ucasCourseCode,averageTariffString,proportionInWork,instituteSalary,nationalSalary,degreeStatistics,assessmentMethods,timeSpent,uniNameCourseInfo,courseNameCourseInfo,universityNameLabel,courseNameLabel,yearAbroad,sandwichYear,favouritesButton,activityIndicator,haveComeFromFavourites,noInternetImageView,noInternetLabel,sourceLabel,isItFavourite,favouritesPopoverButton,comparePopoverButton,isInMiddleOfFavouriteSave,isInMiddleOfCompareSave,popoverController,replaceSecondButton,replaceFirstButton;

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
    
    self.universityNameLabel.hidden = YES;
    self.courseNameLabel.hidden = YES;
    self.sourceLabel.hidden = YES;
    
    self.firstTimeLoad = YES;
    
    courseInfoTableView = [[UITableView alloc] init];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    NSLog(@"tab bar height: %f and screen height: %f",self.tabBarController.tabBar.frame.size.height, screenBound.size.height);
    courseInfoTableView.frame = CGRectMake(0, 80, screenBound.size.width, screenBound.size.height - 80 - self.tabBarController.tabBar.frame.size.height - 64);
    courseInfoTableView.delegate = self;
    courseInfoTableView.dataSource = self;
    courseInfoTableView.bounces = YES;
    courseInfoTableView.scrollEnabled = YES;
    courseInfoTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:courseInfoTableView];
    courseInfoTableView.hidden = YES;
    [self.activityIndicator startAnimating];
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"coursecode1: %@ and unicode1: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
    NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
    
    if (temp2.count == 0) {
        
        self.noInternetLabel.hidden = YES;
        self.noInternetImageView.hidden = YES;
        
        
        if (self.firstTimeLoad == YES) {
            
            NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            
            universityNameLabel.frame = CGRectMake(0, -5, 320, 30);
            universityNameLabel.text = self.uniNameCourseInfo;
            universityNameLabel.textAlignment = NSTextAlignmentCenter;
            universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
            
            courseNameLabel.frame = CGRectMake(0, 15, 320, 30);
            courseNameLabel.text = self.courseNameCourseInfo;
            courseNameLabel.textAlignment = NSTextAlignmentCenter;
            courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
            courseNameLabel.adjustsFontSizeToFitWidth = YES;
            courseNameLabel.numberOfLines = 0;
            
            // query for ucas course id/course url/year abroad/sandwich year
            PFQuery *queryKiscourse = [PFQuery queryWithClassName:@"Kiscourse"];
            [queryKiscourse whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
            [queryKiscourse whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
            [queryKiscourse selectKeys:[NSArray arrayWithObjects:@"CRSEURL",@"YEARABROAD",@"SANDWICH", nil]];
            [queryKiscourse findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                if (!error) {
                    NSArray *tempKiscourseObject = [objects objectAtIndex:0];
                    courseUrl = [tempKiscourseObject valueForKey:@"CRSEURL"];
                    if (courseUrl.length == 0) {
                        courseUrl = @"N/A";
                    }
//                    ucasCourseCode = [tempKiscourseObject valueForKey:@"UCASCOURSEID"];
//                    if (ucasCourseCode.length == 0) {
//                        ucasCourseCode = @"N/A";
//                    }
                    UILabel *yearAbroadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 320, 30)];
                    yearAbroadLabel.textAlignment = NSTextAlignmentCenter;
                    yearAbroadLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                    yearAbroadLabel.font = [UIFont fontWithName:@"Arial" size:12];
                    yearAbroadLabel.hidden = YES;
                    [self.view addSubview:yearAbroadLabel];
                    
                    UILabel *yearIndustryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, 320, 30)];
                    yearIndustryLabel.textAlignment = NSTextAlignmentCenter;
                    yearIndustryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                    yearIndustryLabel.font = [UIFont fontWithName:@"Arial" size:12];
                    yearIndustryLabel.hidden = YES;
                    [self.view addSubview:yearIndustryLabel];
                    
                    self.yearAbroad = [tempKiscourseObject valueForKey:@"YEARABROAD"];
                    self.sandwichYear = [tempKiscourseObject valueForKey:@"SANDWICH"];
                    if ([self.yearAbroad isEqualToString:@"1"]) {
                        yearAbroadLabel.text = @"Year abroad optional";
                    } else if ([self.yearAbroad isEqualToString:@"2"]) {
                        yearAbroadLabel.text = @"Year abroad compulsory";
                    } else {
                        yearAbroadLabel.text = @"Year abroad not available";
                    }
                    
                    if ([self.sandwichYear isEqualToString:@"1"]) {
                        yearIndustryLabel.text = @"Year in industry optional";
                    } else if ([self.sandwichYear isEqualToString:@"2"]) {
                        yearIndustryLabel.text = @"Year in industry compulsory";
                    } else {
                        yearIndustryLabel.text = @"Year in industry not available";
                    }
                    
                    // query for degree class
                    PFQuery *queryDegreeClass = [PFQuery queryWithClassName:@"DegreeClass"];
                    [queryDegreeClass whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
                    [queryDegreeClass whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                    [queryEmployment whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                    [querySalary whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                    [querySalary selectKeys:[NSArray arrayWithObjects:@"INSTMED",@"MED", nil]];
                    PFObject *tempSalaryObject = [querySalary getFirstObject];
                    if (tempSalaryObject == NULL) {
                        instituteSalary = @"N/A";
                        nationalSalary = @"N/A";
                    } else {
                        instituteSalary = [tempSalaryObject valueForKey:@"INSTMED"];
                        nationalSalary = [tempSalaryObject valueForKey:@"MED"];
                    }
                    
                    //NSLog(@"SALARIES %@ and %@",instituteSalary,nationalSalary);
                    
                    // query for tariff
                    PFQuery *queryTariff = [PFQuery queryWithClassName:@"Tariff"];
                    [queryTariff whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
                    [queryTariff whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                        NSUInteger privateRounded = lroundf([averageTariff floatValue]);
                        averageTariffString = [NSString stringWithFormat:@"%lu",(unsigned long)privateRounded];
                    }
                    
                    
                    //query for jobs after graduation
                    self.commonJobsPercentages = [[NSMutableArray alloc] init];
                    self.commonJobs = [[NSMutableArray alloc] init];
                    PFQuery *queryForGraduationJobs = [PFQuery queryWithClassName:@"Joblist"];
                    [queryForGraduationJobs whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
                    [queryForGraduationJobs whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                    [queryForGraduationJobs selectKeys:[NSArray arrayWithObjects:@"JOB",@"ORDER",@"PERC", nil]];
                    [queryForGraduationJobs orderByAscending:@"ORDER"];
                    [queryForGraduationJobs setLimit:10];
                    [queryForGraduationJobs findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                        if (error != nil) {
                            UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [noInternetAlert show];
                        } else {
                            [self.commonJobs addObjectsFromArray:[objects valueForKey:@"JOB"]];
                            [self.commonJobsPercentages addObjectsFromArray:[objects valueForKey:@"PERC"]];
                            //  NSLog(@"common jobs perc: %@",self.commonJobsPercentages);
                            if (objects.count == 0) {
                                [self.commonJobs addObject:@"Sorry we appear to have no data"];
                                [self.commonJobsPercentages addObject:@""];
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
                                NSNumber *totalTemp = [NSNumber numberWithFloat:0];
                                NSUInteger i;

                                for (i=0; i<self.commonJobsPercentages.count; i++) {
                                    //NSLog(@"common jobs perc2: %@",self.commonJobsPercentages);

                                    NSString *tempNumberString = [self.commonJobsPercentages objectAtIndex:i];
                                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                                    f.numberStyle = NSNumberFormatterDecimalStyle;
                                    NSNumber *tempNumber = [f numberFromString:tempNumberString];
                                    totalTemp = [NSNumber numberWithFloat:[totalTemp floatValue] + [tempNumber floatValue]];
                                    NSLog(@"i value: %lu: and total: %@",(unsigned long)i,totalTemp);

                                    if ([totalTemp isEqualToNumber:[NSNumber numberWithFloat:100.0f]]) {
                                        i = i+1;
                                        NSArray *tempArray = [self.commonJobs objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobs removeAllObjects];
                                        [self.commonJobs addObjectsFromArray:tempArray];
                                        
                                        NSArray *tempArray2 = [self.commonJobsPercentages objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobsPercentages removeAllObjects];
                                        [self.commonJobsPercentages addObjectsFromArray:tempArray2];
                                    } else if ([totalTemp isGreaterThan:[NSNumber numberWithFloat:100.0f]]) {
                                        NSArray *tempArray = [self.commonJobs objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobs removeAllObjects];
                                        [self.commonJobs addObjectsFromArray:tempArray];
                                        
                                        NSArray *tempArray2 = [self.commonJobsPercentages objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobsPercentages removeAllObjects];
                                        [self.commonJobsPercentages addObjectsFromArray:tempArray2];
                                    } else if ([tempNumber isEqualToNumber:[NSNumber numberWithFloat:0.0f]]) {
                                        NSArray *tempArray = [self.commonJobs objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobs removeAllObjects];
                                        [self.commonJobs addObjectsFromArray:tempArray];
                                        
                                        NSArray *tempArray2 = [self.commonJobsPercentages objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, i)]];
                                        [self.commonJobsPercentages removeAllObjects];
                                        [self.commonJobsPercentages addObjectsFromArray:tempArray2];
                                    }
                                    
                                }
                            }
                            [self.courseInfoTableView reloadData];
                        }
                    }];
                    
                    // query for time spent/assessment methods
                    PFQuery *queryCourseStage = [PFQuery queryWithClassName:@"CourseStage"];
                    [queryCourseStage whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
                    [queryCourseStage whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                    [queryCourseStage selectKeys:[NSArray arrayWithObjects:@"COURSEWORK",@"INDEPENDENT",@"PLACEMENT",@"PRACTICAL",@"SCHEDULED",@"STAGE",@"WRITTEN", nil]];
                    [queryCourseStage orderByAscending:@"STAGE"];
                    [queryCourseStage findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                        if (error != nil) {
                            UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [noInternetAlert show];
                        } else {
                            //NSLog(@"count: %d",objects.count);
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
                                // NSLog(@"array: %@, sum: %@,average: %@",averagePractical,averageWritten,averageCoursework);
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
                                //  NSLog(@"array: %@, sum: %@,average: %@",averageIndependentStudy,averagePlacement,averageScheduled);
                                self.timeSpent = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:averageIndependentStudy,averagePlacement,averageScheduled, nil]];
                                
                            }
                            [self.courseInfoTableView reloadData];
                            self.courseInfoTableView.hidden = NO;
                            self.courseNameLabel.hidden = NO;
                            self.universityNameLabel.hidden = NO;
                            self.sourceLabel.hidden = NO;
                            yearAbroadLabel.hidden = NO;
                            yearIndustryLabel.hidden = NO;
                        }
                    }];
                    self.firstTimeLoad = NO;
                }
                else {
                    NSLog(@"error");
                    self.universityNameLabel.hidden = NO;
                    self.courseNameLabel.hidden = NO;
                    self.sourceLabel.hidden = NO;
                    self.courseInfoTableView.hidden = YES;
                    
                    universityNameLabel.frame = CGRectMake(0, -5, 320, 30);
                    universityNameLabel.text = self.uniNameCourseInfo;
                    universityNameLabel.textAlignment = NSTextAlignmentCenter;
                    universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                    universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
                    
                    courseNameLabel.frame = CGRectMake(0, 15, 320, 30);
                    courseNameLabel.text = self.courseNameCourseInfo;
                    courseNameLabel.textAlignment = NSTextAlignmentCenter;
                    courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
                    courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                    courseNameLabel.adjustsFontSizeToFitWidth = YES;
                    courseNameLabel.numberOfLines = 0;
                    
                    noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 429)];
                    noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                    noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                    noInternetLabel.text = @"We're sorry, but this data is not available offline";
                    noInternetLabel.numberOfLines = 0;
                    noInternetLabel.textAlignment = NSTextAlignmentCenter;
                    [noInternetImageView addSubview:noInternetLabel];
                    [self.view addSubview:noInternetImageView];
                }
                
                [self.activityIndicator stopAnimating];
            }];
        }
    }
    else if (self.firstTimeLoad == YES)
    {
        //NSLog(@"here");
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
        
        // NSLog(@"object: %@",temp2);
        
        universityNameLabel.frame = CGRectMake(0, -5, 320, 30);
        universityNameLabel.text = self.uniNameCourseInfo;
        universityNameLabel.textAlignment = NSTextAlignmentCenter;
        universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        
        courseNameLabel.frame = CGRectMake(0, 15, 320, 30);
        courseNameLabel.text = self.courseNameCourseInfo;
        courseNameLabel.textAlignment = NSTextAlignmentCenter;
        courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        courseNameLabel.adjustsFontSizeToFitWidth = YES;
        courseNameLabel.numberOfLines = 0;
        
        Favourites *tempObject = [temp2 objectAtIndex:0];
        
        //   NSLog(@"temp object: %@",tempObject);
        
        //self.ucasCourseCode = tempObject.ucasCode;
        self.courseUrl = tempObject.courseUrl;
        self.yearAbroad = tempObject.yearAbroad;
        self.sandwichYear = tempObject.sandwichYear;
        self.degreeStatistics = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.degreeClasses]];
        self.averageTariffString = tempObject.averageTariffString;
        self.assessmentMethods = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.assessmentMethods]];
        self.timeSpent = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.timeSpent]];
        self.proportionInWork = tempObject.proportionInWork;
        self.commonJobs = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.commonJobs]];
        self.commonJobsPercentages = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.commonJobsPercentages]];
        if (self.commonJobs.count == 0) {
            [self.commonJobs addObject:@"Sorry we appear to have no data"];
            [self.commonJobsPercentages addObject:@""];
        }
        self.instituteSalary = tempObject.instituteSalary;
        self.nationalSalary = tempObject.nationalSalary;
        
        UILabel *yearAbroadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 42, 320, 30)];
        yearAbroadLabel.textAlignment = NSTextAlignmentCenter;
        yearAbroadLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        yearAbroadLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.view addSubview:yearAbroadLabel];
        
        UILabel *yearIndustryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, 320, 30)];
        yearIndustryLabel.textAlignment = NSTextAlignmentCenter;
        yearIndustryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        yearIndustryLabel.font = [UIFont fontWithName:@"Arial" size:12];
        [self.view addSubview:yearIndustryLabel];
        
        if ([self.yearAbroad isEqualToString:@"1"]) {
            yearAbroadLabel.text = @"Year abroad optional";
        } else if ([self.yearAbroad isEqualToString:@"2"]) {
            yearAbroadLabel.text = @"Year abroad compulsory";
        } else {
            yearAbroadLabel.text = @"Year abroad not available";
        }
        
        if ([self.sandwichYear isEqualToString:@"1"]) {
            yearIndustryLabel.text = @"Year in industry optional";
        } else if ([self.sandwichYear isEqualToString:@"2"]) {
            yearIndustryLabel.text = @"Year in industry compulsory";
        } else {
            yearIndustryLabel.text = @"Year in industry not available";
        }
        
        [self.courseInfoTableView reloadData];
        self.courseInfoTableView.hidden = NO;
        self.courseNameLabel.hidden = NO;
        self.sourceLabel.hidden = NO;
        self.universityNameLabel.hidden = NO;
        [self.activityIndicator stopAnimating];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, courseInfoTableView.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,courseInfoTableView.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    if (section == 0) {
        tempLabel.text=@"Details:";
    } else {
        tempLabel.text = @"Common Jobs For Graduates:";
    }
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    } else {
        return self.commonJobs.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *cellIdentifierJobs = @"CommonJobsCustomCellView";
        
        CommonJobsCustomCellView *cell = (CommonJobsCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierJobs];
        
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
        cell.jobLabel.frame = CGRectMake(82, 4, 228, 35);
        cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
        cell.isCompare = NO;
        return cell;
    } else if (indexPath.section == 0) {
        
        NSString *cellIdentifier = [NSString stringWithFormat:@"CourseInfoTextCustomCellView%li", (long)indexPath.row];
        NSString *cellImageIdentifier = [NSString stringWithFormat:@"UniInfoCustomCellView%li", (long)indexPath.row];
        NSString *cellPieIdentifier = [NSString stringWithFormat:@"CourseInfoPieCustomCellView%li", (long)indexPath.row];
        NSString *cellSalaryIdentifier = [NSString stringWithFormat:@"CourseInfoSalaryCustomCellView%li", (long)indexPath.row];

//        static NSString *cellImageIdentifier = @"UniInfoCustomCellView";
//        static NSString *cellPieIdentifier = @"CourseInfoPieCustomCellView";
//        static NSString *cellSalaryIdentifier = @"CourseInfoSalaryCustomCellView";
        
        
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
        
        if (indexPath.row == 0) {
            cellText.textCellLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellText.textCellLabel.font = [UIFont fontWithName:@"Arial" size:14];

                cellText.textCellLabel.text = @"Course URL:";
                
                [cellText.textCellDataButton setTitle:self.courseUrl forState:UIControlStateNormal];
                cellText.textCellDataButton.titleLabel.text = self.courseUrl;
                cellText.textCellDataButton.titleLabel.numberOfLines = 3;
                cellText.textCellDataButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:10];
                [cellText.textCellDataButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
                [cellText.textCellDataButton setTitleColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
                [cellText.textCellDataButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateDisabled];
                
          //  }
            cellText.selectionStyle = UITableViewCellSelectionStyleNone;
            cellText.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellText.textCellLabel.textAlignment = NSTextAlignmentLeft;
            
            cellText.textCellDataButton.titleLabel.textAlignment = NSTextAlignmentRight;
            cellText.textCellDataButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            
            return cellText;
        }
        
        else if (indexPath.row == 2 || indexPath.row == 5) {
            
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
            
            
            if (indexPath.row == 2) {
                cellImage.numberDataLabelUniInfo.text = self.averageTariffString;
                cellImage.uniInfoTypeLabel.hidden = YES;
                UILabel *cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 183, 67)];
                cellTitleLabel.text = @"Average UCAS tariff points of entrants:";
                cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                cellTitleLabel.textAlignment = NSTextAlignmentLeft;
                cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:14];
                cellTitleLabel.numberOfLines = 0;
                [cellImage addSubview:cellTitleLabel];
                
                UILabel *equivalentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 200, 40)];
                equivalentLabel.font = [UIFont fontWithName:@"Arial" size:12];
                equivalentLabel.textAlignment = NSTextAlignmentLeft;
                equivalentLabel.numberOfLines = 0;
                equivalentLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
                
                // only show equivalent label if we have the tariff data
                
                if ([self.averageTariffString isEqualToString:@"N/A"]) {
                    equivalentLabel.hidden = YES;
                } else {
                    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                    [f setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    NSNumber *averageTariff = [f numberFromString:self.averageTariffString];
                    float averageTariffFloat = [averageTariff floatValue];
                    
                    
                    if (averageTariffFloat < 120.0f) {
                        equivalentLabel.text = @"This is equivalent to less than EEE";
                    }
                    else if (averageTariffFloat > 120.0f && averageTariffFloat < 140.0f) {
                        equivalentLabel.text = @"This is equivalent to EEE";
                    }
                    else if (averageTariffFloat > 140.0f && averageTariffFloat < 160.0f) {
                        equivalentLabel.text = @"This is equivalent to DEE";
                    }
                    else if (averageTariffFloat > 160.0f && averageTariffFloat < 180.0f) {
                        equivalentLabel.text = @"This is equivalent to DDE";
                    }
                    else if (averageTariffFloat > 180.0f && averageTariffFloat < 200.0f) {
                        equivalentLabel.text = @"This is equivalent to DDD";
                    }
                    else if (averageTariffFloat > 200.0f && averageTariffFloat < 220.0f) {
                        equivalentLabel.text = @"This is equivalent to CDD";
                    }
                    else if (averageTariffFloat > 220.0f && averageTariffFloat < 240.0f) {
                        equivalentLabel.text = @"This is equivalent to CCD";
                    }
                    else if (averageTariffFloat > 240.0f && averageTariffFloat < 260.0f) {
                        equivalentLabel.text = @"This is equivalent to CCC";
                    }
                    else if (averageTariffFloat > 260.0f && averageTariffFloat < 280.0f) {
                        equivalentLabel.text = @"This is equivalent to BCC";
                    }
                    else if (averageTariffFloat > 280.0f && averageTariffFloat < 300.0f) {
                        equivalentLabel.text = @"This is equivalent to BBC";
                    }
                    else if (averageTariffFloat > 300.0f && averageTariffFloat < 320.0f) {
                        equivalentLabel.text = @"This is equivalent to BBB";
                    }
                    else if (averageTariffFloat > 320.0f && averageTariffFloat < 340.0f) {
                        equivalentLabel.text = @"This is equivalent to ABB";
                    }
                    else if (averageTariffFloat > 340.0f && averageTariffFloat < 360.0f) {
                        equivalentLabel.text = @"This is equivalent to AAB";
                    }
                    else if (averageTariffFloat > 360.0f && averageTariffFloat < 380.0f) {
                        equivalentLabel.text = @"This is equivalent to AAA";
                    }
                    else if (averageTariffFloat > 380.0f && averageTariffFloat < 400.0f) {
                        equivalentLabel.text = @"This is equivalent to A*AA";
                    }
                    else if (averageTariffFloat > 400.0f && averageTariffFloat < 420.0f) {
                        equivalentLabel.text = @"This is equivalent to A*A*A";
                    }
                    else if (averageTariffFloat > 420.0f) {
                        equivalentLabel.text = @"This is equivalent to greater than A*A*A*";
                    }
                    
                    [cellImage addSubview:equivalentLabel];
                }
            }
            if (indexPath.row == 5) {
                cellImage.uniInfoTypeLabel.text = @"Proportion of students employed after 6 months:";
                cellImage.numberDataLabelUniInfo.text = self.proportionInWork;
            }
            
            
            return cellImage;
        }
        
        else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
            
            cellPie.cellTitleLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
            cellPie.cellTitleLabel.textAlignment = NSTextAlignmentLeft;
            cellPie.cellTitleLabel.font = [UIFont fontWithName:@"Arial" size:14];
            cellPie.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            cellPie.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row == 1) {
                cellPie.cellTitleLabel.text = @"Degree classes obtained:";
                //cellPie.legendTitles = [[NSMutableArray alloc] initWithObjects:@"1st",@"Upper 2nd",@"Lower 2nd",@"Other",@"Ordinary",@"N/A", nil];
                [cellPie.legendTitles removeAllObjects];
                [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"First",@"Other",@"Upper Second",@"Ordinary",@"Lower Second",@"N/A", nil]];
                cellPie.sectionData = self.degreeStatistics;
                NSLog(@"ASOFASD: %@",self.degreeStatistics);
                cellPie.legendPoint = CGPointMake(-148, 18.0);
                cellPie.whichPieChart = 1;
            }
            if (indexPath.row == 3) {
                cellPie.cellTitleLabel.text = @"Assessment methods breakdown:";
                //cellPie.legendTitles = [[NSMutableArray alloc] initWithObjects:@"Written",@"Coursework",@"Practical", nil];
                [cellPie.legendTitles removeAllObjects];
                [cellPie.legendTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Written",@"Coursework",@"Practical", nil]];
                cellPie.sectionData = self.assessmentMethods;
                cellPie.legendPoint = CGPointMake(-155, 40);
                cellPie.whichPieChart = 2;
            }
            if (indexPath.row == 4) {
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
        
        else if (indexPath.row == 6) {
            cellSalary.centreLabel.text = @"Average salary for subject 6 months after graduating:";
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
    if (indexPath.section == 1) {
        return 40;
    }
    else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }
        else if (indexPath.row == 2 || indexPath.row == 5) {
            return 100;
        }
        else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6) {
            return 130;
        }
    }
    return 40;
}

-(void) customBtnPressed
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    
    popoverController = [[ARSPopover alloc] init];
    popoverController.sourceView = self.navigationController.visibleViewController.view;
    popoverController.sourceRect = CGRectMake(widthFloat-36, -5, 0, 0);
    popoverController.contentSize = CGSizeMake(widthFloat-10, 100);
    popoverController.arrowDirection = UIPopoverArrowDirectionUp;
    popoverController.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    favouritesPopoverButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (isInMiddleOfFavouriteSave == YES) {
        favouritesPopoverButton.enabled = NO;
        [favouritesPopoverButton setTitle:@"Adding..." forState:UIControlStateDisabled];
    } else {
    NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
    if (temp2.count != 0) {
        [favouritesPopoverButton setTitle:@"Remove from Favourites" forState:UIControlStateNormal];
    } else {
        [favouritesPopoverButton setTitle:@"Add to Favourites" forState:UIControlStateNormal];
    }
    }
    favouritesPopoverButton.frame = CGRectMake(5, 5, widthFloat-30, 40);
    [favouritesPopoverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    favouritesPopoverButton.exclusiveTouch = YES;
    favouritesPopoverButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    favouritesPopoverButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [favouritesPopoverButton addTarget:self action:@selector(addFavouritesPopoverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    CALayer *btnLayer = [favouritesPopoverButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    [[favouritesPopoverButton layer] setBorderWidth:3.0f];
    [[favouritesPopoverButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    favouritesPopoverButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    [popoverController.view addSubview:favouritesPopoverButton];
    
    comparePopoverButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (isInMiddleOfCompareSave == YES) {
        comparePopoverButton.enabled = NO;
        [comparePopoverButton setTitle:@"Adding..." forState:UIControlStateDisabled];
    } else {
        NSArray * temp2 = [Compares readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
        if (temp2.count != 0) {
            [comparePopoverButton setTitle:@"Remove from Compare" forState:UIControlStateNormal];
        } else {
            [comparePopoverButton setTitle:@"Add to Compare" forState:UIControlStateNormal];
        }
    }
    comparePopoverButton.frame = CGRectMake(5, 55, widthFloat-30, 40);
    [comparePopoverButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    comparePopoverButton.exclusiveTouch = YES;
    comparePopoverButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    comparePopoverButton.titleLabel.textColor = NSTextAlignmentLeft;
    [comparePopoverButton addTarget:self action:@selector(comparePopoverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    btnLayer = [comparePopoverButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    [[comparePopoverButton layer] setBorderWidth:3.0f];
    [[comparePopoverButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    comparePopoverButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    [popoverController.view addSubview:comparePopoverButton];
    
    [self presentViewController:popoverController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFavouritesPopoverButtonClicked {
    
    if (self.isItFavourite == YES) {
        favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
        favouritesButton.tintColor = [UIColor whiteColor];
        [favouritesPopoverButton setTitle:@"Add to Favourites" forState:UIControlStateNormal];
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
        //  NSLog(@"yeah freaky: %@",temp2);
        
        for (Favourites * temp in temp2) {
            [Favourites deleteObject:temp];
            
        }
        [Favourites saveDatabase];
        self.isItFavourite = NO;
        self.haveComeFromFavourites = NO;
    }
    else if (self.isItFavourite == NO) {
        
        self.isInMiddleOfFavouriteSave = YES;
        [favouritesPopoverButton setTitle:@"Adding..." forState:UIControlStateNormal];
        favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
        favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
        favouritesPopoverButton.enabled = NO;
        
        // EXtending so it saves also student satisfaction data!!
        
        PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
        [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryForStudentSatisfactionData whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
        [queryForStudentSatisfactionData findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSLog(@"objects: %@",objects);
                Favourites * temp = [Favourites createObject];
                temp.courseName = self.courseNameCourseInfo;
                temp.uniName = self.uniNameCourseInfo;
                temp.courseCode = self.courseCodeCourseInfo;
                temp.uniCode = self.uniCodeCourseInfo;
                temp.yearAbroad = self.yearAbroad;
                temp.sandwichYear = self.sandwichYear;
                temp.courseUrl = self.courseUrl;
                //temp.ucasCode = self.ucasCourseCode;
                temp.degreeClasses = [NSKeyedArchiver archivedDataWithRootObject:self.degreeStatistics];
                temp.averageTariffString = self.averageTariffString;
                temp.assessmentMethods = [NSKeyedArchiver archivedDataWithRootObject:self.assessmentMethods];
                temp.timeSpent = [NSKeyedArchiver archivedDataWithRootObject:self.timeSpent];
                temp.proportionInWork = self.proportionInWork;
                temp.commonJobs = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobs];
                temp.commonJobsPercentages = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobsPercentages];
                temp.instituteSalary = self.instituteSalary;
                temp.nationalSalary = self.nationalSalary;
                if (objects.count == 0) {
                    //  NSLog(@"this worked");
                    // SOME KIND OF ERROR MESSAGE
                    
                } else {
                    NSArray *tempObject = [objects objectAtIndex:0];
                    NSString *question1 = [tempObject valueForKey:@"Q1"];
                    NSString *question2 = [tempObject valueForKey:@"Q2"];
                    NSString *question3 = [tempObject valueForKey:@"Q3"];
                    NSString *question4 = [tempObject valueForKey:@"Q4"];
                    NSString *question5 = [tempObject valueForKey:@"Q5"];
                    NSString *question6 = [tempObject valueForKey:@"Q6"];
                    NSString *question7 = [tempObject valueForKey:@"Q7"];
                    NSString *question8 = [tempObject valueForKey:@"Q8"];
                    NSString *question9 = [tempObject valueForKey:@"Q9"];
                    NSString *question10 = [tempObject valueForKey:@"Q10"];
                    NSString *question11 = [tempObject valueForKey:@"Q11"];
                    NSString *question12 = [tempObject valueForKey:@"Q12"];
                    NSString *question13 = [tempObject valueForKey:@"Q13"];
                    NSString *question14 = [tempObject valueForKey:@"Q14"];
                    NSString *question15 = [tempObject valueForKey:@"Q15"];
                    NSString *question16 = [tempObject valueForKey:@"Q16"];
                    NSString *question17 = [tempObject valueForKey:@"Q17"];
                    NSString *question18 = [tempObject valueForKey:@"Q18"];
                    NSString *question19 = [tempObject valueForKey:@"Q19"];
                    NSString *question20 = [tempObject valueForKey:@"Q20"];
                    NSString *question21 = [tempObject valueForKey:@"Q21"];
                    NSString *question22 = [tempObject valueForKey:@"Q22"];
                    
                    NSMutableArray *questionResults = [[NSMutableArray alloc] initWithObjects:question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20,question21,question22, nil];
                    
                    temp.nSSScores = [NSKeyedArchiver archivedDataWithRootObject:questionResults];
                    
                    
                }
                // THIS HAPPENS IF THERE IS NSS SCORES OR NOT
                
                // NEXT WE FIND ALL THE INFO FOR THE UNI INFO PAGE
                PFQuery *queryForStudentSatisfaction = [PFQuery queryWithClassName:@"Institution"];
                [queryForStudentSatisfaction whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                [queryForStudentSatisfaction whereKeyExists:@"Q24"];
                [queryForStudentSatisfaction findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    if (!error) {
                        if (objects.count != 0) {
                            
                            NSArray *uniInfoTemp = [objects objectAtIndex:0];
                            NSString *studentSatisfactionPercentage = [uniInfoTemp valueForKey:@"Q24"];
                            NSLog(@"student satisfaction: %@",studentSatisfactionPercentage);
                            temp.unionSatisfaction = studentSatisfactionPercentage;
                            
                            // query to get total number of students
                            PFQuery *queryForTotalNumberOfStudents = [PFQuery queryWithClassName:@"Institution1213"];
                            [queryForTotalNumberOfStudents whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                            [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"TotalAllStudents"]];
                            PFObject *tempObject1 = [queryForTotalNumberOfStudents getFirstObject];
                            NSString *totalNumberOfStudents = [tempObject1 valueForKey:@"TotalAllStudents"];
            
                            
                            // query to get total number of staff
                            PFQuery *queryForTotalNumberOfStaff = [PFQuery queryWithClassName:@"StaffInst1213"];
                            [queryForTotalNumberOfStaff whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                            [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"Total"]];
                            PFObject *tempObject2 = [queryForTotalNumberOfStaff getFirstObject];
                            NSString *totalNumberOfStaff = [tempObject2 valueForKey:@"Total"];
                            
                            
                            //query to get data on total number of beds
                            PFQuery *queryForAccomodation = [PFQuery queryWithClassName:@"Location"];
                            [queryForAccomodation whereKeyExists:@"INSTBEDS"];
                            [queryForAccomodation whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                                NSUInteger privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
                                averageCostOfLivingPrivateString = @"£";
                                averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)privateRounded]];
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
                                NSUInteger instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
                                averageCostOfLivingInstituteString = @"£";
                                averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)instituteRounded]];
                                NSLog(@"averageL %@",averageCostOfLivingInstituteString);
                            } else {
                                averageCostOfLivingInstituteString = @"N/A";
                                
                            }
                            
                            NSLog(@"1: %@ 2: %@ 3: %@ 4: %@ 5: %@",totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString);
                            
                            NSMutableArray *uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];
                            
                            temp.uniInfoData = [NSKeyedArchiver archivedDataWithRootObject:uniInfoDataNumbers];
                        }
                    }
                }];
                 
                // NOW WE HAVE FINISHED FINDING ALL OF THE UNI INFO WE CAN FIND CONTACT INFO
                
                PFQuery *contactQuery = [PFQuery queryWithClassName:@"Institution1213"];
                [contactQuery whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                [contactQuery selectKeys:[NSArray arrayWithObjects:@"TelephoneContact",@"EmailContact",@"WebsiteContact", nil]];
                [contactQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    if (!error) {
                        NSArray *contactDetails = [objects objectAtIndex:0];
                        temp.telephoneContact = [contactDetails valueForKey:@"TelephoneContact"];
                        temp.emailContact = [contactDetails valueForKey:@"EmailContact"];
                        temp.websiteContact = [contactDetails valueForKey:@"WebsiteContact"];
                    }
                    else {
                        NSLog(@"error finding contact details");
                    }
                }];
                
                PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
                [locationQuery whereKey:@"UKPRN" equalTo:uniCodeCourseInfo];
                [locationQuery whereKeyExists:@"INSTBEDS"];
                
                [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    if (!error) {
                        NSArray *bedNumbersString = [objects valueForKey:@"INSTBEDS"];
                        NSLog(@"boobooboo: %@",bedNumbersString);
                        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                        [f setNumberStyle:NSNumberFormatterDecimalStyle];
                        NSMutableArray *bedNumbers = [[NSMutableArray alloc] init];
                        int i;
                        for (i=0; i<bedNumbersString.count; i++) {
                            NSString *tempString = [bedNumbersString objectAtIndex:i];
                            NSNumber *tempNumber = [f numberFromString:tempString];
                            [bedNumbers addObject:tempNumber];
                        }
                        NSLog(@"bed numbers: %@",bedNumbers);
                        
                        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
                        NSArray *bedNumbersSorted = [bedNumbers sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];

                        NSLog(@"bed numbers sorted: %@", bedNumbersSorted);
                        NSNumber *topBedNumber = [bedNumbersSorted objectAtIndex:0];
                        NSString *topBedString = [topBedNumber stringValue];
                        NSInteger originalIndexPath = [bedNumbersString indexOfObject:topBedString];
                        NSArray *latitudes = [objects valueForKey:@"LATITUDE"];
                        NSArray *longitudes = [objects valueForKey:@"LONGITUDE"];
                        NSString *uniLatitude = [latitudes objectAtIndex:originalIndexPath];
                        NSString *uniLongitude = [longitudes objectAtIndex:originalIndexPath];
                        NSLog(@"class: %@",[uniLatitude class]);
                        temp.latitudeContact = uniLatitude;
                        temp.longitudeContact = uniLongitude;
                        
                        CLGeocoder *ceo = [[CLGeocoder alloc]init];
                        CLLocation *loc = [[CLLocation alloc]initWithLatitude:[uniLatitude floatValue] longitude:[uniLongitude floatValue]]; //insert your coordinates
                        [ceo reverseGeocodeLocation:loc
                                  completionHandler:^(NSArray *placemarks, NSError *error) {
                                      if (!error) {
                                          
                                          CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                          //String to hold address
                                          NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                                          temp.address = locatedAt;
                                          
                                          
                                      }
                                      else {
                                          NSLog(@"Could not locate");
                                          temp.address = @"Could not find address";
                                          
                                      }
                                  }];
                    }
                    else {
                        NSLog(@"error finding location");
                    }
                    
                }];

                
                // WE HAVE NOW FOUND ALL THE INFO AND SO CAN FINISH
                favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
                favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
                [favouritesPopoverButton setTitle:@"Remove from Favourites" forState:UIControlStateNormal];
                favouritesPopoverButton.enabled = YES;
                self.isInMiddleOfFavouriteSave = NO;
                [Favourites saveDatabase];
                self.isItFavourite = YES;
                self.haveComeFromFavourites = YES;
            } else {
                NSLog(@"error saving to favourites");
                favouritesButton.tintColor = [UIColor whiteColor];
                favouritesButton.image = [UIImage imageNamed:@"add_to_favorites-512.png"];
                favouritesPopoverButton.enabled = YES;
                [favouritesPopoverButton setTitle:@"Remove from Favourites" forState:UIControlStateNormal];
                self.isInMiddleOfFavouriteSave = NO;
                UIAlertView *couldNotSaveAlertView = [[UIAlertView alloc] initWithTitle:@"Could not save!" message:@"We're sorry, but internet connection is required to save a course offline" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [couldNotSaveAlertView show];
            }
        }];
        
    }

    
}

- (void)comparePopoverButtonClicked {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    NSArray *comparesArray1 = [Compares readAllObjects];
    NSLog(@"count1: %lu",(unsigned long)comparesArray1.count);
    
    NSArray * temp2 = [Compares readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeCourseInfo,self.uniCodeCourseInfo] andSortKey:@"courseName"];
    
    if (temp2.count != 0) {
        // IT IS IN COMPARE SO NEED TO REMOVE IT
        [comparePopoverButton setTitle:@"Add to Compare" forState:UIControlStateNormal];
        
        for (Compares * temp in temp2) {
            [Compares deleteObject:temp];
            
        }
        [Compares saveDatabase];
    } else {
        // IT IS NOT IN COMPARE SO NEED TO ADD IT
    NSArray *comparesArray = [Compares readAllObjects];

    if (comparesArray.count == 2) {
        // THEN THERE IS NO SPACE SO WE MUST REPLACE ANOTHER COURSE
        
        
        
        Compares *tempObject1 = [comparesArray objectAtIndex:0];
        Compares *tempObject2 = [comparesArray objectAtIndex:1];
        NSString *courseName1 = tempObject1.courseName;
        NSString *courseName2 = tempObject2.courseName;
        NSString *uniName1 = tempObject1.uniName;
        NSString *uniName2 = tempObject2.uniName;
        
        replaceFirstButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [replaceFirstButton setTitle:@"  Replace:" forState:UIControlStateNormal];
        replaceFirstButton.frame = CGRectMake(5, 5, widthFloat-30, 40);
        [replaceFirstButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [replaceFirstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        replaceFirstButton.exclusiveTouch = YES;
        replaceFirstButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
        replaceFirstButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [replaceFirstButton addTarget:self action:@selector(replaceFirstButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        CALayer *btnLayer = [replaceFirstButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:15.0f];
        [[replaceFirstButton layer] setBorderWidth:3.0f];
        [[replaceFirstButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
        replaceFirstButton.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        replaceFirstButton.hidden = YES;
        
        UILabel *nameLabel1 = [[UILabel alloc] init];
        nameLabel1.frame = CGRectMake(65, 4, widthFloat-105, 16);
        nameLabel1.font = [UIFont fontWithName:@"Arial" size:14];
        nameLabel1.textAlignment = NSTextAlignmentRight;
        nameLabel1.adjustsFontSizeToFitWidth = YES;
        nameLabel1.text = courseName1;
        nameLabel1.textColor = [UIColor whiteColor];
        [replaceFirstButton addSubview:nameLabel1];
        
        UILabel *uniNameLabel1 = [[UILabel alloc] init];
        uniNameLabel1.frame = CGRectMake(65, 20, widthFloat-105, 13);
        uniNameLabel1.font = [UIFont fontWithName:@"Arial" size:12];
        uniNameLabel1.textAlignment = NSTextAlignmentRight;
        uniNameLabel1.adjustsFontSizeToFitWidth = YES;
        uniNameLabel1.text = uniName1;
        uniNameLabel1.textColor = [UIColor whiteColor];
        [replaceFirstButton addSubview:uniNameLabel1];
        [popoverController.view addSubview:replaceFirstButton];
        
        replaceSecondButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [replaceSecondButton setTitle:@"  Replace:" forState:UIControlStateNormal];
        [replaceSecondButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        replaceSecondButton.frame = CGRectMake(5, 55, widthFloat-30, 40);
        [replaceSecondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        replaceSecondButton.exclusiveTouch = YES;
        replaceSecondButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13];
        replaceSecondButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [replaceSecondButton addTarget:self action:@selector(replaceSecondButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        btnLayer = [replaceSecondButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:15.0f];
        [[replaceSecondButton layer] setBorderWidth:3.0f];
        [[replaceSecondButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
        replaceSecondButton.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        replaceSecondButton.hidden = YES;
        
        UILabel *nameLabel2 = [[UILabel alloc] init];
        nameLabel2.frame = CGRectMake(65, 4, widthFloat-105, 16);
        nameLabel2.font = [UIFont fontWithName:@"Arial" size:14];
        nameLabel2.textAlignment = NSTextAlignmentRight;
        nameLabel2.adjustsFontSizeToFitWidth = YES;
        nameLabel2.text = courseName2;
        nameLabel2.textColor = [UIColor whiteColor];
        [replaceSecondButton addSubview:nameLabel2];
        
        UILabel *uniNameLabel2 = [[UILabel alloc] init];
        uniNameLabel2.frame = CGRectMake(65, 20, widthFloat-105, 13);
        uniNameLabel2.font = [UIFont fontWithName:@"Arial" size:12];
        uniNameLabel2.textAlignment = NSTextAlignmentRight;
        uniNameLabel2.adjustsFontSizeToFitWidth = YES;
        uniNameLabel2.text = uniName2;
        uniNameLabel2.textColor = [UIColor whiteColor];
        [replaceSecondButton addSubview:uniNameLabel2];
        [popoverController.view addSubview:replaceSecondButton];
        
        [UIView animateWithDuration:0.3 animations:^{
            favouritesPopoverButton.alpha = 0;
        } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
            favouritesPopoverButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
            if (finished) {
                replaceFirstButton.alpha = 0;
                replaceFirstButton.hidden = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    replaceFirstButton.alpha = 1;
                }];
            }
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            comparePopoverButton.alpha = 0;
        } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
            comparePopoverButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
            if (finished) {
                replaceSecondButton.alpha = 0;
                replaceSecondButton.hidden = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    replaceSecondButton.alpha = 1;
                }];
            }
        }];
        


        
        
        
    } else {
        // THERE IS SPACE SO WE CAN SAVE THE COURSE

        
        self.isInMiddleOfCompareSave = YES;
        [comparePopoverButton setTitle:@"Adding..." forState:UIControlStateNormal];
        comparePopoverButton.enabled = NO;
        
        // EXtending so it saves also student satisfaction data!!
        
        PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
        [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
        [queryForStudentSatisfactionData whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
        [queryForStudentSatisfactionData findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSLog(@"objects: %@",objects);
                Compares * tempCompares = [Compares createObject];
                tempCompares.courseName = self.courseNameCourseInfo;
                tempCompares.uniName = self.uniNameCourseInfo;
                tempCompares.courseCode = self.courseCodeCourseInfo;
                tempCompares.uniCode = self.uniCodeCourseInfo;
                tempCompares.yearAbroad = self.yearAbroad;
                tempCompares.sandwichYear = self.sandwichYear;
                tempCompares.courseUrl = self.courseUrl;
                //temp.ucasCode = self.ucasCourseCode;
                tempCompares.degreeClasses = [NSKeyedArchiver archivedDataWithRootObject:self.degreeStatistics];
                tempCompares.averageTariffString = self.averageTariffString;
                tempCompares.assessmentMethods = [NSKeyedArchiver archivedDataWithRootObject:self.assessmentMethods];
                tempCompares.timeSpent = [NSKeyedArchiver archivedDataWithRootObject:self.timeSpent];
                tempCompares.proportionInWork = self.proportionInWork;
                tempCompares.commonJobs = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobs];
                tempCompares.commonJobsPercentages = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobsPercentages];
                tempCompares.instituteSalary = self.instituteSalary;
                if (objects.count == 0) {
                    //  NSLog(@"this worked");
                    // SOME KIND OF ERROR MESSAGE
                    
                } else {
                    NSArray *tempObject = [objects objectAtIndex:0];
                    NSString *question1 = [tempObject valueForKey:@"Q1"];
                    NSString *question2 = [tempObject valueForKey:@"Q2"];
                    NSString *question3 = [tempObject valueForKey:@"Q3"];
                    NSString *question4 = [tempObject valueForKey:@"Q4"];
                    NSString *question5 = [tempObject valueForKey:@"Q5"];
                    NSString *question6 = [tempObject valueForKey:@"Q6"];
                    NSString *question7 = [tempObject valueForKey:@"Q7"];
                    NSString *question8 = [tempObject valueForKey:@"Q8"];
                    NSString *question9 = [tempObject valueForKey:@"Q9"];
                    NSString *question10 = [tempObject valueForKey:@"Q10"];
                    NSString *question11 = [tempObject valueForKey:@"Q11"];
                    NSString *question12 = [tempObject valueForKey:@"Q12"];
                    NSString *question13 = [tempObject valueForKey:@"Q13"];
                    NSString *question14 = [tempObject valueForKey:@"Q14"];
                    NSString *question15 = [tempObject valueForKey:@"Q15"];
                    NSString *question16 = [tempObject valueForKey:@"Q16"];
                    NSString *question17 = [tempObject valueForKey:@"Q17"];
                    NSString *question18 = [tempObject valueForKey:@"Q18"];
                    NSString *question19 = [tempObject valueForKey:@"Q19"];
                    NSString *question20 = [tempObject valueForKey:@"Q20"];
                    NSString *question21 = [tempObject valueForKey:@"Q21"];
                    NSString *question22 = [tempObject valueForKey:@"Q22"];
                    
                    NSMutableArray *questionResults = [[NSMutableArray alloc] initWithObjects:question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20,question21,question22, nil];
                    
                    tempCompares.nSSScores = [NSKeyedArchiver archivedDataWithRootObject:questionResults];
                    
                    
                }
                // THIS HAPPENS IF THERE IS NSS SCORES OR NOT
                
                // NEXT WE FIND ALL THE INFO FOR THE UNI INFO PAGE
                PFQuery *queryForStudentSatisfaction = [PFQuery queryWithClassName:@"Institution"];
                [queryForStudentSatisfaction whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                [queryForStudentSatisfaction whereKeyExists:@"Q24"];
                [queryForStudentSatisfaction findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    if (!error) {
                        if (objects.count != 0) {
                            
                            NSArray *uniInfoTemp = [objects objectAtIndex:0];
                            NSString *studentSatisfactionPercentage = [uniInfoTemp valueForKey:@"Q24"];
                            tempCompares.unionSatisfaction = studentSatisfactionPercentage;
                            
                            // query to get total number of students
                            PFQuery *queryForTotalNumberOfStudents = [PFQuery queryWithClassName:@"Institution1213"];
                            [queryForTotalNumberOfStudents whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                            [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"TotalAllStudents"]];
                            PFObject *tempObject1 = [queryForTotalNumberOfStudents getFirstObject];
                            NSString *totalNumberOfStudents = [tempObject1 valueForKey:@"TotalAllStudents"];
                            
                            
                            // query to get total number of staff
                            PFQuery *queryForTotalNumberOfStaff = [PFQuery queryWithClassName:@"StaffInst1213"];
                            [queryForTotalNumberOfStaff whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                            [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"Total"]];
                            PFObject *tempObject2 = [queryForTotalNumberOfStaff getFirstObject];
                            NSString *totalNumberOfStaff = [tempObject2 valueForKey:@"Total"];
                            
                            
                            //query to get data on total number of beds
                            PFQuery *queryForAccomodation = [PFQuery queryWithClassName:@"Location"];
                            [queryForAccomodation whereKeyExists:@"INSTBEDS"];
                            [queryForAccomodation whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                                NSUInteger privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
                                averageCostOfLivingPrivateString = @"£";
                                averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)privateRounded]];
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
                                NSUInteger instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
                                averageCostOfLivingInstituteString = @"£";
                                averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)instituteRounded]];
                                NSLog(@"averageL %@",averageCostOfLivingInstituteString);
                            } else {
                                averageCostOfLivingInstituteString = @"N/A";
                                
                            }
                            
                            //NSLog(@"1: %@ 2: %@ 3: %@ 4: %@ 5: %@",totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString);
                            
                            NSMutableArray *uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];
                            
                            tempCompares.uniInfoData = [NSKeyedArchiver archivedDataWithRootObject:uniInfoDataNumbers];
                        }
                    }
                }];
                
                // WE HAVE NOW FOUND ALL THE INFO AND SO CAN FINISH

                [comparePopoverButton setTitle:@"Remove from Compare" forState:UIControlStateNormal];
                comparePopoverButton.enabled = YES;
                self.isInMiddleOfCompareSave = NO;
                [Compares saveDatabase];
            } else {
                NSLog(@"error saving to compare");
                [comparePopoverButton setTitle:@"Add to Compare" forState:UIControlStateNormal];
                self.self.isInMiddleOfCompareSave = NO;
                comparePopoverButton.enabled = YES;
                UIAlertView *couldNotSaveAlertView = [[UIAlertView alloc] initWithTitle:@"Could not save!" message:@"We're sorry, but internet connection is required to add a course to compare" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [couldNotSaveAlertView show];
            }
        }];
    }

    }
    
    
}

- (void)replaceFirstButtonClicked {
    self.isInMiddleOfCompareSave = YES;
    [UIView animateWithDuration:0.3 animations:^{
        replaceFirstButton.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        replaceFirstButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        if (finished) {
            favouritesPopoverButton.alpha = 0;
            favouritesPopoverButton.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                favouritesPopoverButton.alpha = 1;
            }];
        }
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        replaceSecondButton.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        replaceSecondButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        if (finished) {
            comparePopoverButton.alpha = 0;
            comparePopoverButton.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                comparePopoverButton.alpha = 1;
            }];
        }
    }];
    
    [comparePopoverButton setTitle:@"Adding..." forState:UIControlStateNormal];
    comparePopoverButton.enabled = NO;

    
    // FIRST LET'S DELETE THE OLD COURSE

    NSArray *temp1 = [Compares readAllObjects];
    NSManagedObject *temp2 = [temp1 objectAtIndex:0];
    NSLog(@"temp2: %@",temp2);
    [Compares deleteObject:temp2];

    [Compares saveDatabase];
    
    // NOW ADD THE NEW COURSE
    
    PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
    [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryForStudentSatisfactionData whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
    [queryForStudentSatisfactionData findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if (!error) {
            NSLog(@"objects: %@",objects);
            Compares * tempCompares = [Compares createObject];
            tempCompares.courseName = self.courseNameCourseInfo;
            tempCompares.uniName = self.uniNameCourseInfo;
            tempCompares.courseCode = self.courseCodeCourseInfo;
            tempCompares.uniCode = self.uniCodeCourseInfo;
            tempCompares.yearAbroad = self.yearAbroad;
            tempCompares.sandwichYear = self.sandwichYear;
            tempCompares.courseUrl = self.courseUrl;
            //temp.ucasCode = self.ucasCourseCode;
            tempCompares.degreeClasses = [NSKeyedArchiver archivedDataWithRootObject:self.degreeStatistics];
            tempCompares.averageTariffString = self.averageTariffString;
            tempCompares.assessmentMethods = [NSKeyedArchiver archivedDataWithRootObject:self.assessmentMethods];
            tempCompares.timeSpent = [NSKeyedArchiver archivedDataWithRootObject:self.timeSpent];
            tempCompares.proportionInWork = self.proportionInWork;
            tempCompares.commonJobs = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobs];
            tempCompares.commonJobsPercentages = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobsPercentages];
            tempCompares.instituteSalary = self.instituteSalary;
            if (objects.count == 0) {
                //  NSLog(@"this worked");
                // SOME KIND OF ERROR MESSAGE
                
            } else {
                NSArray *tempObject = [objects objectAtIndex:0];
                NSString *question1 = [tempObject valueForKey:@"Q1"];
                NSString *question2 = [tempObject valueForKey:@"Q2"];
                NSString *question3 = [tempObject valueForKey:@"Q3"];
                NSString *question4 = [tempObject valueForKey:@"Q4"];
                NSString *question5 = [tempObject valueForKey:@"Q5"];
                NSString *question6 = [tempObject valueForKey:@"Q6"];
                NSString *question7 = [tempObject valueForKey:@"Q7"];
                NSString *question8 = [tempObject valueForKey:@"Q8"];
                NSString *question9 = [tempObject valueForKey:@"Q9"];
                NSString *question10 = [tempObject valueForKey:@"Q10"];
                NSString *question11 = [tempObject valueForKey:@"Q11"];
                NSString *question12 = [tempObject valueForKey:@"Q12"];
                NSString *question13 = [tempObject valueForKey:@"Q13"];
                NSString *question14 = [tempObject valueForKey:@"Q14"];
                NSString *question15 = [tempObject valueForKey:@"Q15"];
                NSString *question16 = [tempObject valueForKey:@"Q16"];
                NSString *question17 = [tempObject valueForKey:@"Q17"];
                NSString *question18 = [tempObject valueForKey:@"Q18"];
                NSString *question19 = [tempObject valueForKey:@"Q19"];
                NSString *question20 = [tempObject valueForKey:@"Q20"];
                NSString *question21 = [tempObject valueForKey:@"Q21"];
                NSString *question22 = [tempObject valueForKey:@"Q22"];
                
                NSMutableArray *questionResults = [[NSMutableArray alloc] initWithObjects:question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20,question21,question22, nil];
                
                tempCompares.nSSScores = [NSKeyedArchiver archivedDataWithRootObject:questionResults];
                
                
            }
            // THIS HAPPENS IF THERE IS NSS SCORES OR NOT
            
            // NEXT WE FIND ALL THE INFO FOR THE UNI INFO PAGE
            PFQuery *queryForStudentSatisfaction = [PFQuery queryWithClassName:@"Institution"];
            [queryForStudentSatisfaction whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
            [queryForStudentSatisfaction whereKeyExists:@"Q24"];
            [queryForStudentSatisfaction findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                if (!error) {
                    if (objects.count != 0) {
                        
                        NSArray *uniInfoTemp = [objects objectAtIndex:0];
                        NSString *studentSatisfactionPercentage = [uniInfoTemp valueForKey:@"Q24"];
                        tempCompares.unionSatisfaction = studentSatisfactionPercentage;
                        
                        // query to get total number of students
                        PFQuery *queryForTotalNumberOfStudents = [PFQuery queryWithClassName:@"Institution1213"];
                        [queryForTotalNumberOfStudents whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                        [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"TotalAllStudents"]];
                        PFObject *tempObject1 = [queryForTotalNumberOfStudents getFirstObject];
                        NSString *totalNumberOfStudents = [tempObject1 valueForKey:@"TotalAllStudents"];
                        
                        
                        // query to get total number of staff
                        PFQuery *queryForTotalNumberOfStaff = [PFQuery queryWithClassName:@"StaffInst1213"];
                        [queryForTotalNumberOfStaff whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                        [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"Total"]];
                        PFObject *tempObject2 = [queryForTotalNumberOfStaff getFirstObject];
                        NSString *totalNumberOfStaff = [tempObject2 valueForKey:@"Total"];
                        
                        
                        //query to get data on total number of beds
                        PFQuery *queryForAccomodation = [PFQuery queryWithClassName:@"Location"];
                        [queryForAccomodation whereKeyExists:@"INSTBEDS"];
                        [queryForAccomodation whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                            NSUInteger privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
                            averageCostOfLivingPrivateString = @"£";
                            averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)privateRounded]];
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
                            NSUInteger instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
                            averageCostOfLivingInstituteString = @"£";
                            averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)instituteRounded]];
                            NSLog(@"averageL %@",averageCostOfLivingInstituteString);
                        } else {
                            averageCostOfLivingInstituteString = @"N/A";
                            
                        }
                        
                        //NSLog(@"1: %@ 2: %@ 3: %@ 4: %@ 5: %@",totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString);
                        
                        NSMutableArray *uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];
                        
                        tempCompares.uniInfoData = [NSKeyedArchiver archivedDataWithRootObject:uniInfoDataNumbers];
                    }
                }
            }];
            
            // WE HAVE NOW FOUND ALL THE INFO AND SO CAN FINISH
            
            [comparePopoverButton setTitle:@"Remove from Compare" forState:UIControlStateNormal];
            comparePopoverButton.enabled = YES;
            self.isInMiddleOfCompareSave = NO;
            [Compares saveDatabase];

        } else {
            NSLog(@"error saving to favourites");
            [comparePopoverButton setTitle:@"Add to Compare" forState:UIControlStateNormal];
            comparePopoverButton.enabled = YES;
            self.isInMiddleOfCompareSave = NO;
            UIAlertView *couldNotSaveAlertView = [[UIAlertView alloc] initWithTitle:@"Could not save!" message:@"We're sorry, but internet connection is required to add a course to compare" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [couldNotSaveAlertView show];
        }
    }];


}

- (void)replaceSecondButtonClicked {
    
    self.isInMiddleOfCompareSave = YES;
    [UIView animateWithDuration:0.3 animations:^{
        replaceFirstButton.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        replaceFirstButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        if (finished) {
            favouritesPopoverButton.alpha = 0;
            favouritesPopoverButton.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                favouritesPopoverButton.alpha = 1;
            }];
        }
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        replaceSecondButton.alpha = 0;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
        replaceSecondButton.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        if (finished) {
            comparePopoverButton.alpha = 0;
            comparePopoverButton.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                comparePopoverButton.alpha = 1;
            }];
        }
    }];
    
    [comparePopoverButton setTitle:@"Adding..." forState:UIControlStateNormal];
    comparePopoverButton.enabled = NO;
    
    
    // FIRST LET'S DELETE THE OLD COURSE
    
    NSArray *temp1 = [Compares readAllObjects];
    NSManagedObject *temp2 = [temp1 objectAtIndex:1];
    NSLog(@"temp2: %@",temp2);
    [Compares deleteObject:temp2];
    
    [Compares saveDatabase];
    
    // NOW ADD THE NEW COURSE
    
    PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
    [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryForStudentSatisfactionData whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
    [queryForStudentSatisfactionData findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if (!error) {
            NSLog(@"objects: %@",objects);
            Compares * tempCompares = [Compares createObject];
            tempCompares.courseName = self.courseNameCourseInfo;
            tempCompares.uniName = self.uniNameCourseInfo;
            tempCompares.courseCode = self.courseCodeCourseInfo;
            tempCompares.uniCode = self.uniCodeCourseInfo;
            tempCompares.yearAbroad = self.yearAbroad;
            tempCompares.sandwichYear = self.sandwichYear;
            tempCompares.courseUrl = self.courseUrl;
            //temp.ucasCode = self.ucasCourseCode;
            tempCompares.degreeClasses = [NSKeyedArchiver archivedDataWithRootObject:self.degreeStatistics];
            tempCompares.averageTariffString = self.averageTariffString;
            tempCompares.assessmentMethods = [NSKeyedArchiver archivedDataWithRootObject:self.assessmentMethods];
            tempCompares.timeSpent = [NSKeyedArchiver archivedDataWithRootObject:self.timeSpent];
            tempCompares.proportionInWork = self.proportionInWork;
            tempCompares.commonJobs = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobs];
            tempCompares.commonJobsPercentages = [NSKeyedArchiver archivedDataWithRootObject:self.commonJobsPercentages];
            tempCompares.instituteSalary = self.instituteSalary;
            if (objects.count == 0) {
                //  NSLog(@"this worked");
                // SOME KIND OF ERROR MESSAGE
                
            } else {
                NSArray *tempObject = [objects objectAtIndex:0];
                NSString *question1 = [tempObject valueForKey:@"Q1"];
                NSString *question2 = [tempObject valueForKey:@"Q2"];
                NSString *question3 = [tempObject valueForKey:@"Q3"];
                NSString *question4 = [tempObject valueForKey:@"Q4"];
                NSString *question5 = [tempObject valueForKey:@"Q5"];
                NSString *question6 = [tempObject valueForKey:@"Q6"];
                NSString *question7 = [tempObject valueForKey:@"Q7"];
                NSString *question8 = [tempObject valueForKey:@"Q8"];
                NSString *question9 = [tempObject valueForKey:@"Q9"];
                NSString *question10 = [tempObject valueForKey:@"Q10"];
                NSString *question11 = [tempObject valueForKey:@"Q11"];
                NSString *question12 = [tempObject valueForKey:@"Q12"];
                NSString *question13 = [tempObject valueForKey:@"Q13"];
                NSString *question14 = [tempObject valueForKey:@"Q14"];
                NSString *question15 = [tempObject valueForKey:@"Q15"];
                NSString *question16 = [tempObject valueForKey:@"Q16"];
                NSString *question17 = [tempObject valueForKey:@"Q17"];
                NSString *question18 = [tempObject valueForKey:@"Q18"];
                NSString *question19 = [tempObject valueForKey:@"Q19"];
                NSString *question20 = [tempObject valueForKey:@"Q20"];
                NSString *question21 = [tempObject valueForKey:@"Q21"];
                NSString *question22 = [tempObject valueForKey:@"Q22"];
                
                NSMutableArray *questionResults = [[NSMutableArray alloc] initWithObjects:question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20,question21,question22, nil];
                
                tempCompares.nSSScores = [NSKeyedArchiver archivedDataWithRootObject:questionResults];
                
                
            }
            // THIS HAPPENS IF THERE IS NSS SCORES OR NOT
            
            // NEXT WE FIND ALL THE INFO FOR THE UNI INFO PAGE
            PFQuery *queryForStudentSatisfaction = [PFQuery queryWithClassName:@"Institution"];
            [queryForStudentSatisfaction whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
            [queryForStudentSatisfaction whereKeyExists:@"Q24"];
            [queryForStudentSatisfaction findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                if (!error) {
                    if (objects.count != 0) {
                        
                        NSArray *uniInfoTemp = [objects objectAtIndex:0];
                        NSString *studentSatisfactionPercentage = [uniInfoTemp valueForKey:@"Q24"];
                        tempCompares.unionSatisfaction = studentSatisfactionPercentage;
                        
                        // query to get total number of students
                        PFQuery *queryForTotalNumberOfStudents = [PFQuery queryWithClassName:@"Institution1213"];
                        [queryForTotalNumberOfStudents whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                        [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"TotalAllStudents"]];
                        PFObject *tempObject1 = [queryForTotalNumberOfStudents getFirstObject];
                        NSString *totalNumberOfStudents = [tempObject1 valueForKey:@"TotalAllStudents"];
                        
                        
                        // query to get total number of staff
                        PFQuery *queryForTotalNumberOfStaff = [PFQuery queryWithClassName:@"StaffInst1213"];
                        [queryForTotalNumberOfStaff whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
                        [queryForTotalNumberOfStudents selectKeys:[NSArray arrayWithObject:@"Total"]];
                        PFObject *tempObject2 = [queryForTotalNumberOfStaff getFirstObject];
                        NSString *totalNumberOfStaff = [tempObject2 valueForKey:@"Total"];
                        
                        
                        //query to get data on total number of beds
                        PFQuery *queryForAccomodation = [PFQuery queryWithClassName:@"Location"];
                        [queryForAccomodation whereKeyExists:@"INSTBEDS"];
                        [queryForAccomodation whereKey:@"UKPRN" equalTo:self.uniCodeCourseInfo];
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
                            NSUInteger privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
                            averageCostOfLivingPrivateString = @"£";
                            averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)privateRounded]];
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
                            NSUInteger instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
                            averageCostOfLivingInstituteString = @"£";
                            averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)instituteRounded]];
                            NSLog(@"averageL %@",averageCostOfLivingInstituteString);
                        } else {
                            averageCostOfLivingInstituteString = @"N/A";
                            
                        }
                        
                        //NSLog(@"1: %@ 2: %@ 3: %@ 4: %@ 5: %@",totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString);
                        
                        NSMutableArray *uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];
                        
                        tempCompares.uniInfoData = [NSKeyedArchiver archivedDataWithRootObject:uniInfoDataNumbers];
                    }
                }
            }];
            
            // WE HAVE NOW FOUND ALL THE INFO AND SO CAN FINISH
            
            [comparePopoverButton setTitle:@"Remove from Compare" forState:UIControlStateNormal];
            comparePopoverButton.enabled = YES;
            self.isInMiddleOfCompareSave = NO;
            [Compares saveDatabase];
            
        } else {
            NSLog(@"error saving to favourites");
            [comparePopoverButton setTitle:@"Add to Compare" forState:UIControlStateNormal];
            comparePopoverButton.enabled = YES;
            self.isInMiddleOfCompareSave = NO;
            UIAlertView *couldNotSaveAlertView = [[UIAlertView alloc] initWithTitle:@"Could not save!" message:@"We're sorry, but internet connection is required to add a course to compare" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [couldNotSaveAlertView show];
        }
    }];
    
}

@end
