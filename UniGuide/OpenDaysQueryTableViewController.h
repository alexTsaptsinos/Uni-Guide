//
//  OpenDaysQueryTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 31/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Parse/Parse.h>
#import "SpecificOpenDayViewController.h"


@interface OpenDaysQueryTableViewController : PFQueryTableViewController <UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *openDays;
@property (strong, nonatomic) NSMutableArray *openDayDates;
@property (strong, nonatomic) NSMutableArray *startTimes;
@property (strong, nonatomic) NSMutableArray *endTimes;
@property (strong, nonatomic) NSMutableArray *details;
@property (strong, nonatomic) NSMutableArray *links;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic) NSUInteger i;
@property (nonatomic) BOOL firstTimeForDates;
@property (nonatomic,strong) NSArray *allObjects;




@end
