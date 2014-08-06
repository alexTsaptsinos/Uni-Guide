//
//  ReviewCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reviewNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewerDetailsLabel;

@property (nonatomic, retain) NSString * reviewNumber;
@property (nonatomic, retain) NSString * reviewTitle;
@property (nonatomic, retain) NSString * reviewDetails;
@property (nonatomic, retain) NSString * reviewText;
@property (nonatomic, retain) NSNumber * heightTest;
@property (nonatomic, retain) NSNumber * yTest;
@property (nonatomic, retain) NSNumber * widthTest;

@end
