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

@synthesize courseCodeStudentSatisfaction,uniCodeStudentSatisfaction,question1Label,question1ImageView;

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
    NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeStudentSatisfaction,self.uniCodeStudentSatisfaction);
    self.question1ImageView.frame = CGRectMake(13.0f, 102.0f, 129.0f, 19.0f);
    self.question2ImageView.frame = CGRectMake(13.0f, 132.0f, 129.0f, 19.0f);
    self.question3ImageView.frame = CGRectMake(13.0f, 162.0f, 129.0f, 19.0f);
    self.question4ImageView.frame = CGRectMake(13.0f, 192.0f, 129.0f, 19.0f);



    
    
    PFQuery *queryForStudentSatisfactionData = [PFQuery queryWithClassName:@"NSS"];
    [queryForStudentSatisfactionData whereKey:@"KISCOURSEID" equalTo:self.courseCodeStudentSatisfaction];
    PFObject *tempObject = [queryForStudentSatisfactionData getFirstObject];
    if (tempObject == NULL) {
        NSLog(@"this worked");
        UIImageView *noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51, 320, 429)];
        noDataImageView.backgroundColor = [UIColor lightGrayColor];
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
        noDataLabel.text = @"We're sorry, but we appear to have no data for this course.";
        noDataLabel.numberOfLines = 0;
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        [noDataImageView addSubview:noDataLabel];
        [self.view addSubview:noDataImageView];
        
    } else {
        
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


        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        // first question
        NSNumber * myNumber1 = [f numberFromString:question1];
        NSLog(@"number: %@",myNumber1);
        NSNumber *widthOfPart1Question1 = [NSNumber numberWithFloat:([myNumber1 floatValue] / 100.0f)];
        NSLog(@"divided by 100: %@",widthOfPart1Question1);
        widthOfPart1Question1 = [NSNumber numberWithFloat:([widthOfPart1Question1 floatValue] * self.question1ImageView.frame.size.width)];
        NSLog(@"width of part 1: %@",widthOfPart1Question1);
        UIImageView *part1Question1 = [[UIImageView alloc] init];
        part1Question1.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1Question1 floatValue], self.question1ImageView.frame.size.height);
        part1Question1.backgroundColor = [UIColor greenColor];
        [self.question1ImageView addSubview:part1Question1];
        NSNumber *widthOfPart2Question1 = [NSNumber numberWithFloat:(self.question1ImageView.frame.size.width - [widthOfPart1Question1 floatValue])];
        UIImageView *part2Question1 = [[UIImageView alloc] init];
        part2Question1.frame = CGRectMake(part1Question1.frame.size.width, 0, [widthOfPart2Question1 floatValue], self.question1ImageView.frame.size.height);
        part2Question1.backgroundColor = [UIColor redColor];
        [self.question1ImageView addSubview:part2Question1];
        UILabel *question1percentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, self.question1ImageView.frame.size.height)];
        question1percentage.text = [NSString stringWithFormat:@"%@%%",question1];
        question1percentage.font = [UIFont fontWithName:@"Arial" size:14];
        [self.question1ImageView addSubview:question1percentage];
        
        // second question
        NSNumber * myNumber2 = [f numberFromString:question2];
        NSNumber *widthOfPart1Question2 = [NSNumber numberWithFloat:([myNumber2 floatValue] / 100.0f)];
        widthOfPart1Question2 = [NSNumber numberWithFloat:([widthOfPart1Question2 floatValue] * self.question2ImageView.frame.size.width)];
        UIImageView *part1Question2 = [[UIImageView alloc] init];
        part1Question2.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1Question2 floatValue], self.question2ImageView.frame.size.height);
        part1Question2.backgroundColor = [UIColor greenColor];
        [self.question2ImageView addSubview:part1Question2];
        NSNumber *widthOfPart2Question2 = [NSNumber numberWithFloat:(self.question2ImageView.frame.size.width - [widthOfPart1Question2 floatValue])];
        UIImageView *part2Question2 = [[UIImageView alloc] init];
        part2Question2.frame = CGRectMake(part1Question2.frame.size.width, 0, [widthOfPart2Question2 floatValue], self.question2ImageView.frame.size.height);
        part2Question2.backgroundColor = [UIColor redColor];
        [self.question2ImageView addSubview:part2Question2];
        UILabel *question2percentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, self.question2ImageView.frame.size.height)];
        question2percentage.text = [NSString stringWithFormat:@"%@%%",question2];
        question2percentage.font = [UIFont fontWithName:@"Arial" size:14];
        [self.question2ImageView addSubview:question2percentage];
        
        // third question
        NSNumber * myNumber3 = [f numberFromString:question3];
        NSNumber *widthOfPart1Question3 = [NSNumber numberWithFloat:([myNumber3 floatValue] / 100.0f)];
        widthOfPart1Question3 = [NSNumber numberWithFloat:([widthOfPart1Question3 floatValue] * self.question3ImageView.frame.size.width)];
        UIImageView *part1Question3 = [[UIImageView alloc] init];
        part1Question3.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1Question3 floatValue], self.question3ImageView.frame.size.height);
        part1Question3.backgroundColor = [UIColor greenColor];
        [self.question3ImageView addSubview:part1Question3];
        NSNumber *widthOfPart2Question3 = [NSNumber numberWithFloat:(self.question3ImageView.frame.size.width - [widthOfPart1Question3 floatValue])];
        UIImageView *part2Question3 = [[UIImageView alloc] init];
        part2Question3.frame = CGRectMake(part1Question3.frame.size.width, 0, [widthOfPart2Question3 floatValue], self.question3ImageView.frame.size.height);
        part2Question3.backgroundColor = [UIColor redColor];
        [self.question3ImageView addSubview:part2Question3];
        UILabel *question3percentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, self.question3ImageView.frame.size.height)];
        question3percentage.text = [NSString stringWithFormat:@"%@%%",question3];
        question3percentage.font = [UIFont fontWithName:@"Arial" size:14];
        [self.question3ImageView addSubview:question3percentage];
        
        // fourth question
        NSNumber * myNumber4 = [f numberFromString:question4];
        NSNumber *widthOfPart1Question4 = [NSNumber numberWithFloat:([myNumber4 floatValue] / 100.0f)];
        widthOfPart1Question4 = [NSNumber numberWithFloat:([widthOfPart1Question4 floatValue] * self.question4ImageView.frame.size.width)];
        UIImageView *part1Question4 = [[UIImageView alloc] init];
        part1Question4.frame = CGRectMake(0.0f, 0.0f, [widthOfPart1Question4 floatValue], self.question4ImageView.frame.size.height);
        part1Question4.backgroundColor = [UIColor greenColor];
        [self.question4ImageView addSubview:part1Question4];
        NSNumber *widthOfPart2Question4 = [NSNumber numberWithFloat:(self.question4ImageView.frame.size.width - [widthOfPart1Question4 floatValue])];
        UIImageView *part2Question4 = [[UIImageView alloc] init];
        part2Question4.frame = CGRectMake(part1Question4.frame.size.width, 0, [widthOfPart2Question4 floatValue], self.question4ImageView.frame.size.height);
        part2Question4.backgroundColor = [UIColor redColor];
        [self.question4ImageView addSubview:part2Question4];
        UILabel *question4percentage = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 50.0f, self.question4ImageView.frame.size.height)];
        question4percentage.text = [NSString stringWithFormat:@"%@%%",question4];
        question4percentage.font = [UIFont fontWithName:@"Arial" size:14];
        [self.question4ImageView addSubview:question4percentage];
        
    }
    
    
    
    // self.question1ImageView.backgroundColor = [uic]
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
