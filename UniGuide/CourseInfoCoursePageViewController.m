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

@synthesize uniCodeCourseInfo,courseCodeCourseInfo,commonJobs,commonJobsPercentages,commonJobsTableView;

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
    //NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:scroll];
    [scroll setContentSize:CGSizeMake(320, 1000)];
    scroll.showsHorizontalScrollIndicator = YES;
    scroll.scrollEnabled = YES;
    scroll.delegate = self;
    scroll.bounces = NO;
    scroll.userInteractionEnabled = YES;
    
    commonJobsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 151, 320, 179)];
    commonJobsTableView.delegate = self;
    commonJobsTableView.dataSource = self;
    commonJobsTableView.bounces = NO;
    commonJobsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

    
    [scroll addSubview:commonJobsTableView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 900, 50, 50)];
    label.text = @"test";
    [scroll addSubview:label];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // query for ucas course id/course url/year abroad/sandwich year
    PFQuery *queryKiscourse = [PFQuery queryWithClassName:@"Kiscourse"];
    [queryKiscourse whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryKiscourse selectKeys:[NSArray arrayWithObjects:@"CRSEURL",@"UCASCOURSEID",@"YEARABROAD",@"SANDWICH", nil]];
    PFObject *tempKiscourseObject = [queryKiscourse getFirstObject];
    NSString *courseUrl = [tempKiscourseObject valueForKey:@"CRSEURL"];
    NSString *ucasCourseId = [tempKiscourseObject valueForKey:@"UCASCOURSEID"];
    NSString *yearAbroad = [tempKiscourseObject valueForKey:@"YEARABROAD"];
    NSString *sandwichYear = [tempKiscourseObject valueForKey:@"SANDWICH"];
    
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
    
    // query for employment
    PFQuery *queryEmployment = [PFQuery queryWithClassName:@"Employment"];
    [queryEmployment whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryEmployment selectKeys:[NSArray arrayWithObjects:@"BOTH",@"ASSUNEMP",@"STUDY",@"WORK", nil]];
    PFObject *tempEmploymentObject = [queryEmployment getFirstObject];
    NSString *bothWorkAndStudy = [tempEmploymentObject valueForKey:@"BOTH"];
    NSString *unemployed = [tempEmploymentObject valueForKey:@"ASSUNEMP"];
    NSString *studyingOnly = [tempEmploymentObject valueForKey:@"STUDY"];
    NSString *workingOnly = [tempEmploymentObject valueForKey:@"WORK"];
    
    //query for salary
    PFQuery *querySalary = [PFQuery queryWithClassName:@"Salary"];
    [querySalary whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [querySalary selectKeys:[NSArray arrayWithObjects:@"INSTMED",@"MED", nil]];
    PFObject *tempSalaryObject = [querySalary getFirstObject];
    NSString *instituteSalary = [tempSalaryObject valueForKey:@"INSTMED"];
    NSString *nationalSalary = [tempSalaryObject valueForKey:@"MED"];
    
    // query for tariff
    PFQuery *queryTariff = [PFQuery queryWithClassName:@"Tariff"];
    [queryTariff whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryTariff selectKeys:[NSArray arrayWithObjects:@"T1",@"T120",@"T160",@"T200",@"T240",@"T280",@"T320",@"T360",@"T400",@"T440",@"T480",@"T520",@"T560",@"T600", nil]];
    PFObject *tempTariffObject = [queryTariff getFirstObject];
    
    NSNumber * t1 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t120 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t160 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t200 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t240 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t280 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t320 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t360 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t400 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t440 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t480 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t520 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t560 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    NSNumber * t600 = [f numberFromString:[tempTariffObject valueForKey:@"T1"]];
    
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
    NSNumber *averageTariff = [NSNumber numberWithFloat:([tt1 floatValue] + [tt120 floatValue] + [tt160 floatValue] + [tt200 floatValue] + [tt240 floatValue] + [tt280 floatValue] + [tt320 floatValue] + [tt360 floatValue] + [tt400 floatValue] + [tt440 floatValue] + [tt480 floatValue] + [tt520 floatValue] + [tt560 floatValue] + [tt600 floatValue])];
    averageTariff = [NSNumber numberWithFloat:([averageTariff floatValue] / [numberOfEntries floatValue])];


    //query for jobs after graduation
    self.commonJobsPercentages = [[NSMutableArray alloc] init];
    self.commonJobs = [[NSMutableArray alloc] init];
    PFQuery *queryForGraduationJobs = [PFQuery queryWithClassName:@"Joblist"];
    [queryForGraduationJobs whereKey:@"KISCOURSEID" equalTo:self.courseCodeCourseInfo];
    [queryForGraduationJobs selectKeys:[NSArray arrayWithObjects:@"JOB",@"ORDER",@"PERC", nil]];
    [queryForGraduationJobs orderByAscending:@"ORDER"];
    [queryForGraduationJobs findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){        
        [self.commonJobs addObjectsFromArray:[objects valueForKey:@"JOB"]];
        [self.commonJobsPercentages addObjectsFromArray:[objects valueForKey:@"PERC"]];
        NSLog(@"common jobs perc: %@",self.commonJobsPercentages);
        if (objects.count == 10) {
            NSString *temp = [self.commonJobs objectAtIndex:1];
            [self.commonJobs removeObjectAtIndex:1];
            [self.commonJobs addObject:temp];
            NSString *tempPerc = [self.commonJobsPercentages objectAtIndex:1];
            [self.commonJobsPercentages removeObjectAtIndex:1];
            [self.commonJobsPercentages addObject:tempPerc];
        }
        NSLog(@"common jobs perc2: %@",self.commonJobsPercentages);
        [self.commonJobsTableView reloadData];
    }];
    
    // query for time spent/assessment methods


    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, commonJobsTableView.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,0,commonJobsTableView.bounds.size.width,22)];
   // tempLabel.backgroundColor=[UIColor clearColor];
    //tempLabel.shadowColor = [UIColor blackColor];
    //tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor whiteColor];
   // tempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSizeForHeaders];
//    tempLabel.font = [UIFont boldSystemFontOfSize:fontSizeForHeaders];
    tempLabel.text=@"Common Jobs For Graduates:";
    
    [headerView addSubview:tempLabel];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commonJobs.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"Common Jobs";
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommonJobsCustomCellView";
    
    CommonJobsCustomCellView *cell = (CommonJobsCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommonJobsCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    cell.percentageLabel.textAlignment = NSTextAlignmentLeft;
    cell.percentageLabel.text = [NSString stringWithFormat:@"%@%%",[self.commonJobsPercentages objectAtIndex:indexPath.row]];
    cell.percentageLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    cell.percentageLabel.font = [UIFont fontWithName:@"Arial" size:18];
    
    cell.jobLabel.text = [self.commonJobs objectAtIndex:indexPath.row];
    cell.jobLabel.font = [UIFont fontWithName:@"Arial" size:13];
    cell.jobLabel.textAlignment = NSTextAlignmentRight;
    cell.jobLabel.numberOfLines = 0;

    

    
    
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
