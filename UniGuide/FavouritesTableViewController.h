//
//  FavouritesTableViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favourites.h"
#import "NSManagedObject+CRUD.h"
#import "CourseInfoCoursePageViewController.h"
#import "StudentSatisfactionCoursePageViewController.h"
#import "ReviewsCoursePageViewController.h"
#import "UniInfoCoursePageViewController.h"

@interface FavouritesTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *courseNames;
@property (nonatomic,strong) NSMutableArray *courseCodes;
@property (nonatomic,strong) NSMutableArray *uniNames;
@property (nonatomic,strong) NSMutableArray *uniCodes;
@property (nonatomic,strong) NSMutableArray *favouriteObjects;

@property (nonatomic, strong) UIBarButtonItem *favouritesButton;

@property (nonatomic,strong) CourseInfoCoursePageViewController *courseInfoCoursePageViewController;
@end
