//
//  ContactUniversityPageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ContactUniversityPageViewController.h"

@interface ContactUniversityPageViewController ()

@end

@implementation ContactUniversityPageViewController

@synthesize telephoneNumberLabel,faxNumberLabel,websiteAddressLabel,emailAddressLabel,universityCode,contactMapView,universityName,uniLongitude,uniLatitude;

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
    NSLog(@"code: %@", self.universityCode);
    
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
    [locationQuery whereKey:@"UKPRN" equalTo:universityCode];
    PFObject *university = [locationQuery getFirstObject];
    uniLatitude = [university valueForKey:@"LATITUDE"];
    uniLongitude = [university valueForKey:@"LONGITUDE"];
    NSLog(@"latitude: %@ and longitude: %@", uniLatitude, uniLongitude);
   
//    MKCoordinateRegion homeRegion;
//    homeRegion.center.latitude = 54.013175;
//    homeRegion.center.longitude = -2.3252278;
//    float homeSpanX = 10;
//    float homeSpanY = 10;
//    homeRegion.span.latitudeDelta = homeSpanX;
//    homeRegion.span.longitudeDelta = homeSpanY;
//    
//    [self.contactMapView setRegion:homeRegion animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([uniLatitude doubleValue], [uniLongitude doubleValue]);
    point.title = self.universityName;
    NSArray *anotations = [[NSArray alloc] initWithObjects:point, nil];
    [contactMapView showAnnotations:anotations animated:YES];
    
    MKCoordinateRegion region;
    region.center.latitude = [uniLatitude doubleValue];
    region.center.longitude = [uniLongitude doubleValue];
    float spanX = 0.05;
    float spanY = 0.05;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    
    [self.contactMapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
