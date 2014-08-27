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
    
    self.searchMenuButtonLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchMenuButtonLabel addTarget:self
               action:@selector(searchButtonClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    self.searchMenuButtonLabel.exclusiveTouch = YES;
    [searchMenuButtonLabel setTitle:@"Search" forState:UIControlStateNormal];
    [searchMenuButtonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.favouritesMenuButtonLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    [favouritesMenuButtonLabel addTarget:self
                              action:@selector(favouritesButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    self.favouritesMenuButtonLabel.exclusiveTouch = YES;
    [favouritesMenuButtonLabel setTitle:@"Favourites" forState:UIControlStateNormal];
    [favouritesMenuButtonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.openDaysMenuButtonLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    [openDaysMenuButtonLabel addTarget:self
                              action:@selector(openDaysButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    self.openDaysMenuButtonLabel.exclusiveTouch = YES;
    [openDaysMenuButtonLabel setTitle:@"Open Days" forState:UIControlStateNormal];
    [openDaysMenuButtonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.universitiesMenuButtonLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    [universitiesMenuButtonLabel addTarget:self
                              action:@selector(universitiesButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    self.universitiesMenuButtonLabel.exclusiveTouch = YES;
    [universitiesMenuButtonLabel setTitle:@"Universities" forState:UIControlStateNormal];
    [universitiesMenuButtonLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    if (screenBound.size.height > 500) {
        searchMenuButtonLabel.frame = CGRectMake(58.0, 169.0, 206.0, 45.0);
        favouritesMenuButtonLabel.frame = CGRectMake(58.0, 240.0, 206.0, 45.0);
        openDaysMenuButtonLabel.frame = CGRectMake(58.0, 311.0, 206.0, 45.0);
        universitiesMenuButtonLabel.frame = CGRectMake(58.0, 382.0, 206.0, 45.0);
    } else {
        searchMenuButtonLabel.frame = CGRectMake(58.0, 159.0, 206.0, 39.0);
        favouritesMenuButtonLabel.frame = CGRectMake(58.0, 216.0, 206.0, 39.0);
        openDaysMenuButtonLabel.frame = CGRectMake(58.0, 273.0, 206.0, 39.0);
        universitiesMenuButtonLabel.frame = CGRectMake(58.0, 330.0, 206.0, 39.0);
    }
    
    [self.view addSubview:searchMenuButtonLabel];
    [self.view addSubview:favouritesMenuButtonLabel];
    [self.view addSubview:openDaysMenuButtonLabel];
    [self.view addSubview:universitiesMenuButtonLabel];
    
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


- (void)searchButtonClicked:(UIButton*)button
{
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)favouritesButtonClicked:(UIButton*)button
{
    // if favourites button pressed launch favourites table view controller
    
    FavouritesTableViewController *favouritesTableViewController = [[FavouritesTableViewController alloc]initWithNibName:@"FavouritesTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:favouritesTableViewController animated:YES];
}

- (void)openDaysButtonClicked:(UIButton*)button
{
    // if open days button pressed launch open days table view controller
    
    OpenDaysQueryTableViewController *openDaysQueryTableViewController = [[OpenDaysQueryTableViewController alloc] init];
    
    [self.navigationController pushViewController:openDaysQueryTableViewController animated:YES];
}

- (void)universitiesButtonClicked:(UIButton*)button
{
    // if universities button pressed launch universities table view controller
    
    
    UniversitiesListTableViewController *universitiesListTableViewController = [[UniversitiesListTableViewController alloc] init];
    
    [self.navigationController pushViewController:universitiesListTableViewController animated:YES];
}

@end
