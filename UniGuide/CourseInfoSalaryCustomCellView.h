//
//  CourseInfoSalaryCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseInfoSalaryCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UILabel *centreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;
@property (weak, nonatomic) IBOutlet UILabel *leftDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
