//
//  UniversitiesListViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversitiesListViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *universityListTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *universitySearchBar;

@property (strong, nonatomic) NSMutableArray *filteredUniversityArray;

@end
