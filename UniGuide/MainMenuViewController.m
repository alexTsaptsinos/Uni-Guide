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

@synthesize uniGuideLogoMainMenuImageView,searchMenuButtonLabel,favouritesMenuButtonLabel,openDaysMenuButtonLabel,universitiesMenuButtonLabel,compareMenuButton,extrasMenuButton,catchphraseLabel,editButton,compareViewController;

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

    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    searchMenuButtonLabel.frame = CGRectMake(0, heightFloat/4, widthFloat/2, heightFloat/4);
    favouritesMenuButtonLabel.frame = CGRectMake(widthFloat/2, heightFloat/4, widthFloat/2, heightFloat/4);
    openDaysMenuButtonLabel.frame = CGRectMake(widthFloat/2, heightFloat/2, widthFloat/2, heightFloat/4);
    universitiesMenuButtonLabel.frame = CGRectMake(0, heightFloat*3/4, widthFloat/2, heightFloat/4);
    
    // Set up button borders
    
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
    

    //Make buttons have rounded corners
    [[searchMenuButtonLabel layer] setBorderWidth:7.0f];
    [[searchMenuButtonLabel layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [[openDaysMenuButtonLabel layer] setBorderWidth:7.0f];
    [[openDaysMenuButtonLabel layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [[universitiesMenuButtonLabel layer] setBorderWidth:7.0f];
    [[universitiesMenuButtonLabel layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [[favouritesMenuButtonLabel layer] setBorderWidth:7.0f];
    [[favouritesMenuButtonLabel layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    
    CALayer *btnLayer = [searchMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    btnLayer = [favouritesMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    btnLayer = [openDaysMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    btnLayer = [universitiesMenuButtonLabel layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    // NEW FEATURES - SET UP REVIEW & EXTRAS BUTTON
    
    self.compareMenuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [compareMenuButton addTarget:self
                              action:@selector(compareButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    compareMenuButton.frame = CGRectMake(0, heightFloat/2, widthFloat/2, heightFloat/4);
    self.compareMenuButton.exclusiveTouch = YES;
    [compareMenuButton setTitle:@"Compare" forState:UIControlStateNormal];
    [compareMenuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[compareMenuButton layer] setBorderWidth:7.0f];
    [[compareMenuButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:compareMenuButton];
    self.compareMenuButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [compareMenuButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    self.extrasMenuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [extrasMenuButton addTarget:self
                          action:@selector(extrasButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
    extrasMenuButton.frame = CGRectMake(widthFloat/2, heightFloat*3/4, widthFloat/2, heightFloat/4);
    self.extrasMenuButton.exclusiveTouch = YES;
    [extrasMenuButton setTitle:@"Extras" forState:UIControlStateNormal];
    [extrasMenuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[extrasMenuButton layer] setBorderWidth:7.0f];
    [[extrasMenuButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:extrasMenuButton];
    self.extrasMenuButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [extrasMenuButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    
    // Add catchphrase
    self.catchphraseLabel = [[UILabel alloc] init];
    catchphraseLabel.frame = CGRectMake(190, 30, 130, 80);
    catchphraseLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Helping\n you find\n your way"];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:193.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] range:NSMakeRange(8, 4)];
    //[text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:193.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] range:NSMakeRange(19, 4)];
    [catchphraseLabel setAttributedText:text];
    catchphraseLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    catchphraseLabel.textAlignment = NSTextAlignmentCenter;
    
    catchphraseLabel.numberOfLines = 3;
    [self.view addSubview:catchphraseLabel];
  
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

- (void)compareButtonClicked:(UIButton*)button
{
    // if compare button clicked let's go to the compare page
    compareViewController = [[CompareViewController alloc] initWithNibName:@"CompareViewController" bundle:nil];
    CommonJobsCompareViewController *commonJobsCompareViewController = [[CommonJobsCompareViewController alloc] initWithNibName:@"CommonJobsCompareViewController" bundle:nil];
    StudentSatisfactionCompareViewController *studentSatisfactionCompareViewController = [[StudentSatisfactionCompareViewController alloc] initWithNibName:@"StudentSatisfactionCompareViewController" bundle:nil];
    UniInfoCompareViewController *uniInfoCompareViewController = [[UniInfoCompareViewController alloc] initWithNibName:@"UniInfoCompareViewController" bundle:nil];
    
    UITabBarController *comparePageTabBarController = [[UITabBarController alloc] initWithNibName:@"ComparePageTabBarController" bundle:nil];
    
    comparePageTabBarController.viewControllers = [NSArray arrayWithObjects:compareViewController,commonJobsCompareViewController,studentSatisfactionCompareViewController,uniInfoCompareViewController, nil];
    
    // Pass the selected object to the new view controller.
    compareViewController.tabBarItem.image = [UIImage imageNamed:@"info-32"];
    compareViewController.title = NSLocalizedString(@"Course Info", @"Course Info");
    commonJobsCompareViewController.tabBarItem.image = [UIImage imageNamed:@"briefcase-32"];
    commonJobsCompareViewController.title = NSLocalizedString(@"Common Jobs", @"Common Jobs");
    studentSatisfactionCompareViewController.tabBarItem.image = [UIImage imageNamed:@"student2-32"];
    studentSatisfactionCompareViewController.title = NSLocalizedString(@"Student Satisfaction", @"Student Satisfaction");
    uniInfoCompareViewController.tabBarItem.image = [UIImage imageNamed:@"city_hall-32"];
    uniInfoCompareViewController.title = NSLocalizedString(@"Uni Info", @"Uni Info");
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(callEditMethod)];
    
    [comparePageTabBarController.navigationItem setRightBarButtonItem:editButton];

    
    comparePageTabBarController.navigationItem.title = @"Compare";
    comparePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [comparePageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    [self.navigationController pushViewController:comparePageTabBarController animated:YES];



}

- (void)extrasButtonClicked:(UIButton*)button
{
    // if extras button clicked let's go to the extras menu page
    ExtrasMenuViewController *extrasMenuViewController = [[ExtrasMenuViewController alloc] initWithNibName:@"ExtrasMenuViewController" bundle:nil];
    [self.navigationController pushViewController:extrasMenuViewController animated:YES];
    
    
}

- (void)callEditMethod {
    compareViewController.editButton = self.editButton;
    [compareViewController editBtnPressed];
}

@end
