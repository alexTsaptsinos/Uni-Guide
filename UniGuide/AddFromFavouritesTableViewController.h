//
//  AddFromFavouritesTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 31/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favourites.h"
#import "Compares.h"
#import "CompareViewController.h"

@interface AddFromFavouritesTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *courseNames;
@property (nonatomic,strong) NSMutableArray *courseCodes;
@property (nonatomic,strong) NSMutableArray *uniNames;
@property (nonatomic,strong) NSMutableArray *uniCodes;
@property (nonatomic,strong) NSMutableArray *favouriteObjects;
@property (nonatomic,strong) NSMutableArray *reversed;



@end
