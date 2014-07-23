//
//  UniversitiesListTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversitiesListTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *universityArray;
@property (strong, nonatomic) NSMutableArray *filteredUniversityArray;
@property (weak, nonatomic) IBOutlet UISearchBar *universitySearchBar;

@property (nonatomic, strong) NSMutableArray *alphabetsArray;

@end
