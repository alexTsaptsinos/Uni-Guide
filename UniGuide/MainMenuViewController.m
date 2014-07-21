//
//  MainMenuViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AppDelegate.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Home";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchMenuButtonPressed:(id)sender {
    
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:searchViewController animated:YES];
  
    
}

- (IBAction)discoverMenuButtonPressed:(id)sender {
    
    DiscoverViewController *discoverViewController = [[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:discoverViewController animated:YES];
    
}

- (IBAction)favouritesMenuButtonPressed:(id)sender {
    
    FavouritesTableViewController *favouritesTableViewController = [[FavouritesTableViewController alloc]initWithNibName:@"FavouritesTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:favouritesTableViewController animated:YES];
}

- (IBAction)openDaysMenuButtonPressed:(id)sender {
    
    OpenDaysUniversityPageViewController *openDaysUniversityPageViewController = [[OpenDaysUniversityPageViewController alloc] initWithNibName:@"OpenDaysUniversityPageViewController" bundle:nil];
    
    [self.navigationController pushViewController:openDaysUniversityPageViewController animated:YES];
}

- (IBAction)universitiesMenuButtonPressed:(id)sender {
    
    
    UniversitiesListTableViewController *universitiesListTableViewController = [[UniversitiesListTableViewController alloc] initWithNibName:@"UniversitiesListTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:universitiesListTableViewController animated:YES];
    
    
}

@end
