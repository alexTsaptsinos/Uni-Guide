//
//  ExtrasMenuViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PackingListTableViewController.h"

@interface ExtrasMenuViewController : UIViewController

@property (strong,nonatomic) UIButton *packingListButton;
@property (strong,nonatomic) UIButton *usefulWebsiteButton;
@property (strong,nonatomic) UIButton *personalStatementButton;
@property (strong,nonatomic) UIButton *interviewAdviceButton;
@property (strong,nonatomic) UIButton *studentFinanceButton;
@property (strong,nonatomic) UIButton *courseGeneratorButton;
@property (strong,nonatomic) UILabel *quoteLabel;

@end
