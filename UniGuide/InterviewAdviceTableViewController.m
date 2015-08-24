//
//  InterviewAdviceTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "InterviewAdviceTableViewController.h"

@interface InterviewAdviceTableViewController ()

@end

@implementation InterviewAdviceTableViewController

@synthesize index,cellHeights,titlesArray,textArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    if (index == 0) {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Know what's coming",@"Research research research",@"Get personal again",@"Practice makes",@"Get a good sleep", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"Make sure you know the basics. Where is it taking place, what time do you have to be there and sort out accommodation if you need it. Then find out what form the interview will take - it could be a formal interview, an audition or simply a meeting to confirm their offer to you.",@"Read the course webpage and get to know how it is structured, what you will study and the areas that the lecturers specialise in. Keep up to date with the latest in your subject by reading a couple of journals or newspaper articles related to the course - tutors may be interested in your views on current affairs or developments in the field. Prepare material that you know you want to talk about and map out answers to commonly asked questions, for example - why this course, why this university etc.",@"Your personal statement is what they know about you thus far so expect them to ask questions from it - give it another read! It may have been a while since you wrote it and you might be blurry on material you claim to have read or things you've done, so brush up to avoid getting caught out. Think about the kind of questions they could ask from your PS and construct rough answers to them.",@"Ask a teacher, parent or friend to prepare a mock interview with you and go through exactly as you think it might go on the day. Afterwards discuss and analyse with them how you think you did and what you could have improved on. Practice speaking in the mirror although beware of overpracticing as tutors don't want to hear a rehearsed answer.",@"Don't panic the night before, make sure you go to bed early and have a plentiful rest before the interview. Give yourself plenty of time to get there and plan to arrive well early. There's nothing worse than arriving in a stress and panic since you've had to rush - you can always sit in a nearby cafe and go over what you've perpared.", nil];
    } else if (index == 1) {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Look the part",@"Enthusiasm above all",@"Be honest",@"Don't be a robot",@"Relax and be you", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"Don't turn up looking like a scruff as it will work against you. You don't have to come in a suit but arriving dressed smartly will show that you are taking it seriously.",@"As well as judging your academic ability, tutors are also looking to see if you are the type of student that they could work with and teach. They'll want to work with a student who is excited by and interested in their course so try and get this across in the interview. Keep good body language throughout by sitting well without slouching and keeping eye contact - don't yawn or fold your arms as these will tell the tutor you aren't interested.",@"The tutors may ask a question that you simply don't know the answer to, in fact, it's quite likely! Don't try and bluff out answers since you are talking to people who are experts in their field and they will see through it. They're looking for how you react when you are presented with something you are unfamiliar with, try and breakdown what they have said and offer opinions on what you think they've said. If you are completely lost then be honest and ask for the tutor to repeat or rephrase the question, then try and relate it to something you do know about.",@"When they ask a question don't just answer in the question in a single sentence. The tutors are looking to create a discussion with you not a Q&A session. Expand on the points you make and try to ask them a few questions back as well, this will not only make you look better but it will make the whole experience much more enjoyable.",@"Tutors expect you to be nervous and will do their best to try and make you feel welcome. Turn your phone off to avoid any distractions and listen carefully. When a question is asked take your time and think about what they're asking and how best to answer it rather than blurting the first thing that comes to mind. Above all, try and be yourself and answer how you would, rather than trying to answer how you think they want you to.", nil];
        
    } else {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Breathe",@"Keep a track",@"Explore",@"Kick back, relax", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"Phew, it's done! Don't worry if you found it hard or think you did badly - the interviews are designed to be hard and stretch candidates. Take a few moments straight after too destress and chill and then when you're ready you can continue with the below.",@"Write down what questions you were asked and reflect on how you answered, writing down what you've learned from the interview. This will come in handy if you have other interviews as you can decide what worked and how you could better answer the questions next time.",@"Don't head off straight away. Take the chance to explore the university and surrounding areas to see what it's like - you could even test out some of the local pubs! If you see any students then try and ask them a few questions to find out what it's like to go to university there.",@"Try not to worry about whether you will be offered a place or not, there's nothing you can do now to change the result. Either prepare for your next interview or enjoy yourself. The next fun part will come around soon enough - getting the grades!", nil];
    }
    
    
    self.cellHeights = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < textArray.count; i++) {
        UILabel * temp = [[UILabel alloc] initWithFrame: CGRectMake(7, 0, self.view.frame.size.width - 14, self.view.frame.size.height)];
        temp.font = [UIFont fontWithName:@"Arial" size:14];
        temp.lineBreakMode = NSLineBreakByWordWrapping;
        temp.numberOfLines = 0;
        temp.text = [textArray objectAtIndex:i];
        CGFloat lineHeight = temp.font.lineHeight;
        CGFloat lines = (temp.text.length / 49.0f) * lineHeight;
        CGFloat height = lines + 75.0f; //adding some padding
        
        [self.cellHeights addObject:[NSNumber numberWithFloat:height]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *cellTitleLabel = [[UILabel alloc] init];
    cellTitleLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    cellTitleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:22];
    cellTitleLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    
    UILabel *cellTextLabel = [[UILabel alloc] init];
    cellTextLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cellTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cellTextLabel.numberOfLines = 0;
    cellTextLabel.text = [textArray objectAtIndex:indexPath.row];
    cellTextLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    
    if (indexPath.row % 2) {
        cellTitleLabel.frame = CGRectMake(7, 7, widthFloat-14, 25);
        cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        cellTextLabel.frame = CGRectMake(7, 35, self.view.frame.size.width - 14, [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 55);
        cellTextLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        cellTitleLabel.frame = CGRectMake(7, 7, widthFloat-14, 25);
        cellTitleLabel.textAlignment = NSTextAlignmentRight;
        cellTextLabel.frame = CGRectMake(7, 35, self.view.frame.size.width - 14, [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 55);
        cellTextLabel.textAlignment = NSTextAlignmentRight;
    }
    [cell addSubview:cellTitleLabel];
    [cell addSubview:cellTextLabel];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"heights: %@",self.cellHeights);
    return [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,0,self.view.bounds.size.width-10,headerView.frame.size.height)];
    
    tempLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    tempLabel.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    if (index == 0) {
        tempLabel.text = @"Before";
    } else if (index == 1) {
        tempLabel.text = @"During";
    } else if (index == 2) {
        tempLabel.text = @"After";
    }
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(5.0f, headerView.frame.size.height-3.0f, headerView.frame.size.width - 10.0f, 3.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f].CGColor;//[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}


@end
