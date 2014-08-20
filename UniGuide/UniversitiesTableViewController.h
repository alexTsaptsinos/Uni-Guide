//
//  UniversitiesTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 26/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Parse/Parse.h>

@interface UniversitiesTableViewController : PFQueryTableViewController <UITableViewDelegate,UISearchBarDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic) BOOL hasSearchingCommenced;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
