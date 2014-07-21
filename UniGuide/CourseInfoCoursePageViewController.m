//
//  CourseInfoCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseInfoCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "OpenDaysUniversityPageViewController.h"
#import "CourseListUniversityPageViewController.h"
#import "ContactUniversityPageViewController.h"

@interface CourseInfoCoursePageViewController ()

@end

@implementation CourseInfoCoursePageViewController

@synthesize courseNameLabel,universityNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Course Info", @"Course Info");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.title = self.courseNameLabel.text;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)universityNameButtonPressed:(id)sender {
    
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListUniversityPageViewController *courseListUniversityPageViewController = [[CourseListUniversityPageViewController alloc] init];
    
    OpenDaysUniversityPageViewController *openDaysUniversityPageViewController = [[OpenDaysUniversityPageViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListUniversityPageViewController,openDaysUniversityPageViewController,contactUniversityPageViewController,nil];
    
    universityPageTabBarController.navigationItem.title = self.universityNameLabel.titleLabel.text;
    
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
    
}

- (NSString *)returnUniversityName {
    return self.universityNameLabel.titleLabel.text;
}
@end
