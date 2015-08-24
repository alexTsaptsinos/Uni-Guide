//
//  PSAdviceTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 16/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsefulWebsitesTableViewCell.h"

@interface PSAdviceTableViewController : UITableViewController

@property (assign,nonatomic) NSInteger index;

@property (strong,nonatomic) NSArray *titlesArray;
@property (strong,nonatomic) NSArray *textArray;
@property (strong,nonatomic) NSMutableArray *cellHeights;


@end
