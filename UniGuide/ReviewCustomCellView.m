//
//  ReviewCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewCustomCellView.h"

@implementation ReviewCustomCellView

@synthesize reviewerDetailsLabel,reviewNumberLabel,reviewTitleLabel,starImageView1,starImageView2,starImageView3,starImageView4,starImageView5,reviewTextLabel;


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

@end
