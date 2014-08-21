//
//  ReviewCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewCustomCellView.h"

@implementation ReviewCustomCellView

@synthesize reviewerDetailsLabel,reviewNumberLabel,reviewTitleLabel,starImageView1,starImageView2,starImageView3,starImageView4,starImageView5;

@synthesize reviewDetails,reviewNumber,reviewText,reviewTitle,heightTest,yTest,widthTest;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UILabel * reviewTextView = [[UILabel alloc] init];
    reviewTextView.frame = CGRectMake(8, [yTest floatValue], [widthTest floatValue]-11, 500);
    reviewNumberLabel.text = reviewNumber;
    reviewTitleLabel.text = reviewTitle;
    reviewNumberLabel.font = [UIFont fontWithName:@"Arial" size:14];
    reviewTitleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    reviewerDetailsLabel.text = reviewDetails;
    reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    reviewTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    reviewTextView.lineBreakMode = NSLineBreakByWordWrapping;
    reviewTextView.numberOfLines = 0;
    reviewTextView.backgroundColor = [UIColor clearColor];
    reviewTextView.text = reviewText;
    reviewTextView.font = [UIFont fontWithName:@"Arial" size:14];
    [reviewTextView sizeToFit];
    [self addSubview:reviewTextView];
    
}

@end
