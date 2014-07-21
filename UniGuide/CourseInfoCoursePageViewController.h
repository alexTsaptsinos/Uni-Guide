//
//  CourseInfoCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseInfoCoursePageViewController : UIViewController

- (NSString *)returnUniversityName;

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *universityNameLabel;
- (IBAction)universityNameButtonPressed:(id)sender;

@end
