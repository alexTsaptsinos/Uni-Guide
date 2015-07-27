//
//  CommonJobsCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 05/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CommonJobsCustomCellView.h"

@implementation CommonJobsCustomCellView

@synthesize jobLabel,percentageLabel,isCompare;

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
    jobLabel = [[UILabel alloc] init];
    jobLabel.frame = CGRectMake(82, 4, 228, 35);
    [self addSubview:jobLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];

}
@end
