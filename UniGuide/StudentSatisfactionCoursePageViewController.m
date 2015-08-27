//
//  StudentSatisfactionCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "StudentSatisfactionCoursePageViewController.h"
#import "CourseInfoCoursePageViewController.h"
#import "SearchResultsTableViewController.h"

@interface StudentSatisfactionCoursePageViewController ()

@end

@implementation StudentSatisfactionCoursePageViewController

@synthesize courseCodeStudentSatisfaction,uniCodeStudentSatisfaction,questionResults,tableViewStudentSatisfaction,universityNameLabel,courseNameLabel,uniNameStudentSatisfaction,firstTimeLoad,courseNameStudentSatisfaction,activityIndicator,sourceLabel,descriptionLabel,noInternetLabel,noInternetImageView,haveComeFromFavourites;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Student Satisfaction", @"Student Satisfaction");
        self.tabBarItem.image = [UIImage imageNamed:@"student2-32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeStudentSatisfaction,self.uniCodeStudentSatisfaction);
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    self.tableViewStudentSatisfaction = [[UITableView alloc] init];
    self.tableViewStudentSatisfaction.frame = CGRectMake(0, 90, screenBound.size.width, screenBound.size.height - 90 - self.tabBarController.tabBar.frame.size.height - 64);
    self.tableViewStudentSatisfaction.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    tableViewStudentSatisfaction.delegate = self;
    tableViewStudentSatisfaction.dataSource = self;
    tableViewStudentSatisfaction.bounces = YES;
    tableViewStudentSatisfaction.scrollEnabled = YES;
    tableViewStudentSatisfaction.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:tableViewStudentSatisfaction];
    
    self.firstTimeLoad = YES;
    self.courseNameLabel.hidden = YES;
    self.universityNameLabel.hidden = YES;
    self.sourceLabel.hidden = YES;
    self.descriptionLabel.hidden = YES;
    self.tableViewStudentSatisfaction.hidden = YES;
    [self.activityIndicator startAnimating];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.noInternetImageView.hidden = YES;
    self.noInternetLabel.hidden = YES;
    [self.activityIndicator startAnimating];
    
    if (self.firstTimeLoad == YES) {
        
        universityNameLabel.frame = CGRectMake(0, 2, 320, 30);
        universityNameLabel.text = self.uniNameStudentSatisfaction;
        universityNameLabel.textAlignment = NSTextAlignmentCenter;
        universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
        universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
        
        courseNameLabel.frame = CGRectMake(0, 22, 320, 30);
        courseNameLabel.text = self.courseNameStudentSatisfaction;
        courseNameLabel.textAlignment = NSTextAlignmentCenter;
        courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        courseNameLabel.adjustsFontSizeToFitWidth = YES;
        courseNameLabel.numberOfLines = 0;
        
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeStudentSatisfaction,self.uniCodeStudentSatisfaction] andSortKey:@"courseName"];
        

        
        if (temp2.count != 0) {
            // CAN LOAD FROM FAVOURITES!!
            Favourites *tempObject = [temp2 objectAtIndex:0];
            
            self.questionResults = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:tempObject.nSSScores]];
            if (self.questionResults.count == 0) {
                UIImageView *noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 429)];
                noDataImageView.backgroundColor = [UIColor lightGrayColor];
                UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noDataLabel.text = @"We're sorry, but we appear to have no data for this course.";
                noDataLabel.numberOfLines = 0;
                noDataLabel.textAlignment = NSTextAlignmentCenter;
                [noDataImageView addSubview:noDataLabel];
                [self.view addSubview:noDataImageView];
            }
            
            self.firstTimeLoad = NO;
            
            [self.tableViewStudentSatisfaction reloadData];
            
            self.courseNameLabel.hidden = NO;
            self.universityNameLabel.hidden = NO;
            self.sourceLabel.hidden = NO;
            self.descriptionLabel.hidden = NO;
            self.tableViewStudentSatisfaction.hidden = NO;
            [self.activityIndicator stopAnimating];
        } else {
        
        PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
        [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeStudentSatisfaction];
        [queryForStudentSatisfactionData whereKey:@"UKPRN" equalTo:self.uniCodeStudentSatisfaction];
        [queryForStudentSatisfactionData findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                //NSArray *tempObject = [objects objectAtIndex:0];
                NSLog(@"objects: %@",objects);
                if (objects.count == 0) {
                    //  NSLog(@"this worked");
                    UIImageView *noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 429)];
                    noDataImageView.backgroundColor = [UIColor lightGrayColor];
                    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                    noDataLabel.text = @"We're sorry, but we appear to have no data for this course.";
                    noDataLabel.numberOfLines = 0;
                    noDataLabel.textAlignment = NSTextAlignmentCenter;
                    [noDataImageView addSubview:noDataLabel];
                    [self.view addSubview:noDataImageView];
                    
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
                    
                    self.questionResults = [[NSMutableArray alloc] initWithObjects:question1,question2,question3,question4,question5,question6,question7,question8,question9,question10,question11,question12,question13,question14,question15,question16,question17,question18,question19,question20,question21,question22, nil];
                    
                }
                self.firstTimeLoad = NO;
                
                [self.tableViewStudentSatisfaction reloadData];
                
                self.courseNameLabel.hidden = NO;
                self.universityNameLabel.hidden = NO;
                self.sourceLabel.hidden = NO;
                self.descriptionLabel.hidden = NO;
                self.tableViewStudentSatisfaction.hidden = NO;
                [self.activityIndicator stopAnimating];
            }
            else {
                NSLog(@"error no internet");
                universityNameLabel.frame = CGRectMake(0, 2, 320, 30);
                universityNameLabel.text = self.uniNameStudentSatisfaction;
                universityNameLabel.textAlignment = NSTextAlignmentCenter;
                universityNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
                universityNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
                
                courseNameLabel.frame = CGRectMake(0, 22, 320, 30);
                courseNameLabel.text = self.courseNameStudentSatisfaction;
                courseNameLabel.textAlignment = NSTextAlignmentCenter;
                courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
                courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                courseNameLabel.adjustsFontSizeToFitWidth = YES;
                courseNameLabel.numberOfLines = 0;
                
                self.courseNameLabel.hidden = NO;
                self.universityNameLabel.hidden = NO;
                self.sourceLabel.hidden = NO;
                self.descriptionLabel.hidden = NO;
                [self.activityIndicator stopAnimating];
                
                noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 429)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
            }
        }];
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionResults.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"StudentSatisfactionCustomCellView";
    StudentSatisfactionCustomCellView *cell = (StudentSatisfactionCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentSatisfactionCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSArray *questionNames = [[NSArray alloc] initWithObjects:@"Staff are good at explaining things",@"Staff have made the subject interesting",@"Staff are enthusiastic about what they are teaching",@"The course is intellectually stimulating",@"The criteria used in marking have been clear in advance",@"Assessment arrangements and marking have been fair",@"Feedback on my work has been promt",@"I have received detailed comments on my work",@"Feedback on my work has helped me clarify things I did not understand",@"I have received sufficient advice and support with my studies",@"I have been able to contact staff when I needed to",@"Good advice was available when I needed to make study choices",@"The timetable works efficiently as far as my activities are concerned",@"Any changes in the course or teaching have been communicated effectively",@"The course is well organised and is running smoothly",@"The library resources and services are good enough for my needs",@"I have been able to access general IT resources when I needed to",@"I have been able to access specialised equipment, facilities or rooms when I needed to",@"The course has helped me present myself with confidence",@"My communication skills have improved",@"As a results of the course, I feel confident in tackling unfamiliar problems",@"Overall, I am satisfied with the quality of the course", nil];
    cell.questionLabel.text =[questionNames objectAtIndex:indexPath.row];
    cell.questionLabel.numberOfLines = 0;
    cell.questionLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber * myNumber = [f numberFromString:[self.questionResults objectAtIndex:indexPath.row]];
    //  NSLog(@"number: %@",myNumber);
    
    NSNumber *widthOfPart1 = [NSNumber numberWithFloat:([myNumber floatValue] / 100.0f)];
    // NSLog(@"divided by 100: %@",widthOfPart1);
    widthOfPart1 = [NSNumber numberWithFloat:([widthOfPart1 floatValue] * cell.questionImageView.frame.size.width)];
    //  NSLog(@"width of part 1: %@",widthOfPart1);
    UIImageView *part1 = [[UIImageView alloc] init];
    part1.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1 floatValue], cell.questionImageView.frame.size.height);
    part1.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
    [cell.questionImageView addSubview:part1];
    NSNumber *widthOfPart2 = [NSNumber numberWithFloat:(cell.questionImageView.frame.size.width - [widthOfPart1 floatValue])];
    UIImageView *part2 = [[UIImageView alloc] init];
    part2.frame = CGRectMake(part1.frame.size.width, 0, [widthOfPart2 floatValue], cell.questionImageView.frame.size.height);
    part2.backgroundColor = [UIColor colorWithRed:203.0f/255.0f green:83.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [cell.questionImageView addSubview:part2];
    UILabel *questionPercentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, cell.questionImageView.frame.size.height)];
    questionPercentage.text = [NSString stringWithFormat:@"%@%%",[self.questionResults objectAtIndex:indexPath.row]];
    questionPercentage.font = [UIFont fontWithName:@"Arial" size:14];
    questionPercentage.textColor = [UIColor whiteColor];
    [cell.questionImageView addSubview:questionPercentage];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
