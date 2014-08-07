//
//  UniInfoCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniInfoCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *uniInfoTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewUniInfo;
@property (weak, nonatomic) IBOutlet UILabel *numberDataLabelUniInfo;
@end
