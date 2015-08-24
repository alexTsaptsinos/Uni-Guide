//
//  PSAdviceTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 16/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "PSAdviceTableViewController.h"

@interface PSAdviceTableViewController ()

@end

@implementation PSAdviceTableViewController

@synthesize index,titlesArray,textArray,cellHeights;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    if (index == 0) {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Use a plan",@"Make it personal",@"Keep it concise",@"Stand out",@"Take your time", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"There's no need to rush straight into writing it. First make a list of all things that could possibly be mentioned in the personal statement, this includes: responsibilities, work experience, voluntary work, A levels, sport, travels, hobbies, and other interests. Then, with this list, try and map out a rough structure for the PS ensuring that it contains a nice flow.",@"Understand that you are writing a letter to another person, not a computer. You want this letter to sound natural and like you, expressing your thoughts and opinions while keeping it upbeat and enthusiastic. Don't overcomplicate it by reaching for the thesaurus at every word as this will turn your PS very stilted and disjointed. However, beware of overusing the word 'I', especially at the start of sentences as it can easily become repetitive - try and think of other phrases that could convey what you are trying to say.",@"You only have 47 lines and 4000 characters (including spaces) to get across what you want to say. Therefore try and avoid waffling or skirting around  a point that you want to raise. You won't need to explain to tutors parts of their subject, moreover it could come across as patronising! Keep in mind what you want each paragraph to say and make sure it says it without diverging too much as this will lose the readers interest.",@"Tutors will be reading hundred of statements so you need to think, what make you so different? Try and include things you've done that you think few other people will have and play around with the structure, tutors don't want to read the same formulaic approach to a PS every time. Beware with humour, it is extremely risky since you don't know whether the tutor will have the same sense of humour as you and it could backfire.",@"It doesn't have to all be written in one sitting. In a word processor, work on bits at a time, even if you know what you're writing down won't be the final product, write something down which you can then improve on later. Once you've written a first draft leave it for a day or two, then come back and scrutinise it thoroughly. Re-write and produce several drafts until you think you've found something that works. Show this to parents, teachers and anyone who'll read it for advice and to check grammar - try reading it out loud and seeing if it sounds good spoken. Finally make sure you spellcheck it and give it a final read over to check for any errors.", nil];
    } else if (index == 1) {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Do your research",@"Why this course?",@"You're right for it",@"Make it relevant",@"Be a critic", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"Show tutors that you have read up and understand the course you are applying for. Demonstrate that you know what studying the course at a university level will entail and that you are well prepared for this. The tutor will appreciate seeing this commitment to your course and it will act in your favour.",@"The most important question of all - if you're PS doesn't answer this, then you have a big problem. You should spend at least a paragraph explaining where this interest developed, how you have acted upon the interest and why you then want to further this interest at university. Try and pick out specific examples from the course that you enjoy rather than broadly claiming you love the whole subject.",@"So you've said why you like the course, but there are hundreds of other applicants who also like it - why should the tutor pick you to do it? Previously you've mentioned specific examples in the course you like, why not conjecture further what you want to learn more from and then where you will use this knowledge. This isn't the time to say you're a hard worker, rather explain what you would work hard over!",@"Roughly two-thirds of the PS should be about the course and subject, however, this doesn't mean that the rest should completely ignore the course. Remember, the point of the PS is to show a tutor why they should pick you for their course. Give specific examples of what you've done outside of the classroom that's relevant to your course and demonstrate transferrable skills whenever you mention a hobby.",@"If you mention a book you've read, some research you've done outside the classroom or even a project you did for school then give your opinion on what you thought about it. The tutors are looking for critical thinking so show them that you can disect a piece of information - this is what they will be expecting you to do at university with them.", nil];
        
    } else {
        self.titlesArray = [[NSArray alloc] initWithObjects:@"Make it yourself",@"Avoid clichés",@"If you ain't done it...",@"Don't quote others",@"Leave the lists", nil];
        self.textArray = [[NSArray alloc] initWithObjects:@"Do not plagiarise. UCAS will run your personal statemtent through software which will thoroughly check for this and then universities will be told if you have copied from elsewhere. By all means read others to get an idea but write everything in your own words.",@"Tutors notice when the same sentences or phrases come up and it makes you look bad if you use one of them. Check the most used phrases and stay from using 'From a young age...' or 'For as long as I can remember...'. Avoid using 'passion' as it is an overused word every year - there are always other ways of phrasing what you are trying to say.",@"... don't say you have! This includes books you say you've read, hobbies you mention or qualifications you claim to have. The rule to go by is that if you couldn't answer questions on it in an interview then don't talk about it in your PS.",@"As wise and well versed as Nietzsche was it won't do your application any good by including his quotes. The tutors want to hear what you have to say not someone else.",@"You may have read many books, but writing them all down in a long list will bore the tutor. Try picking out a couple of them and going into a bit more detail about what you thought or learned from them. The same goes for work experience placements, places you've visited or positions you've held - remember quality over quantity.", nil];
        
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
        cellTitleLabel.frame = CGRectMake(7, 7, 215, 25);
        cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        cellTextLabel.frame = CGRectMake(7, 35, self.view.frame.size.width - 14, [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 55);
        cellTextLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        cellTitleLabel.frame = CGRectMake(98, 7, 215, 25);
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
        tempLabel.text = @"How to write it";
    } else if (index == 1) {
        tempLabel.text = @"What to write";
    } else if (index == 2) {
        tempLabel.text = @"What not to write";
    }
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(5.0f, headerView.frame.size.height-3.0f, headerView.frame.size.width - 10.0f, 3.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f].CGColor;//[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

@end
