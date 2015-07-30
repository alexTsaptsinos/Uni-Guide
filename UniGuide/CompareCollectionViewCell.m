//
//  CompareCollectionViewCell.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 18/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "CompareCollectionViewCell.h"

@implementation CompareCollectionViewCell

@synthesize uniNameLabel,courseNameLabel,yearAbroadLabel,yearIndustryLabel;

- (void)awakeFromNib {
    // Initialization code

}

-(void)layoutSubviews {

    uniNameLabel.frame = CGRectMake(2, 0, self.frame.size.width-4, 15);
    uniNameLabel.textAlignment = NSTextAlignmentCenter;
    uniNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    uniNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
    uniNameLabel.adjustsFontSizeToFitWidth = YES;
    uniNameLabel.numberOfLines = 0;
    
    courseNameLabel.frame = CGRectMake(2, 15, self.frame.size.width - 4, 35);
    courseNameLabel.textAlignment = NSTextAlignmentCenter;
    courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    courseNameLabel.adjustsFontSizeToFitWidth = YES;
    courseNameLabel.numberOfLines = 0;
    
    yearAbroadLabel.frame = CGRectMake(2, 50, self.frame.size.width - 4, 15);
    yearAbroadLabel.textAlignment = NSTextAlignmentCenter;
    yearAbroadLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    yearAbroadLabel.font = [UIFont fontWithName:@"Arial" size:12];
    yearAbroadLabel.adjustsFontSizeToFitWidth = YES;
    yearAbroadLabel.numberOfLines = 1;
    
    yearIndustryLabel.frame = CGRectMake(2, 65, self.frame.size.width - 4, 15);
    yearIndustryLabel.textAlignment = NSTextAlignmentCenter;
    yearIndustryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    yearIndustryLabel.font = [UIFont fontWithName:@"Arial" size:12];
    yearIndustryLabel.adjustsFontSizeToFitWidth = YES;
    yearIndustryLabel.numberOfLines = 1;

}

@end
