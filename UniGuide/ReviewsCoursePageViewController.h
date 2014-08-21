//
//  ReviewsCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "ReviewCustomCellView.h"

@interface ReviewsCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addReviewButton;
- (IBAction)addReviewButtonPressed:(id)sender;
@property (strong, nonatomic) NSString *courseCodeReviews;
@property (strong,nonatomic) NSString *uniCodeReviews;
@property (weak, nonatomic) IBOutlet UILabel *numberOfReviewsLabel;
@property (strong, nonatomic) NSString *courseNameReviews;
@property (strong,nonatomic) NSString *uniNameReviews;

@property (strong,nonatomic) NSMutableArray *reviewersNames;
@property (strong,nonatomic) NSMutableArray *reviewersYears;
@property (strong,nonatomic) NSMutableArray *reviewDates;
@property (strong,nonatomic) NSMutableArray *reviewTitles;
@property (strong,nonatomic) NSMutableArray *reviewStars;
@property (strong,nonatomic) NSMutableArray *reviewTexts;
@property (strong,nonatomic) NSMutableArray *reviewCodes;

@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@property (strong, nonatomic) NSMutableArray *cellHeights;
@property (nonatomic) BOOL haveDoneParseQueryYet;

@property (weak, nonatomic) IBOutlet UIButton *starButton1;

@property (weak, nonatomic) IBOutlet UIButton *starButton2;
@property (weak, nonatomic) IBOutlet UIButton *starButton3;
@property (weak, nonatomic) IBOutlet UIButton *starButton4;
@property (weak, nonatomic) IBOutlet UIButton *starButton5;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;

@property (nonatomic) BOOL haveReloadedHeights;
@property (nonatomic) BOOL firstTimeLoad;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@end
