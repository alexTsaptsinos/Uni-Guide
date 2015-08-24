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

@synthesize universityCode,contactMapView,universityName,uniLongitude,uniLatitude,hasLoadedBool,emailButton,websiteButton,telephoneButton,telephoneLabel,websiteLabel,emailLabel,firstTimeLoad,noInternetImageView,noInternetLabel,courseCodeContact,haveWeComeFromUniversities,universityNameLabel,addressLabel,addressLabel2;

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
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - 20 - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    
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
    
    self.contactMapView = [[MKMapView alloc] init];
    contactMapView.frame = CGRectMake(0, heightFloat - 250, widthFloat, 250);
    contactMapView.delegate = self;
    [[contactMapView layer] setBorderWidth:2.0f];
    [[contactMapView layer] setBorderColor:[UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f].CGColor];
    [self.view addSubview:contactMapView];
    
    telephoneLabel = [[UILabel alloc] init];
    telephoneLabel.frame = CGRectMake(10, 40, widthFloat - 20, 30);
    telephoneLabel.textAlignment = NSTextAlignmentLeft;
    telephoneLabel.text = @"T:";
    telephoneLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    telephoneLabel.textColor = [UIColor blackColor];
    telephoneLabel.userInteractionEnabled = YES;
    [self.view addSubview:telephoneLabel];
    
    emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(10, 70, widthFloat - 20, 30);
    emailLabel.textAlignment = NSTextAlignmentLeft;
    emailLabel.text = @"E:";
    emailLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    emailLabel.textColor = [UIColor blackColor];
    emailLabel.userInteractionEnabled = YES;
    [self.view addSubview:emailLabel];
    
    websiteLabel = [[UILabel alloc] init];
    websiteLabel.frame = CGRectMake(10, 100, widthFloat - 20, 30);
    websiteLabel.textAlignment = NSTextAlignmentLeft;
    websiteLabel.text = @"W:";
    websiteLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    websiteLabel.textColor = [UIColor blackColor];
    websiteLabel.userInteractionEnabled = YES;
    [self.view addSubview:websiteLabel];
    
    addressLabel = [[UILabel alloc] init];
    addressLabel.frame = CGRectMake(10, 130, widthFloat - 20, 70);
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = @"A:";
    addressLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.hidden = YES;
    [self.view addSubview:addressLabel];
    
    addressLabel2 = [[UILabel alloc] init];
    addressLabel2.frame = CGRectMake(widthFloat/2-10-120, 5, widthFloat/2 + 110, 60);
    addressLabel2.textAlignment = NSTextAlignmentRight;
    addressLabel2.font = [UIFont fontWithName:@"Arial" size:18];
    addressLabel2.textColor = [UIColor blackColor];
    addressLabel2.adjustsFontSizeToFitWidth = YES;
    addressLabel2.hidden = YES;
    addressLabel2.numberOfLines = 0;
    [self.addressLabel addSubview:addressLabel2];
    
    if (self.haveWeComeFromUniversities == YES) {
        telephoneLabel.frame = CGRectMake(10, 10, widthFloat - 20, 30);
        emailLabel.frame = CGRectMake(10, 40, widthFloat - 20, 30);
        websiteLabel.frame = CGRectMake(10, 70, widthFloat - 20, 30);
        addressLabel.frame = CGRectMake(10, 100, widthFloat - 20, 70);
        contactMapView.frame = CGRectMake(0, heightFloat - 280, widthFloat, 280);
    }
    
    MKCoordinateRegion homeRegion;
    homeRegion.center.latitude = 54.013175;
    homeRegion.center.longitude = -2.3252278;
    float homeSpanX = 10;
    float homeSpanY = 10;
    homeRegion.span.latitudeDelta = homeSpanX;
    homeRegion.span.longitudeDelta = homeSpanY;
    
    [self.contactMapView setRegion:homeRegion animated:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    
    noInternetLabel.hidden = YES;
    noInternetImageView.hidden = YES;
    
    if (self.firstTimeLoad == YES) {
        
        universityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 20)];
        universityNameLabel.text = self.universityName;
        universityNameLabel.textAlignment = NSTextAlignmentCenter;
        universityNameLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
        universityNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        universityNameLabel.hidden = YES;
        [self.view addSubview:universityNameLabel];
        
        telephoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [telephoneButton addTarget:self
                            action:@selector(telephoneButton:)
                  forControlEvents:UIControlEventTouchUpInside];
        telephoneButton.exclusiveTouch = YES;
        telephoneButton.frame = CGRectMake(widthFloat/2-10-120, 0, widthFloat/2 + 110, 30);
        telephoneButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        telephoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [telephoneButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [telephoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [telephoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.telephoneLabel addSubview:telephoneButton];
        
        emailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [emailButton addTarget:self
                        action:@selector(emailButton:)
              forControlEvents:UIControlEventTouchUpInside];
        emailButton.exclusiveTouch = YES;
        emailButton.frame = CGRectMake(widthFloat/2-10-120, 0, widthFloat/2 + 110, 30);
        emailButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        emailButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        emailButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        emailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [emailButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [emailButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.emailLabel addSubview:emailButton];
        
        websiteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [websiteButton addTarget:self
                          action:@selector(websiteButton:)
                forControlEvents:UIControlEventTouchUpInside];
        websiteButton.exclusiveTouch = YES;
        websiteButton.frame = CGRectMake(widthFloat/2-10-120, 0, widthFloat/2 + 110, 30);
        websiteButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
        websiteButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        websiteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        websiteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [websiteButton setTitleColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
        [websiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [websiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.websiteLabel addSubview:websiteButton];
        
        NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",self.courseCodeContact,self.universityCode] andSortKey:@"courseName"];
        
        
        
        if (temp2.count != 0) {
            // IF A FAVOURITE LOAD FROM CORE DATA
            Favourites *tempObject = [temp2 objectAtIndex:0];
            [telephoneButton setTitle:tempObject.telephoneContact forState:UIControlStateNormal];
            
            NSString *email = tempObject.emailContact;
            if (email.length == 0) {
                emailButton.enabled = NO;
                [emailButton setTitle:@"Not available" forState:UIControlStateDisabled];
                [emailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
                
            } else {
                [emailButton setTitle:email forState:UIControlStateNormal];
            }
            
            [websiteButton setTitle:tempObject.websiteContact forState:UIControlStateNormal];
            
            uniLatitude = tempObject.latitudeContact;
            uniLongitude = tempObject.longitudeContact;
            addressLabel2.text = tempObject.address;
            
            self.hasLoadedBool = NO;
            self.contactMapView.hidden = NO;
            self.telephoneButton.hidden = NO;
            self.emailButton.hidden = NO;
            self.websiteButton.hidden = NO;
            self.telephoneLabel.hidden = NO;
            self.emailLabel.hidden = NO;
            self.websiteLabel.hidden = NO;
            addressLabel.hidden = NO;
            addressLabel2.hidden = NO;
            [self.activityIndicator stopAnimating];
            self.firstTimeLoad = NO;
            if (self.haveWeComeFromUniversities == YES) {
                self.universityNameLabel.hidden = YES;
            } else {
                self.universityNameLabel.hidden = NO;
            }
            
        } else {
        // NOT A FAV SO QUERY
            
        PFQuery *contactQuery = [PFQuery queryWithClassName:@"Institution1213"];
        [contactQuery whereKey:@"UKPRN" equalTo:self.universityCode];
        [contactQuery selectKeys:[NSArray arrayWithObjects:@"TelephoneContact",@"EmailContact",@"WebsiteContact", nil]];
        [contactQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSArray *contactDetails = [objects objectAtIndex:0];
                
                [telephoneButton setTitle:[contactDetails valueForKey:@"TelephoneContact"] forState:UIControlStateNormal];
                
                NSString *email = [contactDetails valueForKey:@"EmailContact"];
                if (email.length == 0) {
                    emailButton.enabled = NO;
                    [emailButton setTitle:@"Not available" forState:UIControlStateDisabled];
                    [emailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
                } else {
                    [emailButton setTitle:email forState:UIControlStateNormal];
                }
                
                [websiteButton setTitle:[contactDetails valueForKey:@"WebsiteContact"] forState:UIControlStateNormal];
                
            }
            else {
                NSLog(@"error");
                noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, 320, 500)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
            }
        }];
        
        
        
        
        PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
        [locationQuery whereKey:@"UKPRN" equalTo:universityCode];
        [locationQuery whereKeyExists:@"INSTBEDS"];
        
        [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSArray *bedNumbersString = [objects valueForKey:@"INSTBEDS"];
                NSLog(@"boobooboo: %@",bedNumbersString);
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSMutableArray *bedNumbers = [[NSMutableArray alloc] init];
                int i;
                for (i=0; i<bedNumbersString.count; i++) {
                    NSString *tempString = [bedNumbersString objectAtIndex:i];
                    NSNumber *tempNumber = [f numberFromString:tempString];
                    [bedNumbers addObject:tempNumber];
                }
                NSLog(@"bed numbers: %@",bedNumbers);
                
                NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
                NSArray *bedNumbersSorted = [bedNumbers sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
                
                //NSArray *bedNumbersSorted = [bedNumbers sortedArrayUsingSelector: @selector(compare:)];
                NSLog(@"bed numbers sorted: %@", bedNumbersSorted);
                NSNumber *topBedNumber = [bedNumbersSorted objectAtIndex:0];
                NSString *topBedString = [topBedNumber stringValue];
                NSInteger originalIndexPath = [bedNumbersString indexOfObject:topBedString];
                NSArray *latitudes = [objects valueForKey:@"LATITUDE"];
                NSArray *longitudes = [objects valueForKey:@"LONGITUDE"];
                uniLatitude = [latitudes objectAtIndex:originalIndexPath];
                uniLongitude = [longitudes objectAtIndex:originalIndexPath];
                NSLog(@"latitude: %@ and longitude: %@", uniLatitude, uniLongitude);
                
                CLGeocoder *ceo = [[CLGeocoder alloc]init];
                CLLocation *loc = [[CLLocation alloc]initWithLatitude:[uniLatitude floatValue] longitude:[uniLongitude floatValue]]; //insert your coordinates
                [ceo reverseGeocodeLocation:loc
                          completionHandler:^(NSArray *placemarks, NSError *error) {
                              if (!error) {
                                  
                                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                  //String to hold address
                                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                                  addressLabel2.text = locatedAt;
                                  
                                  
                              }
                              else {
                                  NSLog(@"Could not locate");
                                  addressLabel2.text = @"Could not find address";
                                  
                              }
                          }];
                
                self.hasLoadedBool = NO;
                self.contactMapView.hidden = NO;
                self.telephoneButton.hidden = NO;
                self.emailButton.hidden = NO;
                self.websiteButton.hidden = NO;
                self.telephoneLabel.hidden = NO;
                self.emailLabel.hidden = NO;
                self.websiteLabel.hidden = NO;
                addressLabel.hidden = NO;
                addressLabel2.hidden = NO;
                if (self.haveWeComeFromUniversities == YES) {
                    self.universityNameLabel.hidden = YES;
                } else {
                    self.universityNameLabel.hidden = NO;
                }
                [self.activityIndicator stopAnimating];
                self.firstTimeLoad = NO;
            }
            else {
                NSLog(@"error");
                noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, 320, 500)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
            }
            
        }];
        }
        
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *view = nil;
    static NSString *reuseIdentifier = @"MapAnnotation";
    
    // Return a MKPinAnnotationView with a simple accessory button
    view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if(!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        rightButton.frame = CGRectMake(5, 5, 20, 20);
        rightButton.backgroundColor = [UIColor clearColor];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"right4-512.png"] forState:UIControlStateNormal];
        view.rightCalloutAccessoryView = rightButton;
        view.canShowCallout = YES;
        view.animatesDrop = YES;
    }
    
    return view;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([uniLatitude floatValue], [uniLongitude floatValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:self.universityName];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
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
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
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
