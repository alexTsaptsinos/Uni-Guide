//
//  MainMenuViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SearchViewController.h"
#import "FavouritesTableViewController.h"
#import "UniversitiesListTableViewController.h"
#import "OpenDaysQueryTableViewController.h"

@interface MainMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *uniGuideLogoMainMenuImageView;

@property (strong,nonatomic) UIButton *searchMenuButtonLabel;
@property (strong,nonatomic) UIButton *favouritesMenuButtonLabel;
@property (strong,nonatomic) UIButton *openDaysMenuButtonLabel;
@property (strong,nonatomic) UIButton *universitiesMenuButtonLabel;


@end
