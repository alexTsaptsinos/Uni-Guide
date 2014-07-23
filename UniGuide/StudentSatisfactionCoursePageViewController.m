//
//  StudentSatisfactionCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "StudentSatisfactionCoursePageViewController.h"
#import "CourseInfoCoursePageViewController.h"
#import "SearchResultsTableViewController.h"

@interface StudentSatisfactionCoursePageViewController ()

@end

@implementation StudentSatisfactionCoursePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Student Satisfaction", @"Student Satisfaction");
        self.tabBarItem.image = [UIImage imageNamed:@"student2-32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
