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
@property (weak, nonatomic) IBOutlet UIButton *searchMenuButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouritesMenuButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *openDaysMenuButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *universitiesMenuButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *uniGuideLogoMainMenuImageView;

- (IBAction)searchMenuButtonPressed:(id)sender;
- (IBAction)favouritesMenuButtonPressed:(id)sender;
- (IBAction)openDaysMenuButtonPressed:(id)sender;
- (IBAction)universitiesMenuButtonPressed:(id)sender;

@end
