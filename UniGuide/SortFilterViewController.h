//
//  SortFilterViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 24/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortFilterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sortOptionsTableView;


@end
