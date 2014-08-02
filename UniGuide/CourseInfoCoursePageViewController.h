//
//  CourseInfoCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CourseInfoCoursePageViewController : UIViewController




@property (weak, nonatomic) IBOutlet UILabel *universityNameLabel;
@property (strong, nonatomic) NSString *courseCodeCourseInfo;
@property (strong, nonatomic) NSString *uniCodeCourseInfo;


@end
