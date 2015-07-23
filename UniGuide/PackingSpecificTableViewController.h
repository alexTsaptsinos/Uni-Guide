//
//  PackingSpecificTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackingSpecificTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *essentialItems;
@property (strong, nonatomic) NSArray *desirableItems;
@property (strong, nonatomic) NSString *categoryString;
@property (strong, nonatomic) UIImageView *checkboxImageView;

@end
