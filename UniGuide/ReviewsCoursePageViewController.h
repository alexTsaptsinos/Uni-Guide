//
//  ReviewsCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ReviewsCoursePageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addReviewButton;
- (IBAction)addReviewButtonPressed:(id)sender;
@property (strong, nonatomic) NSString *courseCodeReviews;

@end
