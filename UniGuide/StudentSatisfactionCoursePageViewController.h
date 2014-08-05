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

@interface StudentSatisfactionCoursePageViewController : UIViewController

@property (strong, nonatomic) NSString *courseCodeStudentSatisfaction;
@property (strong, nonatomic) NSString *uniCodeStudentSatisfaction;

@property (weak, nonatomic) IBOutlet UILabel *question1Label;


@property (weak, nonatomic) IBOutlet UIImageView *question1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *question2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *question3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *question4ImageView;

@end
