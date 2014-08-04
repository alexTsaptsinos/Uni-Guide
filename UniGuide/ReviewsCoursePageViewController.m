//
//  ReviewsCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewsCoursePageViewController.h"
#import "AddReviewViewController.h"

@interface ReviewsCoursePageViewController ()

@end

@implementation ReviewsCoursePageViewController

@synthesize addReviewButton,courseCodeReviews,uniCodeReviews,courseNameReviews,universityAndCourseLabel,numberOfReviewsLabel,reviewersNames,reviewStars,reviewTexts,reviewTitles,reviewTableView,reviewDates,reviewersYears,cellHeights,haveDoneParseQueryYet;

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
    self.cellHeights = [[NSMutableArray alloc] init];
    self.haveDoneParseQueryYet = NO;
    
    PFQuery *queryForUniversityName = [PFQuery queryWithClassName:@"Institution1213"];
    [queryForUniversityName whereKey:@"UKPRN" equalTo:self.uniCodeReviews];
    [queryForUniversityName selectKeys:[NSArray arrayWithObject:@"Institution"]];
    PFObject *tempUniObject = [queryForUniversityName getFirstObject];
    NSString *uniName = [tempUniObject objectForKey:@"Institution"];
    
    NSString *uniAndCourse = [uniName stringByAppendingString:@" - "];
    uniAndCourse = [uniAndCourse stringByAppendingString:self.courseNameReviews];
    self.universityAndCourseLabel.text = uniAndCourse;
    self.universityAndCourseLabel.adjustsFontSizeToFitWidth = YES;
    self.reviewTableView.bounces = NO;
    
    
    
    
    PFQuery *queryForReviews = [PFQuery queryWithClassName:@"CourseReviews"];
    [queryForReviews whereKey:@"CourseCode" equalTo:self.courseCodeReviews];
    [queryForReviews orderByAscending:@"createdAt"];
    [queryForReviews findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        if (objects.count == 1) {
            self.numberOfReviewsLabel.text = @"1 Rating";
        } else {
        self.numberOfReviewsLabel.text = [NSString stringWithFormat:@"%d Ratings",objects.count];
        }
        self.reviewTitles = [objects valueForKey:@"ReviewTitle"];
        self.reviewStars = [objects valueForKey:@"StarRating"];
        self.reviewTexts = [objects valueForKey:@"ReviewText"];
        self.reviewersNames = [objects valueForKey:@"ReviewerName"];
        self.reviewersYears = [objects valueForKey:@"ReviewerYear"];
        self.reviewDates = [objects valueForKey:@"createdAt"];
        [self.reviewTableView reloadData];
        
    }];
    


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
    
    NSString *currentIndexPath = [NSString stringWithFormat:@"%d",indexPath.row];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:currentIndexPath];
    myNumber = [NSNumber numberWithFloat:([myNumber floatValue] + 1.0f)];
    
    
    cell.reviewNumberLabel.text = [NSString stringWithFormat:@"%@.",myNumber];
    cell.reviewTitleLabel.text = [self.reviewTitles objectAtIndex:indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yy"];
    NSString *formattedDate =[formatter stringFromDate:[self.reviewDates objectAtIndex:indexPath.row]];
    cell.reviewerDetailsLabel.text = [NSString stringWithFormat:@"by %@ - %@ - %@",[self.reviewersNames objectAtIndex:indexPath.row],[self.reviewersYears objectAtIndex:indexPath.row],formattedDate];
    cell.reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    //[cell sizeToFit];
    

    
   // [cell.reviewTextView setFrame:CGRectMake(0, 0, 320, cell.reviewTextView.contentSize.height)];
    NSNumber *tempHeight = [NSNumber numberWithFloat:cell.reviewTextView.frame.size.height];
    [self.cellHeights addObject:tempHeight];
    self.haveDoneParseQueryYet = YES;
    NSLog(@"cell heights: %@",self.cellHeights);
    
    //[cell setFrame:CGRectMake(0, 0, 320.0f, [[self.cellHeights objectAtIndex:indexPath.row] floatValue])];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.haveDoneParseQueryYet == YES) {
        NSNumber *temp = [cellHeights objectAtIndex:indexPath.row];
        return [temp floatValue];
    } else {
        return 100.0f;
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

//Andrew, fix these heights
@end
