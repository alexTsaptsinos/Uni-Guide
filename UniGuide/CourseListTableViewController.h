//
//  CourseListTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 29/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CourseListTableViewController : UITableViewController <UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *universityCourses;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;
@property (nonatomic, strong) NSString *universityCode;
@property (nonatomic, strong) NSString *universityName;

@end
