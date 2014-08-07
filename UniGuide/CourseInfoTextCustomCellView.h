//
//  CourseInfoTextCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseInfoTextCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textCellLabel;
@property (weak, nonatomic) IBOutlet UIButton *textCellDataButton;

- (IBAction)textCellDataButtonPressed:(id)sender;
@end
