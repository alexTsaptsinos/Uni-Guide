//
//  MainMenuViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize uniGuideMainMenuLabel,uniGuideLogoMainMenuImageView,searchMenuButtonLabel,discoverMenuButtonLabel,favouritesMenuButtonLabel,openDaysMenuButtonLabel,universitiesMenuButtonLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Home";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Make 5 buttons have rounded corners
    
    CALayer *btnLayer = [searchMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    btnLayer = [favouritesMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    btnLayer = [openDaysMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    btnLayer = [universitiesMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    btnLayer = [discoverMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchMenuButtonPressed:(id)sender {
    
    // if search button pressed launch search view controller
    
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:searchViewController animated:YES];
  
    
}

- (IBAction)discoverMenuButtonPressed:(id)sender {
    
    // if discover button pressed launch discover view controller
    
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:discoverViewController animated:YES];
    
}

- (IBAction)favouritesMenuButtonPressed:(id)sender {
    
    // if favourites button pressed launch favourites table view controller
    
    FavouritesTableViewController *favouritesTableViewController = [[FavouritesTableViewController alloc]initWithNibName:@"FavouritesTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:favouritesTableViewController animated:YES];
}

- (IBAction)openDaysMenuButtonPressed:(id)sender {
    
    // if open days button pressed launch open days table view controller
    
    OpenDaysTableViewController *openDaysTableViewController = [[OpenDaysTableViewController alloc] initWithNibName:@"OpenDaysTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:openDaysTableViewController animated:YES];
}

- (IBAction)universitiesMenuButtonPressed:(id)sender {
    
    // if universities button pressed launch universities table view controller
    
//    UniversitiesListTableViewController *universitiesListTableViewController = [[UniversitiesListTableViewController alloc] initWithNibName:@"UniversitiesListTableViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:universitiesListTableViewController animated:YES];
    
    UniversitiesListViewController *universitiesListViewController = [[UniversitiesListViewController alloc] initWithNibName:@"UniversitiesListViewController" bundle:nil];
    
    [self.navigationController pushViewController:universitiesListViewController animated:YES];
    
    
}

//methods so that navigation bar does not appear on home screen

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
