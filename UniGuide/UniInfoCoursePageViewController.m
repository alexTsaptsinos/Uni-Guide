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

@property (nonatomic, strong) NSString *studentSatisfactionPercentage;



@end

@implementation UniInfoCoursePageViewController


@synthesize uniCodeUniInfo,studentSatisfactionPercentage,tableViewUniInfo,uniInfoDataSets,haveWeComeFromUniversities,uniNameUniInfo,firstTimeLoad,uniInfoDataNumbers,universityNameLabel,scroll;

#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

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

    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.firstTimeLoad == YES) {
        
        NSLog(@"code: %@", self.uniCodeUniInfo);
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [self.view addSubview:scroll];
        scroll.showsHorizontalScrollIndicator = YES;
        scroll.scrollEnabled = YES;
        scroll.delegate = self;
        scroll.bounces = YES;
        scroll.userInteractionEnabled = YES;
        
        UIImageView *unionSatisfactionImageView = [[UIImageView alloc] init];
        UIImageView *unionSatisfactionImageViewFull = [[UIImageView alloc] init];
        unionSatisfactionImageViewFull.contentMode = UIViewContentModeTop;
        unionSatisfactionImageView.image = [UIImage imageNamed:@"ui-19emptysmall"];
        unionSatisfactionImageViewFull.image = [UIImage imageNamed:@"ui-19fillsmall"];
        [scroll addSubview:unionSatisfactionImageViewFull];
        
        UILabel *unionSatisfactionNumberLabel = [[UILabel alloc] init];
        UILabel *unionSatisfactionLabel = [[UILabel alloc] init];

        
        if (self.haveWeComeFromUniversities == YES) {
            [scroll setContentSize:CGSizeMake(320, 850)];
            tableViewUniInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 530)];
            [unionSatisfactionImageViewFull setFrame:CGRectMake(200, self.tableViewUniInfo.frame.size.height + 10.0f, 120, 182)];
            [unionSatisfactionNumberLabel setFrame:CGRectMake(220, self.tableViewUniInfo.frame.size.height + 65.0f, 50, 20)];
            [unionSatisfactionLabel setFrame:CGRectMake(20, self.tableViewUniInfo.frame.size.height + 70.0f, 150.0f, 50.0f)];
            
        }
        else if (self.haveWeComeFromUniversities == NO) {
            [scroll setContentSize:CGSizeMake(320, 890)];
            tableViewUniInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 530)];
            universityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 320, 20)];
            NSLog(@"hello alex: %@",self.uniNameUniInfo);
            universityNameLabel.text = self.uniNameUniInfo;
            universityNameLabel.textAlignment = NSTextAlignmentCenter;
            universityNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            universityNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
            [unionSatisfactionImageViewFull setFrame:CGRectMake(200, self.tableViewUniInfo.frame.size.height + 50.0f, 120, 182)];
            [unionSatisfactionNumberLabel setFrame:CGRectMake(220, self.tableViewUniInfo.frame.size.height + 105.0f, 50, 20)];
            [unionSatisfactionLabel setFrame:CGRectMake(20, self.tableViewUniInfo.frame.size.height + 110.0f, 150.0f, 50.0f)];
            [scroll addSubview:universityNameLabel];
        }
        
        tableViewUniInfo.scrollEnabled = NO;
        tableViewUniInfo.delegate = self;
        tableViewUniInfo.dataSource = self;
        tableViewUniInfo.bounces = NO;
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
        PFObject *object1 = [queryForStudentSatisfaction getFirstObject];
        studentSatisfactionPercentage = [object1 valueForKey:@"Q24"];
        unionSatisfactionNumberLabel.text = [NSString stringWithFormat:@"%@%%",studentSatisfactionPercentage];

        
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
        //NSLog(@"object: %@",numberOfBeds);
        NSNumber * totalNumberOfBeds = [numberOfBeds valueForKeyPath:@"@sum.self"];
        NSString *totalNumberOfBedsString = [totalNumberOfBeds stringValue];
        
        
        
        //calculate average cost for private accom.
        NSArray *lowerQuartileCostOfPrivateBeds = [object valueForKey:@"PRIVATELOWER"];
        NSArray *upperQuartileCostOfPrivateBeds = [object valueForKey:@"PRIVATEUPPER"];
        NSNumber *sumOfLowerQuartiles = [lowerQuartileCostOfPrivateBeds valueForKeyPath:@"@sum.self"];
        NSNumber *sumOfUpperQuartiles = [upperQuartileCostOfPrivateBeds valueForKeyPath:@"@sum.self"];
        //NSLog(@"lower quartiles sum: %@, upper quartiles sum: %@", sumOfLowerQuartiles,sumOfUpperQuartiles);
        NSNumber *sumOfQuartiles = [NSNumber numberWithFloat:([sumOfLowerQuartiles floatValue] + [sumOfUpperQuartiles floatValue])];
        //NSLog(@"sum: %@",sumOfQuartiles);
        NSNumber *totalNumberOfValues = [NSNumber numberWithFloat:(lowerQuartileCostOfPrivateBeds.count + upperQuartileCostOfPrivateBeds.count)];
        //NSLog(@"total values %@",totalNumberOfValues);
        NSNumber *averageCostOfLivingPrivate = [NSNumber numberWithFloat:([sumOfQuartiles floatValue] / [totalNumberOfValues floatValue])];
        int privateRounded = lroundf([averageCostOfLivingPrivate floatValue]);
        NSString *averageCostOfLivingPrivateString = @"£";
        averageCostOfLivingPrivateString = [averageCostOfLivingPrivateString stringByAppendingString:[NSString stringWithFormat:@"%d", privateRounded]];
        
        //calculate average cost for institute accom.
        
        NSArray *lowerQuartileCostOfInstituteBeds = [object valueForKey:@"INSTLOWER"];
        NSArray *upperQuartileCostOfInstituteBeds = [object valueForKey:@"INSTUPPER"];
        sumOfLowerQuartiles = [lowerQuartileCostOfInstituteBeds valueForKeyPath:@"@sum.self"];
        sumOfUpperQuartiles = [upperQuartileCostOfInstituteBeds valueForKeyPath:@"@sum.self"];
        //NSLog(@"lower quartiles sum: %@, upper quartiles sum: %@", sumOfLowerQuartiles,sumOfUpperQuartiles);
        sumOfQuartiles = [NSNumber numberWithFloat:([sumOfLowerQuartiles floatValue] + [sumOfUpperQuartiles floatValue])];
        //NSLog(@"sum: %@",sumOfQuartiles);
        totalNumberOfValues = [NSNumber numberWithFloat:(lowerQuartileCostOfInstituteBeds.count + upperQuartileCostOfInstituteBeds.count)];
        //NSLog(@"total values %@",totalNumberOfValues);
        NSNumber *averageCostOfLivingInstitute = [NSNumber numberWithFloat:([sumOfQuartiles floatValue] / [totalNumberOfValues floatValue])];
        int instituteRounded = lroundf([averageCostOfLivingInstitute floatValue]);
        NSString *averageCostOfLivingInstituteString = @"£";
        averageCostOfLivingInstituteString = [averageCostOfLivingInstituteString stringByAppendingString:[NSString stringWithFormat:@"%d", instituteRounded]];
        
        self.uniInfoDataNumbers = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:totalNumberOfStudents,totalNumberOfStaff,totalNumberOfBedsString,averageCostOfLivingInstituteString,averageCostOfLivingPrivateString, nil]];

        self.firstTimeLoad = NO;
    }
    else {
        
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
