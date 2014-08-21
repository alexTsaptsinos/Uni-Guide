//
//  ReviewsCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewsCoursePageViewController.h"
#import "AddReviewViewController.h"
#import "ReviewComplaintViewController.h"

@interface ReviewsCoursePageViewController ()

@end

@implementation ReviewsCoursePageViewController

@synthesize addReviewButton,courseCodeReviews,uniCodeReviews,courseNameReviews,numberOfReviewsLabel,reviewersNames,reviewStars,reviewTexts,reviewTitles,reviewTableView,reviewDates,reviewersYears,cellHeights,haveDoneParseQueryYet,starButton1,starButton2,starButton3,starButton4,starButton5,reviewCodes,haveReloadedHeights,uniNameLabel,courseNameLabel,uniNameReviews,firstTimeLoad,activityIndicator,noInternetLabel,noInternetImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Reviews", @"Reviews");
        self.tabBarItem.image = [UIImage imageNamed:@"talk-32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    //self.behindStarsImageView.backgroundColor = [UIColor yellowColor];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    self.reviewTableView = [[UITableView alloc] init];
    self.reviewTableView.frame = CGRectMake(0, 90, 320, screenBound.size.height - 90 - self.tabBarController.tabBar.frame.size.height - 64);
    self.reviewTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    reviewTableView.delegate = self;
    reviewTableView.dataSource = self;
    reviewTableView.bounces = YES;
    reviewTableView.scrollEnabled = YES;
    reviewTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:reviewTableView];
    
    self.haveDoneParseQueryYet = NO;
    self.haveReloadedHeights = NO;
    
    self.reviewTableView.hidden = YES;
    self.courseNameLabel.hidden = YES;
    self.uniNameLabel.hidden = YES;
    self.addReviewButton.hidden = YES;
    self.starButton1.hidden = YES;
    self.starButton2.hidden = YES;
    self.starButton3.hidden = YES;
    self.starButton4.hidden = YES;
    self.starButton5.hidden = YES;
    self.numberOfReviewsLabel.hidden = YES;
    [self.activityIndicator startAnimating];
    
    
    self.addReviewButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.addReviewButton.titleLabel.textColor = [UIColor whiteColor];
    
    uniNameLabel.frame = CGRectMake(0, 2, 320, 30);
    uniNameLabel.text = self.uniNameReviews;
    uniNameLabel.textAlignment = NSTextAlignmentCenter;
    uniNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    uniNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
    
    courseNameLabel.frame = CGRectMake(0, 22, 320, 30);
    courseNameLabel.text = self.courseNameReviews;
    courseNameLabel.textAlignment = NSTextAlignmentCenter;
    courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    courseNameLabel.adjustsFontSizeToFitWidth = YES;
    courseNameLabel.numberOfLines = 0;
    self.firstTimeLoad = YES;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reviewTitles.count;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.addReviewButton.titleLabel.textColor = [UIColor whiteColor];
    if (self.reviewTableView.hidden == YES) {
        self.addReviewButton.frame = CGRectMake(100.0f, 100.0f, 105.0f, 30.0f);
        self.addReviewButton.titleLabel.textColor = [UIColor whiteColor];
    }
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    
    if (data) {
        
        if (self.firstTimeLoad == YES) {
            
            self.noInternetImageView.hidden = YES;
            self.noInternetLabel.hidden = YES;
            
            NSString *uniAndCourse = [self.uniNameReviews stringByAppendingString:@" - "];
            uniAndCourse = [uniAndCourse stringByAppendingString:self.courseNameReviews];
            
            
            self.reviewTableView.bounces = YES;
            self.reviewTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
            self.reviewTableView.delegate = self;
            [self.starButton5 setEnabled:NO];
            [self.starButton4 setEnabled:NO];
            [self.starButton3 setEnabled:NO];
            [self.starButton2 setEnabled:NO];
            [self.starButton1 setEnabled:NO];
            [self.starButton1 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
            [self.starButton2 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
            [self.starButton3 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
            [self.starButton4 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
            [self.starButton5 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
            
            PFQuery *queryForReviews = [PFQuery queryWithClassName:@"CourseReviews"];
            [queryForReviews whereKey:@"CourseCode" equalTo:self.courseCodeReviews];
            [queryForReviews orderByDescending:@"createdAt"];
            [queryForReviews findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
                if (objects.count == 0) {
                    self.reviewTableView.hidden = YES;
                    self.numberOfReviewsLabel.text = @"0 Ratings";
                    self.addReviewButton.frame = CGRectMake(100.0f, 100.0f, 105.0f, 30.0f);
                }
                else if (objects.count == 1) {
                    self.numberOfReviewsLabel.text = @"1 Rating";
                } else {
                    self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%lu Ratings",(unsigned long)objects.count];
                }
                self.reviewTitles = [objects valueForKey:@"ReviewTitle"];
                self.reviewStars = [objects valueForKey:@"StarRating"];
                self.reviewTexts = [objects valueForKey:@"ReviewText"];
                self.reviewersNames = [objects valueForKey:@"ReviewerName"];
                self.reviewersYears = [objects valueForKey:@"ReviewerYear"];
                self.reviewDates = [objects valueForKey:@"createdAt"];
                self.reviewCodes = [objects valueForKey:@"objectId"];
                
                self.cellHeights = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < reviewTexts.count; i++) {
                    UILabel * temp = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                    temp.font = [UIFont fontWithName:@"Arial" size:14];
                    temp.lineBreakMode = NSLineBreakByWordWrapping;
                    temp.numberOfLines = 0;
                    temp.text = [reviewTexts objectAtIndex:i];
                    CGFloat lineHeight = temp.font.lineHeight;
                    CGFloat lines = (temp.text.length / 55.0f) * lineHeight;
                    CGFloat height = lines + 75.0f; //adding some padding
                    
                    [self.cellHeights addObject:[NSNumber numberWithFloat:height]];
                }
                
                [self.reviewTableView reloadData];
                // NSLog(@"stars: %@",self.reviewStars);
                
                NSNumber *sumOfStarRatings = [self.reviewStars valueForKeyPath:@"@sum.self"];
                //NSLog(@"sum: %@",sumOfStarRatings);
                NSNumber *averageStarRating = [NSNumber numberWithFloat:([sumOfStarRatings floatValue] / self.reviewStars.count)];
                //NSLog(@"average: %@",averageStarRating);
                if (0.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<1.5f) {
                    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
                    
                }
                if (1.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<2.5f) {
                    [self.starButton1 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton2 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    
                }
                if (2.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<3.5f) {
                    [self.starButton1 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton2 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton3 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    
                }
                if (3.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<4.5f) {
                    [self.starButton1 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton2 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton3 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton4 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                }
                if (4.5f<[averageStarRating floatValue]) {
                    [self.starButton1 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton2 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton3 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton4 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                    [self.starButton5 setImage:[UIImage imageNamed:@"star-25"] forState:UIControlStateDisabled];
                }
                
                
            }];
            
            // calculate average review
            
            
            
            CALayer *btnLayer = [addReviewButton layer];
            [btnLayer setMasksToBounds:YES];
            [btnLayer setCornerRadius:5.0f];
            self.firstTimeLoad = NO;
            self.reviewTableView.hidden = NO;
            self.courseNameLabel.hidden = NO;
            self.uniNameLabel.hidden = NO;
            self.addReviewButton.hidden = NO;
            self.starButton1.hidden = NO;
            self.starButton2.hidden = NO;
            self.starButton3.hidden = NO;
            self.starButton4.hidden = NO;
            self.starButton5.hidden = NO;
            self.numberOfReviewsLabel.hidden = NO;
            [self.activityIndicator stopAnimating];
        }
    }
    else {
        if (self.firstTimeLoad == YES) {
            NSLog(@"no internet");
            noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 429)];
            noInternetImageView.backgroundColor = [UIColor lightGrayColor];
            noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
            noInternetLabel.text = @"We're sorry, but this data is not available offline";
            noInternetLabel.numberOfLines = 0;
            noInternetLabel.textAlignment = NSTextAlignmentCenter;
            [noInternetImageView addSubview:noInternetLabel];
            [self.view addSubview:noInternetImageView];
            self.uniNameLabel.hidden = NO;
            self.courseNameLabel.hidden = NO;
        }
        
        
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.reviewTableView.hidden == YES) {
        self.addReviewButton.frame = CGRectMake(100.0f, 100.0f, 105.0f, 30.0f);
        self.addReviewButton.titleLabel.textColor = [UIColor whiteColor];
        
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"ReviewCustomCellView%i", indexPath.row];
    
    ReviewCustomCellView *cell = (ReviewCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.yTest = [NSNumber numberWithFloat:cell.reviewerDetailsLabel.frame.origin.y + cell.reviewerDetailsLabel.frame.size.height];
    cell.widthTest = [NSNumber numberWithFloat:tableView.frame.size.width];
    
    NSString *currentIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:currentIndexPath];
    myNumber = [NSNumber numberWithFloat:([myNumber floatValue] + 1.0f)];
    
    cell.reviewNumber = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.",myNumber]];
    cell.reviewTitle = [[NSString alloc] initWithString:[self.reviewTitles objectAtIndex:indexPath.row]];

    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    NSString *formattedDate =[formatter stringFromDate:[self.reviewDates objectAtIndex:indexPath.row]];
    
    cell.reviewDetails = [[NSString alloc] initWithString:[NSString stringWithFormat:@"by %@ - %@ - %@",[self.reviewersNames objectAtIndex:indexPath.row],[self.reviewersYears objectAtIndex:indexPath.row],formattedDate]];
    cell.reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    
    NSLog(@"review texts: %@", self.reviewTexts);
    cell.reviewText = [[NSString alloc] initWithString:[self.reviewTexts objectAtIndex:indexPath.row]];
    cell.heightTest = [self.cellHeights objectAtIndex:indexPath.row];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSNumber *tempNumberOfStars = [self.reviewStars objectAtIndex:indexPath.row];
    // NSLog(@"temp star: %@",tempNumberOfStars);
    if (tempNumberOfStars == [NSNumber numberWithInt:1]) {
        cell.starImageView1.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView2.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView3.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView4.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView5.image = [UIImage imageNamed:@"star-26"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:2]) {
        cell.starImageView1.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView2.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView3.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView4.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView5.image = [UIImage imageNamed:@"star-26"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:3]) {
        cell.starImageView1.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView2.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView3.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView4.image = [UIImage imageNamed:@"star-26"];
        cell.starImageView5.image = [UIImage imageNamed:@"star-26"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:4]) {
        cell.starImageView1.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView2.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView3.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView4.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView5.image = [UIImage imageNamed:@"star-26"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:5]) {
        cell.starImageView1.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView2.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView3.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView4.image = [UIImage imageNamed:@"star-25"];
        cell.starImageView5.image = [UIImage imageNamed:@"star-25"];
    }
    
    UIButton *reportReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reportReviewButton.tag = indexPath.row;
    [reportReviewButton setFrame:CGRectMake(190, 3, 150, 30)];
    [reportReviewButton setTitle:@"Report Review" forState:UIControlStateNormal];
    reportReviewButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [reportReviewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [reportReviewButton addTarget:self action:@selector(ReportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    reportReviewButton.tag = indexPath.row;
    [cell addSubview:reportReviewButton];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.haveDoneParseQueryYet == YES) {
        NSLog(@"cell heights here: %@",self.cellHeights);
        self.haveReloadedHeights = YES;
        return [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 10;
    } else {
        return [[self.cellHeights objectAtIndex:indexPath.row] floatValue] - 10;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addReviewButtonPressed:(id)sender {
    
    AddReviewViewController *addReviewViewController = [[AddReviewViewController alloc]initWithNibName:@"AddReviewViewController" bundle:[NSBundle mainBundle]];
    
    
    UINavigationController *addReviewNavigationController = [[UINavigationController alloc]initWithRootViewController:addReviewViewController];
    
    
    addReviewViewController.couseKISCode = self.courseCodeReviews;
    
    [self presentViewController:addReviewNavigationController animated:YES completion:nil];
    
}

- (void)ReportButtonClicked:(id)sender
{
    ReviewComplaintViewController *reviewComplaintViewController = [[ReviewComplaintViewController alloc] initWithNibName:@"ReviewComplaintViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *reviewComplaintNavigationController = [[UINavigationController alloc]initWithRootViewController:reviewComplaintViewController];
    
    reviewComplaintViewController.courseKISCode = self.courseCodeReviews;
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    NSLog(@"Selected row is: %d",indexrow);
    reviewComplaintViewController.complaintCode = [self.reviewCodes objectAtIndex:indexrow];
    
    
    
    [self presentViewController:reviewComplaintNavigationController animated:YES completion:nil];
}

@end
