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

    uniNameLabel.frame = CGRectMake(5, 0, self.frame.size.width-10, 20);
    uniNameLabel.textAlignment = NSTextAlignmentCenter;
    uniNameLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    uniNameLabel.font = [UIFont fontWithName:@"Arial" size:13];
    uniNameLabel.adjustsFontSizeToFitWidth = YES;
    uniNameLabel.numberOfLines = 1;
    
    courseNameLabel.frame = CGRectMake(5, 20, self.frame.size.width - 10, 20);
    courseNameLabel.textAlignment = NSTextAlignmentCenter;
    courseNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    courseNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    courseNameLabel.adjustsFontSizeToFitWidth = YES;
    courseNameLabel.numberOfLines = 1;
    
    yearAbroadLabel.frame = CGRectMake(5, 40, self.frame.size.width - 10, 20);
    yearAbroadLabel.textAlignment = NSTextAlignmentCenter;
    yearAbroadLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    yearAbroadLabel.font = [UIFont fontWithName:@"Arial" size:12];
    yearAbroadLabel.adjustsFontSizeToFitWidth = YES;
    yearAbroadLabel.numberOfLines = 1;
    
    yearIndustryLabel.frame = CGRectMake(5, 60, self.frame.size.width - 10, 20);
    yearIndustryLabel.textAlignment = NSTextAlignmentCenter;
    yearIndustryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    yearIndustryLabel.font = [UIFont fontWithName:@"Arial" size:12];
    yearIndustryLabel.adjustsFontSizeToFitWidth = YES;
    yearIndustryLabel.numberOfLines = 1;

}

@end
