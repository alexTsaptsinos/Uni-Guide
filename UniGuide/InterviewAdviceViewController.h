//
//  InterviewAdviceViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterviewAdviceTableViewController.h"

@interface InterviewAdviceViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong,nonatomic) UIPageViewController *pageViewControllerPersonal;

@end
