//
//  CompareCollectionViewCell.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 18/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearAbroadLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearIndustryLabel;


@end
