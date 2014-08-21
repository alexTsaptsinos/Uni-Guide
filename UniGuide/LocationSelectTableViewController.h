//
//  LocationSelectTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 19/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@class SearchViewController;

@interface LocationSelectTableViewController : UITableViewController

@property (nonatomic,strong) SearchViewController *previousViewController;
@property (nonatomic,strong) NSArray *locations;

@end
