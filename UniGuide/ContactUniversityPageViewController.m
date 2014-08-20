//
//  ContactUniversityPageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ContactUniversityPageViewController.h"

@interface ContactUniversityPageViewController () <MKMapViewDelegate>

@end

@implementation ContactUniversityPageViewController

@synthesize universityCode,contactMapView,universityName,uniLongitude,uniLatitude,hasLoadedBool,emailButton,websiteButton,telephoneButton,telephoneLabel,websiteLabel,emailLabel,firstTimeLoad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Contact", @"Contact");
        self.tabBarItem.image = [UIImage imageNamed:@"electric_megaphone-32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    self.contactMapView.hidden = YES;
    self.telephoneButton.hidden = YES;
    self.emailButton.hidden = YES;
    self.websiteButton.hidden = YES;
    self.telephoneLabel.hidden = YES;
    self.emailLabel.hidden = YES;
    self.websiteLabel.hidden = YES;
    [self.activityIndicator startAnimating];
    self.firstTimeLoad = YES;

   // NSLog(@"code: %@", self.universityCode);
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstTimeLoad == YES) {
    
    PFQuery *contactQuery = [PFQuery queryWithClassName:@"Institution1213"];
    [contactQuery whereKey:@"UKPRN" equalTo:self.universityCode];
    [contactQuery selectKeys:[NSArray arrayWithObjects:@"TelephoneContact",@"EmailContact",@"WebsiteContact", nil]];
    PFObject *contactDetails = [contactQuery getFirstObject];
    
    telephoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [telephoneButton addTarget:self
                        action:@selector(telephoneButton:)
              forControlEvents:UIControlEventTouchUpInside];
    [telephoneButton setTitle:[contactDetails valueForKey:@"TelephoneContact"] forState:UIControlStateNormal];
    telephoneButton.frame = CGRectMake(50.0, 20, 250.0, 20.0);
    telephoneButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [telephoneButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [telephoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [telephoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.view addSubview:telephoneButton];
    
    emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [emailButton addTarget:self
                    action:@selector(emailButton:)
          forControlEvents:UIControlEventTouchUpInside];
    NSString *email = [contactDetails valueForKey:@"EmailContact"];
    if (email.length == 0) {
        [emailButton setTitle:@"Not available" forState:UIControlStateNormal];
        emailButton.enabled = NO;
    } else {
        [emailButton setTitle:email forState:UIControlStateNormal];
    }
    emailButton.frame = CGRectMake(50.0, 44, 250.0, 20.0);
    emailButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [emailButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.view addSubview:emailButton];
    
    websiteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [websiteButton addTarget:self
                      action:@selector(websiteButton:)
            forControlEvents:UIControlEventTouchUpInside];
    [websiteButton setTitle:[contactDetails valueForKey:@"WebsiteContact"] forState:UIControlStateNormal];
    websiteButton.frame = CGRectMake(50.0, 70, 250.0, 20.0);
    websiteButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [websiteButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [websiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [websiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.view addSubview:websiteButton];
    
    
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
    [locationQuery whereKey:@"UKPRN" equalTo:universityCode];
    PFObject *university = [locationQuery getFirstObject];
    uniLatitude = [university valueForKey:@"LATITUDE"];
    uniLongitude = [university valueForKey:@"LONGITUDE"];
    //NSLog(@"latitude: %@ and longitude: %@", uniLatitude, uniLongitude);
    
    MKCoordinateRegion homeRegion;
    homeRegion.center.latitude = 54.013175;
    homeRegion.center.longitude = -2.3252278;
    float homeSpanX = 10;
    float homeSpanY = 10;
    homeRegion.span.latitudeDelta = homeSpanX;
    homeRegion.span.longitudeDelta = homeSpanY;
    
    [self.contactMapView setRegion:homeRegion animated:YES];
    
    self.hasLoadedBool = NO;
    self.contactMapView.hidden = NO;
    self.telephoneButton.hidden = NO;
    self.emailButton.hidden = NO;
    self.websiteButton.hidden = NO;
    self.telephoneLabel.hidden = NO;
    self.emailLabel.hidden = NO;
    self.websiteLabel.hidden = NO;
    [self.activityIndicator stopAnimating];
        self.firstTimeLoad = NO;
    }

}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    // Image creation code here
    if (self.hasLoadedBool == NO) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([uniLatitude doubleValue], [uniLongitude doubleValue]);
        point.title = self.universityName;
        NSArray *anotations = [[NSArray alloc] initWithObjects:point, nil];
        [contactMapView showAnnotations:anotations animated:YES];
        
        
        MKCoordinateRegion region;
        
        //    region.span=span;
        region.center.latitude = [uniLatitude doubleValue];
        region.center.longitude = [uniLongitude doubleValue];
        float spanX = 0.05;
        float spanY = 0.05;
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        
        [self.contactMapView setRegion:region animated:YES];
        self.hasLoadedBool = YES;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)telephoneButton:(UIButton*)button
{
    NSString *number = @"telprompt://";
    number = [number stringByAppendingString:self.telephoneButton.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
}

- (void)emailButton:(UIButton*)button
{
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:self.emailButton.titleLabel.text];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)websiteButton:(UIButton*)button
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.websiteButton.titleLabel.text]];

}

@end
