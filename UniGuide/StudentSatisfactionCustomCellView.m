//
//  StudentSatisfactionCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 05/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "StudentSatisfactionCustomCellView.h"

@implementation StudentSatisfactionCustomCellView

@synthesize questionImageView,questionLabel;

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
