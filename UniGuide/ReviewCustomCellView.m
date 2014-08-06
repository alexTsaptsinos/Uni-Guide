//
//  ReviewCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewCustomCellView.h"

@implementation ReviewCustomCellView

@synthesize reviewerDetailsLabel,reviewNumberLabel,reviewTitleLabel;

@synthesize reviewDetails,reviewNumber,reviewText,reviewTitle, heightTest, yTest, widthTest;

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
    reviewTextView.frame = CGRectMake(3, [yTest floatValue], [widthTest floatValue]-6, 500);
    reviewNumberLabel.text = reviewNumber;
    reviewTitleLabel.text = reviewTitle;
    reviewerDetailsLabel.text = reviewDetails;
    reviewerDetailsLabel.adjustsFontSizeToFitWidth = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    reviewTextView.lineBreakMode = NSLineBreakByWordWrapping;
    reviewTextView.numberOfLines = 0;
    reviewTextView.backgroundColor = [UIColor yellowColor];
    reviewTextView.text = reviewText;
    [reviewTextView sizeToFit];
    [self addSubview:reviewTextView];

}


@end
