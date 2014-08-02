//
//  CourseInfoCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseInfoCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "ContactUniversityPageViewController.h"

@interface CourseInfoCoursePageViewController ()

@end

@implementation CourseInfoCoursePageViewController

@synthesize universityNameLabel,uniCodeCourseInfo,courseCodeCourseInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Course Info", @"Course Info");
        self.tabBarItem.image = [UIImage imageNamed:@"info-32"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;

    
//    PFQuery *universityCodeQuery = [PFQuery queryWithClassName:@"Universities"];
//    [universityCodeQuery whereKey:@"Name" equalTo:universityName];
//    PFObject *object = [universityCodeQuery getFirstObject];
//    universityCode = [object valueForKey:@"PUBUKPRN"];
//    
//    PFQuery *courseCodeQuery = [PFQuery queryWithClassName:@"Kiscourse"];
//    [courseCodeQuery whereKey:@"TITLE" equalTo:courseName];
//    [courseCodeQuery whereKey:@"PUBUKPRN" equalTo:universityCode];
//    PFObject *object2 = [courseCodeQuery getFirstObject];
//    courseCode = [object2 valueForKey:@"KISCOURSEID"];
    
    
    

    
//    self.navigationItem.title = self.courseNameLabel.text;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"course code: %@ and uni UKPRN: %@",self.courseCodeCourseInfo,self.uniCodeCourseInfo);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



    



@end
