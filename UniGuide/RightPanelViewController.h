//
//  RightPanelViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol RightPanelViewControllerDelegate <NSObject>


//@end

@interface RightPanelViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, assign) id<RightPanelViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableViewCell *sortCell;
@property (weak, nonatomic) IBOutlet UITableView *filterControllersTable;
- (IBAction)sortCellPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *campusButton;
@property (weak, nonatomic) IBOutlet UIButton *russellGroupOnlyButton;
@property (weak, nonatomic) IBOutlet UIButton *townButton;
- (IBAction)campusButtonPressed:(id)sender;
- (IBAction)townButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nineteenNinetyFourGroupOnlyButton;
- (IBAction)russellGroupOnlyButtonPressed:(id)sender;
- (IBAction)nineteenNinetyFourGroupOnlyButtonPressed:(id)sender;

@end
