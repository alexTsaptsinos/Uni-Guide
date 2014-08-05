//
//  StudentSatisfactionCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "StudentSatisfactionCustomCellView.h"

@interface StudentSatisfactionCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString *courseCodeStudentSatisfaction;
@property (strong, nonatomic) NSString *uniCodeStudentSatisfaction;
@property (strong, nonatomic) NSMutableArray *questionResults;

@property (weak, nonatomic) IBOutlet UITableView *tableViewStudentSatisfaction;

@end
