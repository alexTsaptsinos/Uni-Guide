//
//  SearchViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsTableViewController.h"

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *courseTextFieldSearchViewController;
@property (weak, nonatomic) IBOutlet UITextField *universityTextFieldSearchViewController;
@property (weak, nonatomic) IBOutlet UITextField *locationTextFieldSearchViewController;
- (IBAction)searchButtonSearchViewControllerPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButtonSearchViewController;

@end
