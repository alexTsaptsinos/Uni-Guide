//
//  UniversitiesListTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactUniversityPageViewController.h"
#import "CourseListTableViewController.h"
#import "UniInfoCoursePageViewController.h"
#import "OpenDaysUniversityPageTableViewController.h"

@interface UniversitiesListTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) NSMutableArray *universities;
@property (nonatomic, strong) NSMutableArray *universitiesSortableNames;
@property (nonatomic, strong) NSArray *sortedUniversities;
@property (nonatomic, strong) NSMutableArray *universitiesUKPRNS;
@property (nonatomic) BOOL hasSearchingCommenced;

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, retain) NSMutableDictionary *sections;

@end
