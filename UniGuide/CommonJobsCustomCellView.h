//
//  CommonJobsCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 05/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonJobsCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) UILabel *jobLabel;
@property (nonatomic) BOOL isCompare;

@end
