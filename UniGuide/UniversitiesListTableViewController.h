//
//  UniversitiesListTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface UniversitiesListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, HomeModelProtocol, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *universityArray;
@property (strong, nonatomic) NSMutableArray *filteredUniversityArray;
@property (weak, nonatomic) IBOutlet UISearchBar *universitySearchBar;



@end
