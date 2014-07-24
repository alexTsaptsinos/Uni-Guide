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
    
    // attempt 1     [self.navigationController pushViewController:addReviewViewController animated:YES];
    //[self presentViewController:addReviewViewController animated:YES];
//    [UIView animateWithDuration:0.75
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                         [self.navigationController pushViewController:addReviewViewController animated:NO];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
//                     }];
    
 //attempt 2
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFromBottom; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [self.navigationController pushViewController:addReviewViewController animated:NO];
    

//   attempt 3     AddReviewViewController *addReviewViewController = [[AddReviewViewController alloc]initWithNibName:@"AddReviewViewController" bundle:[NSBundle mainBundle]];
//    //addReviewViewController.transitioningDelegate = self;
//    addReviewViewController.modalPresentationStyle = UIModalPresentationCustom;
//    [self presentViewController:addReviewViewController animated:YES completion:nil];
    
    //attempt 4

//    [self.navigationController pushViewController:addReviewViewController animated:NO];
//    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    

// attempt 5
   // addReviewViewController.modalTransitionStyle =  UIModalTransitionStyleCoverVertical;
   // [self.navigationController pushViewController:addReviewViewController animated:YES];
    
    //attempt 6
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = @"top";
//    [self.view.layer addAnimation:transition forKey:kCATransition];
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [self.navigationController presentViewController:addReviewViewController animated:NO completion:nil];
    
    //attempt 7
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:2];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromTop];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    //[self.navigationController pushViewController:addReviewViewController animated:YES];
//    [[addReviewViewController.view layer] addAnimation:animation forKey:@"SwitchToView1"];
    
    
    //attempt 8
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:5];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromTop];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [[self.view layer] addAnimation:animation forKey:@"SwitchToAddReview"];
//    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController pushViewController:addReviewViewController animated:NO];
    
    //attempt 9
    UINavigationController *addReviewNavigationController = [[UINavigationController alloc]initWithRootViewController:addReviewViewController];
    
    [self presentViewController:addReviewNavigationController animated:YES completion:nil];
    
}
@end
