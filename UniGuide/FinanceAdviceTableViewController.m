//
//  FinanceAdviceTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "FinanceAdviceTableViewController.h"

@interface FinanceAdviceTableViewController ()

@end

@implementation FinanceAdviceTableViewController

@synthesize titlesArray,textArray,cellHeights;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Student Finance";
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    self.titlesArray = [[NSArray alloc] initWithObjects:@"Loans",@"There's more support",@"Get the right account",@"Budget",@"Use it wisely", nil];
    self.textArray = [[NSArray alloc] initWithObjects:@"It costs a lot of money to go to university and hence is a big investment. The government, however, provide student loans through the Student Loans Company. From 2016 there will be two available, a Tuition Fee loan which will cover the tuition fees and a Maintenance Loan which will help cover the cost of living. Do your research from the SLC website and find out what your repayments may be using their calculator and remember that you'll need to reapply each year for the loans.",@"Sometimes the loans won't cover it and you may not be able to afford it. If you are in this situation then you could be eligible for extra help such as scholarships, bursaries or other financial support. Most institutions will offer packages to help out if you are struggling financially and there are often several central bursaries available to apply for.",@"Most banks will offer students favourable current accounts with large interest free overdrafts and signing on deals. Don't go for the first bank you see, look around and find the best deal for you. Even though you have this large overdraft make sure you pay it off before you finish uni - your account will turn into a regular current account with not so favourable overdrafts.",@"Before you even start university, draw up a weekly budget and do your best to stick it. If it's not working then reassess and draw up another one. Check your bank account regularly so that you can identify if there are any major problems arising. Understand how credit works and your overdraft for your bank account before you go into it and always ask yourself before you buy anything - can you really afford it and do you absolutely need it.",@"Being a student does have its advantages with lots of retailers offering student discounts. If you're going to use the train a lot then you could save a lot of money with a railcard and NUS offer their discount card for a cost. Don't buy books as most universities will have large libraries where you can borrow them for free and if you do need to buy something, look for it second hand. Buy in bulk with friends to save money and luckily your TV License will be covered if you are watchin on an unplugged laptop at university!", nil];
    
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


@end
