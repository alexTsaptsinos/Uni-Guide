//
//  UsefulWebsitesTableViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 24/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsefulWebsitesTableViewCell.h"

@interface UsefulWebsitesTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *websiteArray;
@property (strong,nonatomic) NSArray *websiteLinksArray;

@end
