//
//  SearchResultsTableViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//


#import "RightPanelViewController.h"

//@protocol SearchResulsTableViewControllerDelegate <NSObject>
//
//@optional
//-(void)movePanelLeft;
//
//@required
//-(void)movePanelToOriginalPosition;
//
//@end

//@interface SearchResultsTableViewController : UIViewController <RightPanelViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, assign) id<SearchResulsTableViewControllerDelegate> delegate;
@interface SearchResultsTableViewController: UIViewController

@property (nonatomic, retain) NSMutableArray *allCourses;
@property (nonatomic, strong) UIBarButtonItem *favouritesButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *customFilterButton;


@end
