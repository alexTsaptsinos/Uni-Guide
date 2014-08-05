//
//  TypeOfComplaintsTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 04/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewComplaintViewController.h"

@class ReviewComplaintViewController;

@interface TypeOfComplaintsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *typeOfComplaintArray;
@property (strong, nonatomic) ReviewComplaintViewController * previousView;

@end
