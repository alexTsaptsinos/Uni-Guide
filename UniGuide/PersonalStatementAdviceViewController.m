//
//  PersonalStatementAdviceViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 14/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "PersonalStatementAdviceViewController.h"

@interface PersonalStatementAdviceViewController ()

@end

@implementation PersonalStatementAdviceViewController

@synthesize pageViewControllerPersonal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Personal Statement Tips";
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;    
    
    pageViewControllerPersonal = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewControllerPersonal.dataSource = self;
    [[self.pageViewControllerPersonal view] setFrame:[[self view] bounds]];
    
    PSAdviceTableViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageViewControllerPersonal setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewControllerPersonal];
    [[self view] addSubview:[self.pageViewControllerPersonal view]];
    [self.pageViewControllerPersonal didMoveToParentViewController:self];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(PSAdviceTableViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PSAdviceTableViewController *)viewController index];
    
    index++;
    
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (PSAdviceTableViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    PSAdviceTableViewController *childViewController = [[PSAdviceTableViewController alloc] initWithNibName:@"PSAdviceTableViewController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
