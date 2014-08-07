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

@synthesize addReviewButton,courseCodeReviews,uniCodeReviews,courseNameReviews,universityAndCourseLabel,numberOfReviewsLabel,reviewersNames,reviewStars,reviewTexts,reviewTitles,reviewTableView,reviewDates,reviewersYears,cellHeights,haveDoneParseQueryYet,starButton1,starButton2,starButton3,starButton4,starButton5,reviewCodes;

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
    
    PFQuery *queryForUniversityName = [PFQuery queryWithClassName:@"Institution1213"];
    [queryForUniversityName whereKey:@"UKPRN" equalTo:self.uniCodeReviews];
    [queryForUniversityName selectKeys:[NSArray arrayWithObject:@"Institution"]];
    PFObject *tempUniObject = [queryForUniversityName getFirstObject];
    NSString *uniName = [tempUniObject objectForKey:@"Institution"];
    
<<<<<<< HEAD
    PFQuery *queryForReviews = [PFQuery queryWithClassName:@"CourseReviews"];
    [queryForReviews whereKey:@"CourseCode" equalTo:self.courseCodeReviews];
    [queryForReviews orderByAscending:@"createdAt"];
//    [queryForReviews findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
//        if (objects.count == 1) {
//            self.numberOfReviewsLabel.text = @"1 Rating";
//        } else {
//            self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%d Ratings",objects.count];
//        }
//        self.reviewTitles = [objects valueForKey:@"ReviewTitle"];
//        self.reviewStars = [objects valueForKey:@"StarRating"];
//        self.reviewTexts = [objects valueForKey:@"ReviewText"];
//        self.reviewersNames = [objects valueForKey:@"ReviewerName"];
//        self.reviewersYears = [objects valueForKey:@"ReviewerYear"];
//        self.reviewDates = [objects valueForKey:@"createdAt"];
//        [self.reviewTableView reloadData];
//        
//    }];
    
    NSArray * objects = [queryForReviews findObjects];
        if (objects.count == 1) {
            self.numberOfReviewsLabel.text = @"1 Rating";
        } else {
            self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%d Ratings",objects.count];
=======
    NSString *uniAndCourse = [uniName stringByAppendingString:@" - "];
    uniAndCourse = [uniAndCourse stringByAppendingString:self.courseNameReviews];
    self.universityAndCourseLabel.text = uniAndCourse;
    self.universityAndCourseLabel.adjustsFontSizeToFitWidth = YES;
    self.reviewTableView.bounces = NO;
    [self.starButton5 setEnabled:NO];
    [self.starButton4 setEnabled:NO];
    [self.starButton3 setEnabled:NO];
    [self.starButton2 setEnabled:NO];
    [self.starButton1 setEnabled:NO];
    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];

    PFQuery *queryForReviews = [PFQuery queryWithClassName:@"CourseReviews"];
    [queryForReviews whereKey:@"CourseCode" equalTo:self.courseCodeReviews];
    [queryForReviews orderByAscending:@"createdAt"];
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
>>>>>>> 67dd3792d4bcfbfbee65ee6cbb31610ef6fc85b4
        }
        self.reviewTitles = [objects valueForKey:@"ReviewTitle"];
        self.reviewStars = [objects valueForKey:@"StarRating"];
        self.reviewTexts = [objects valueForKey:@"ReviewText"];
        self.reviewersNames = [objects valueForKey:@"ReviewerName"];
        self.reviewersYears = [objects valueForKey:@"ReviewerYear"];
        self.reviewDates = [objects valueForKey:@"createdAt"];
<<<<<<< HEAD
    
    self.cellHeights = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < reviewTexts.count; i++) {
        UILabel * temp = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        temp.lineBreakMode = NSLineBreakByWordWrapping;
        temp.numberOfLines = 0;
        temp.text = [reviewTexts objectAtIndex:i];
        CGFloat lineHeight = temp.font.lineHeight;
        CGFloat lines = (temp.text.length / 55.0f) * lineHeight;
        CGFloat height = lines + 75.0f; //adding some padding
=======
        self.reviewCodes = [objects valueForKey:@"objectId"];
        [self.reviewTableView reloadData];
        NSLog(@"stars: %@",self.reviewStars);
        
        NSNumber *sumOfStarRatings = [self.reviewStars valueForKeyPath:@"@sum.self"];
        NSLog(@"sum: %@",sumOfStarRatings);
        NSNumber *averageStarRating = [NSNumber numberWithFloat:([sumOfStarRatings floatValue] / self.reviewStars.count)];
        NSLog(@"average: %@",averageStarRating);
        if (0.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<1.5f) {
            [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            
        }
        if (1.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<2.5f) {
            [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            
        }
        if (2.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<3.5f) {
            [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            
        }
        if (3.5f<[averageStarRating floatValue] && [averageStarRating floatValue]<4.5f) {
            [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
        }
        if (4.5f<[averageStarRating floatValue]) {
            [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
            [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateDisabled];
        }
        
>>>>>>> 67dd3792d4bcfbfbee65ee6cbb31610ef6fc85b4
        
        [self.cellHeights addObject:[NSNumber numberWithFloat:height]];
    }
    
    
    // calculate average review
  

    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    //self.behindStarsImageView.backgroundColor = [UIColor yellowColor];
    //self.cellHeights = [[NSMutableArray alloc] init];
    self.haveDoneParseQueryYet = NO;
    
    NSString *uniAndCourse = [uniName stringByAppendingString:@" - "];
    uniAndCourse = [uniAndCourse stringByAppendingString:self.courseNameReviews];
    self.universityAndCourseLabel.text = uniAndCourse;
    self.universityAndCourseLabel.adjustsFontSizeToFitWidth = YES;
    self.reviewTableView.bounces = NO;
    
    CALayer *btnLayer = [addReviewButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reviewTitles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ReviewCustomCellView";
    
    ReviewCustomCellView *cell = (ReviewCustomCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewCustomCellView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
<<<<<<< HEAD
    cell.yTest = [NSNumber numberWithFloat:cell.reviewerDetailsLabel.frame.origin.y + cell.reviewerDetailsLabel.frame.size.height];
    cell.widthTest = [NSNumber numberWithFloat:tableView.frame.size.width];
    
    NSString *currentIndexPath = [NSString stringWithFormat:@"%d",indexPath.row];
=======
    NSString *currentIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
>>>>>>> 67dd3792d4bcfbfbee65ee6cbb31610ef6fc85b4
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:currentIndexPath];
    myNumber = [NSNumber numberWithFloat:([myNumber floatValue] + 1.0f)];
    
    cell.reviewNumber = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@.",myNumber]];
    cell.reviewTitle = [[NSString alloc] initWithString:[self.reviewTitles objectAtIndex:indexPath.row]];
    //cell.reviewNumberLabel.text = [NSString stringWithFormat:@"%@.",myNumber];
    //cell.reviewTitleLabel.text = [self.reviewTitles objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    NSString *formattedDate =[formatter stringFromDate:[self.reviewDates objectAtIndex:indexPath.row]];
<<<<<<< HEAD
    cell.reviewDetails = [[NSString alloc] initWithString:[NSString stringWithFormat:@"by %@ - %@ - %@",[self.reviewersNames objectAtIndex:indexPath.row],[self.reviewersYears objectAtIndex:indexPath.row],formattedDate]];
    
    //cell.reviewerDetailsLabel.text = [NSString stringWithFormat:@"by %@ - %@ - %@",[self.reviewersNames objectAtIndex:indexPath.row],[self.reviewersYears objectAtIndex:indexPath.row],formattedDate];
    //cell.reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.reviewText = [[NSString alloc] initWithString:[self.reviewTexts objectAtIndex:indexPath.row]];
    cell.heightTest = [self.cellHeights objectAtIndex:indexPath.row];
//    cell.reviewTextView.text = [self.reviewTexts objectAtIndex:indexPath.row];
//    cell.reviewTextView.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.reviewTextView.numberOfLines = 0;
//    cell.reviewTextView.backgroundColor = [UIColor yellowColor];
//    [cell.reviewTextView sizeThatFits:CGSizeMake(cell.frame.size.width, 500)];
//    
//    NSLog(@"%.f height", cell.reviewTextView.frame.size.height);
=======
    cell.reviewerDetailsLabel.text = [NSString stringWithFormat:@"by %@ - %@ - %@",[self.reviewersNames objectAtIndex:indexPath.row],[self.reviewersYears objectAtIndex:indexPath.row],formattedDate];
    cell.reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSNumber *tempNumberOfStars = [self.reviewStars objectAtIndex:indexPath.row];
    NSLog(@"temp star: %@",tempNumberOfStars);
    if (tempNumberOfStars == [NSNumber numberWithInt:1]) {
        cell.starImageView1.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView2.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView3.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView4.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView5.image = [UIImage imageNamed:@"favouritesButton"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:2]) {
        cell.starImageView1.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView2.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView3.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView4.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView5.image = [UIImage imageNamed:@"favouritesButton"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:3]) {
        cell.starImageView1.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView2.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView3.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView4.image = [UIImage imageNamed:@"favouritesButton"];
        cell.starImageView5.image = [UIImage imageNamed:@"favouritesButton"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:4]) {
        cell.starImageView1.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView2.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView3.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView4.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView5.image = [UIImage imageNamed:@"favouritesButton"];
    } else if (tempNumberOfStars == [NSNumber numberWithInt:5]) {
        cell.starImageView1.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView2.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView3.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView4.image = [UIImage imageNamed:@"favouritesButtonSelected"];
        cell.starImageView5.image = [UIImage imageNamed:@"favouritesButtonSelected"];
    }
    
    // try and set text view to size of text
//    UITextView *reviewText = [[UITextView alloc] init];
//    reviewText.text = [self.reviewTexts objectAtIndex:indexPath.row];
   // [reviewText setFrame:CGRectMake(0, 0, 320, reviewText.contentSize.height)];

//    CGRect frame = cell.reviewTextView.frame;
//    
//    frame.size = cell.reviewTextView.contentSize;
//    
//    cell.reviewTextView.frame = frame;
    [cell.reviewTextView setScrollEnabled:YES];
    cell.reviewTextView.text = [self.reviewTexts objectAtIndex:indexPath.row];
    [cell.reviewTextView sizeToFit];
    [cell.reviewTextView setScrollEnabled:NO];
    
    
    UIButton *reportReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reportReviewButton.tag = indexPath.row;
    [reportReviewButton setFrame:CGRectMake(190, 3, 150, 30)];
    //reportReviewButton.titleLabel.text = @"Report Review";
    [reportReviewButton setTitle:@"Report Review" forState:UIControlStateNormal];
    reportReviewButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [reportReviewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [reportReviewButton addTarget:self action:@selector(ReportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    reportReviewButton.tag = indexPath.row;
    [cell addSubview:reportReviewButton];
    //[cell sizeToFit];
    

    
   // [cell.reviewTextView setFrame:CGRectMake(0, 0, 320, cell.reviewTextView.contentSize.height)];
    NSNumber *tempHeight = [NSNumber numberWithFloat:cell.reviewTextView.frame.size.height];
    [self.cellHeights addObject:tempHeight];
    self.haveDoneParseQueryYet = YES;
    NSLog(@"cell heights: %@",self.cellHeights);
    
    //[cell setFrame:CGRectMake(0, 0, 320.0f, [[self.cellHeights objectAtIndex:indexPath.row] floatValue])];

>>>>>>> 67dd3792d4bcfbfbee65ee6cbb31610ef6fc85b4
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return [[self.cellHeights objectAtIndex:indexPath.row] floatValue]+45;
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

//Andrew, fix these heights
@end
