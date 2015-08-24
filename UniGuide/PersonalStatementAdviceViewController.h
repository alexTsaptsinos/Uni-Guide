//
//  PersonalStatementAdviceViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 14/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSAdviceTableViewController.h"

@interface PersonalStatementAdviceViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong,nonatomic) UIPageViewController *pageViewControllerPersonal;

@end
