//
//  ReviewsCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewsCoursePageViewController.h"
#import "AddReviewViewController.h"

@interface ReviewsCoursePageViewController ()

@end

@implementation ReviewsCoursePageViewController

@synthesize addReviewButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Reviews", @"Reviews");
        self.tabBarItem.image = [UIImage imageNamed:@"talk-32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

    CALayer *btnLayer = [addReviewButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addReviewButtonPressed:(id)sender {
    
    AddReviewViewController *addReviewViewController = [[AddReviewViewController alloc]initWithNibName:@"AddReviewViewController" bundle:[NSBundle mainBundle]];
    

    UINavigationController *addReviewNavigationController = [[UINavigationController alloc]initWithRootViewController:addReviewViewController];
    
    [self presentViewController:addReviewNavigationController animated:YES completion:nil];
    
}
@end
