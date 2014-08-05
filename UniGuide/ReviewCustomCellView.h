//
//  ReviewCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewComplaintViewController.h"
#import "ReviewsCoursePageViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ReviewCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reviewNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewerDetailsLabel;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView5;


@end

