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

@property (weak, nonatomic) IBOutlet UIImageView *starImageView1;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView4;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView5;

@property (nonatomic, retain) NSString * reviewNumber;
@property (nonatomic, retain) NSString * reviewTitle;
@property (nonatomic, retain) NSString * reviewDetails;
@property (nonatomic, retain) NSString * reviewText;
@property (nonatomic, retain) NSNumber * heightTest;
@property (nonatomic, retain) NSNumber * yTest;
@property (nonatomic, retain) NSNumber * widthTest;

@end

