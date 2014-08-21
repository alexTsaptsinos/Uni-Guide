//
//  MainMenuViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AppDelegate.h"

#import "NSManagedObject+CRUD.h"
#import "Favourites.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize uniGuideLogoMainMenuImageView,searchMenuButtonLabel,favouritesMenuButtonLabel,openDaysMenuButtonLabel,universitiesMenuButtonLabel;

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
    
//    Favourites * temp = [Favourites createObject];
//    temp.courseName = @"whatever";
//    [Favourites saveDatabase];
    
    NSArray * temp2 = [Favourites readAllObjects];
    
    for (Favourites * favourite in temp2) {
        NSLog(@"%@", favourite.courseName);
    }
    
    
    // Do any additional setup after loading the view from its nib.
    
    self.uniGuideLogoMainMenuImageView.image = [UIImage imageNamed:@"ui-14"];
    self.searchMenuButtonLabel.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.openDaysMenuButtonLabel.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.universitiesMenuButtonLabel.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.favouritesMenuButtonLabel.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;

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

- (IBAction)favouritesMenuButtonPressed:(id)sender {
    
    // if favourites button pressed launch favourites table view controller
    
    FavouritesTableViewController *favouritesTableViewController = [[FavouritesTableViewController alloc]initWithNibName:@"FavouritesTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:favouritesTableViewController animated:YES];
}

- (IBAction)openDaysMenuButtonPressed:(id)sender {
    
    // if open days button pressed launch open days table view controller
        
    OpenDaysQueryTableViewController *openDaysQueryTableViewController = [[OpenDaysQueryTableViewController alloc] init];
    
    [self.navigationController pushViewController:openDaysQueryTableViewController animated:YES];
}

- (IBAction)universitiesMenuButtonPressed:(id)sender {
    
    // if universities button pressed launch universities table view controller

    
    UniversitiesListTableViewController *universitiesListTableViewController = [[UniversitiesListTableViewController alloc] init];
    
    [self.navigationController pushViewController:universitiesListTableViewController animated:YES];
    
    
}


@end
