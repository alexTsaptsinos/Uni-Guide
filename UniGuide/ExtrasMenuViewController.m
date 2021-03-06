//
//  ExtrasMenuViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "ExtrasMenuViewController.h"

@interface ExtrasMenuViewController ()

@end

@implementation ExtrasMenuViewController

@synthesize packingListButton,leaveFeedbackButton,personalStatementButton,interviewAdviceButton,studentFinanceButton,courseGeneratorButton,quoteLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Extras";
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    // SET UP BUTTONS
    self.packingListButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [packingListButton addTarget:self
                          action:@selector(packingListButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    packingListButton.frame = CGRectMake(0, 0, widthFloat/2, heightFloat/4);
    self.packingListButton.exclusiveTouch = YES;
    [packingListButton setTitle:@"Packing List" forState:UIControlStateNormal];
    [packingListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[packingListButton layer] setBorderWidth:7.0f];
    [[packingListButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:packingListButton];
    self.packingListButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    CALayer *btnLayer = [packingListButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.leaveFeedbackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leaveFeedbackButton addTarget:self
                          action:@selector(leaveFeedbackButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    leaveFeedbackButton.frame = CGRectMake(widthFloat/2, heightFloat/2, widthFloat/2, heightFloat/4);
    self.leaveFeedbackButton.exclusiveTouch = YES;
    [leaveFeedbackButton setTitle:@"Useful Websites" forState:UIControlStateNormal];
    [leaveFeedbackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[leaveFeedbackButton layer] setBorderWidth:7.0f];
    [[leaveFeedbackButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:leaveFeedbackButton];
    self.leaveFeedbackButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [leaveFeedbackButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.personalStatementButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [personalStatementButton addTarget:self
                          action:@selector(personalStatementButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    personalStatementButton.frame = CGRectMake(widthFloat/2, heightFloat/4, widthFloat/2, heightFloat/4);
    self.personalStatementButton.exclusiveTouch = YES;
    [personalStatementButton setTitle:@"Personal Statement Tips" forState:UIControlStateNormal];
    personalStatementButton.titleLabel.numberOfLines = 2;
    personalStatementButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [personalStatementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[personalStatementButton layer] setBorderWidth:7.0f];
    [[personalStatementButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:personalStatementButton];
    self.personalStatementButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [personalStatementButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.interviewAdviceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [interviewAdviceButton addTarget:self
                          action:@selector(interviewAdviceButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    interviewAdviceButton.frame = CGRectMake(0, heightFloat/4, widthFloat/2, heightFloat/4);
    self.interviewAdviceButton.exclusiveTouch = YES;
    [interviewAdviceButton setTitle:@"Interview Advice" forState:UIControlStateNormal];
    [interviewAdviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[interviewAdviceButton layer] setBorderWidth:7.0f];
    [[interviewAdviceButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:interviewAdviceButton];
    self.interviewAdviceButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [interviewAdviceButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.studentFinanceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [studentFinanceButton addTarget:self
                          action:@selector(studentFinanceButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    studentFinanceButton.frame = CGRectMake(widthFloat/2, 0, widthFloat/2, heightFloat/4);
    self.studentFinanceButton.exclusiveTouch = YES;
    [studentFinanceButton setTitle:@"Student Finance" forState:UIControlStateNormal];
    [studentFinanceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[studentFinanceButton layer] setBorderWidth:7.0f];
    [[studentFinanceButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:studentFinanceButton];
    self.studentFinanceButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [studentFinanceButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.courseGeneratorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [courseGeneratorButton addTarget:self
                          action:@selector(courseGeneratorButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    courseGeneratorButton.frame = CGRectMake(0, heightFloat/2, widthFloat/2, heightFloat/4);
    self.courseGeneratorButton.exclusiveTouch = YES;
    [courseGeneratorButton setTitle:@"Course Generator" forState:UIControlStateNormal];
    [courseGeneratorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[courseGeneratorButton layer] setBorderWidth:7.0f];
    [[courseGeneratorButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:courseGeneratorButton];
    self.courseGeneratorButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [courseGeneratorButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.quoteLabel = [[UILabel alloc] init];
    quoteLabel.frame = CGRectMake(0, heightFloat*3/4, widthFloat, heightFloat/4);
    //quoteLabel.text = @"Don't listen to them.\n You just need to keep trying.\n\n - Mike (Monsters University)";
    quoteLabel.textAlignment = NSTextAlignmentCenter;
    quoteLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    quoteLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    quoteLabel.numberOfLines = 4;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Don't listen to them.\n You just need to keep trying.\n\n - Mike (Monsters University)"];
    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Baskerville-Bold" size:16] range:NSMakeRange(52, 31)];
    [quoteLabel setAttributedText:text];
    [self.view addSubview:quoteLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)packingListButtonClicked:(UIButton*)button
{
    PackingListTableViewController *packingListTableViewController = [[PackingListTableViewController alloc] initWithNibName:@"PackingListTableViewController" bundle:nil];
    [self.navigationController pushViewController:packingListTableViewController animated:YES];
}

- (void)leaveFeedbackButtonClicked:(UIButton*)button
{
    NSString * appId = @"913590904";
    NSString * theUrl = [NSString  stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appId];
    if ([[UIDevice currentDevice].systemVersion integerValue] > 6) {
        //theUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
        theUrl = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",appId];
        
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
}

- (void)personalStatementButtonClicked:(UIButton*)button
{
    PersonalStatementAdviceViewController *personalStatementAdviseViewController = [[PersonalStatementAdviceViewController alloc] initWithNibName:@"PersonalStatementAdviceViewController" bundle:nil];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [self.navigationController pushViewController:personalStatementAdviseViewController animated:YES];
    
}

- (void)interviewAdviceButtonClicked:(UIButton*)button
{
    InterviewAdviceViewController *interviewAdviceViewController = [[InterviewAdviceViewController alloc] initWithNibName:@"InterviewAdviceViewController" bundle:nil];
    [self.navigationController pushViewController:interviewAdviceViewController animated:YES];
}

- (void)studentFinanceButtonClicked:(UIButton*)button
{
    FinanceAdviceTableViewController *financeAdviceTableViewController = [[FinanceAdviceTableViewController alloc] initWithNibName:@"FinanceAdviceTableViewController" bundle:nil];
    [self.navigationController pushViewController:financeAdviceTableViewController animated:YES];
}

- (void)courseGeneratorButtonClicked:(UIButton*)button
{
    CourseGeneratorViewController *courseGeneratorViewController = [[CourseGeneratorViewController alloc] initWithNibName:@"CourseGeneratorViewController" bundle:nil];
    [self.navigationController pushViewController:courseGeneratorViewController animated:YES];
}



@end
