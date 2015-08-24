//
//  SpecificOpenDayViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SpecificOpenDayViewController.h"

@interface SpecificOpenDayViewController ()

@end

@implementation SpecificOpenDayViewController

@synthesize mapViewOpenDays,bookNowButton,startTime,endTime,link,date,details,uniLatitude,uniLongitude,hasLoadedBool,uniName,activityIndicator,firstTimeLoad, universityLabel,dateDate,addressLabel,locatedAt,isThereLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Open Day";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    NSLog(@"details: %@",self.details);
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self.activityIndicator startAnimating];
    self.mapViewOpenDays.hidden = YES;
    self.bookNowButton.hidden = YES;
    self.firstTimeLoad = YES;
    
    universityLabel = [[UILabel alloc] init];
    universityLabel.frame = CGRectMake(0, 10, widthFloat, 20);
    universityLabel.text = self.uniName;
    universityLabel.textColor = [UIColor blackColor];
    universityLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    universityLabel.textAlignment = NSTextAlignmentCenter;
    universityLabel.adjustsFontSizeToFitWidth = YES;
    universityLabel.numberOfLines = 1;
    universityLabel.hidden = YES;
    [self.view addSubview:universityLabel];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    if (self.firstTimeLoad == YES) {
        PFQuery *queryForUniCode = [PFQuery queryWithClassName:@"Institution1213"];
        [queryForUniCode whereKey:@"Institution" equalTo:self.uniName];
        [queryForUniCode getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                NSString *uniCode = [object valueForKey:@"UKPRN"];
                // USE IMAGE
                int i = arc4random() % 7;
                UIImage *image;
                if (i == 0) {
                    image = [UIImage imageNamed:@"stock1.jpg"];
                } else if (i == 1) {
                    image = [UIImage imageNamed:@"stock2.jpg"];
                } else if (i == 2) {
                    image = [UIImage imageNamed:@"stock3.jpg"];
                } else if (i == 3) {
                    image = [UIImage imageNamed:@"stock4.jpg"];
                } else if (i == 4) {
                    image = [UIImage imageNamed:@"stock5.jpg"];
                } else if (i == 5) {
                    image = [UIImage imageNamed:@"stock6.jpg"];
                } else {
                    image = [UIImage imageNamed:@"stock7.jpg"];
                }
                UIImageView *testImageView = [[UIImageView alloc] init];
                testImageView.frame = CGRectMake(0,0,image.size.width*(heightFloat - 220)/image.size.height,heightFloat - 220);
                testImageView.image = image;
                testImageView.contentMode = UIViewContentModeScaleToFill;
                testImageView.alpha = 0.4;
                testImageView.hidden = YES;
                [self.view addSubview:testImageView];
                [self.view sendSubviewToBack:testImageView];
                
                // SET UP CALENDAR
                UIImageView *calendarImageView = [[UIImageView alloc] init];
                calendarImageView.frame = CGRectMake(15,40,150, 150);
                calendarImageView.image = [UIImage imageNamed:@"calendarblank.png"];
                calendarImageView.contentMode = UIViewContentModeScaleToFill;
                calendarImageView.alpha = 1;
                calendarImageView.hidden = YES;
                [self.view addSubview:calendarImageView];
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateDate];
                NSInteger dayInteger = [components day];
                NSInteger yearInteger = [components year];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat=@"MMMM";
                NSString * monthString = [[dateFormatter stringFromDate:dateDate] capitalizedString];
                dateFormatter.dateFormat=@"EEEE";
                NSString * dayString = [[dateFormatter stringFromDate:dateDate] capitalizedString];
                
                UILabel *yearLabel = [[UILabel alloc] init];
                yearLabel.frame = CGRectMake(40, 61, 100, 20);
                yearLabel.text = [NSString stringWithFormat:@"%ld",(long)yearInteger];
                yearLabel.textAlignment = NSTextAlignmentCenter;
                yearLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
                yearLabel.textColor = [UIColor blackColor];
                yearLabel.hidden = YES;
                [self.view addSubview:yearLabel];
                
                UILabel *dayLabel = [[UILabel alloc] init];
                dayLabel.frame = CGRectMake(25, 90, 130, 25);
                dayLabel.text = [NSString stringWithFormat:@"%@",dayString];
                dayLabel.textAlignment = NSTextAlignmentCenter;
                dayLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
                dayLabel.textColor = [UIColor blackColor];
                dayLabel.hidden = YES;
                [self.view addSubview:dayLabel];
                
                UILabel *dayNumberLabel = [[UILabel alloc] init];
                dayNumberLabel.frame = CGRectMake(40, 118, 100, 40);
                dayNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)dayInteger];
                dayNumberLabel.textAlignment = NSTextAlignmentCenter;
                dayNumberLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:50];
                dayNumberLabel.textColor = [UIColor blackColor];
                dayNumberLabel.hidden = YES;
                [self.view addSubview:dayNumberLabel];
                
                UILabel *monthLabel = [[UILabel alloc] init];
                monthLabel.frame = CGRectMake(25, 157, 130, 25);
                monthLabel.text = [NSString stringWithFormat:@"%@",monthString];
                monthLabel.textAlignment = NSTextAlignmentCenter;
                monthLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
                monthLabel.textColor = [UIColor blackColor];
                monthLabel.hidden = YES;
                [self.view addSubview:monthLabel];
                
                UILabel *timingsLabel = [[UILabel alloc] init];
                timingsLabel.frame = CGRectMake(172, 58, 140, 25);
                NSString *timingsString = startTime;
                timingsString = [timingsString stringByAppendingString:@" - "];
                timingsString = [timingsString stringByAppendingString:endTime];
                timingsLabel.text = @"Timings";
                timingsLabel.textAlignment = NSTextAlignmentCenter;
                timingsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
                timingsLabel.textColor = [UIColor blackColor];
                timingsLabel.hidden = YES;
                timingsLabel.numberOfLines = 3;
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0.0f, timingsLabel.frame.size.height, timingsLabel.frame.size.width, 1.0f);
                bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
                bottomBorder.hidden = YES;
                [timingsLabel.layer addSublayer:bottomBorder];
                [self.view addSubview:timingsLabel];
                
                UILabel *timingsLabel2 = [[UILabel alloc] init];
                timingsLabel2.frame = CGRectMake(172, 83, 140, 25);
                timingsLabel2.text = [NSString stringWithFormat:@"%@",timingsString];
                timingsLabel2.textAlignment = NSTextAlignmentCenter;
                timingsLabel2.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                timingsLabel2.textColor = [UIColor blackColor];
                timingsLabel2.hidden = YES;
                timingsLabel2.numberOfLines = 0;
                timingsLabel2.adjustsFontSizeToFitWidth = YES;
                [self.view addSubview:timingsLabel2];
                
                UILabel *detailsLabel = [[UILabel alloc] init];
                detailsLabel.frame = CGRectMake(172, 118, 140, 25);
                detailsLabel.text = [NSString stringWithFormat:@"Details"];
                detailsLabel.textAlignment = NSTextAlignmentCenter;
                detailsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
                detailsLabel.textColor = [UIColor blackColor];
                CALayer *bottomBorder2 = [CALayer layer];
                bottomBorder2.frame = CGRectMake(0.0f, detailsLabel.frame.size.height, detailsLabel.frame.size.width, 1.0f);
                bottomBorder2.backgroundColor = [UIColor blackColor].CGColor;
                bottomBorder2.hidden = YES;
                [detailsLabel.layer addSublayer:bottomBorder2];
                detailsLabel.hidden = YES;
                detailsLabel.numberOfLines = 1;
                [self.view addSubview:detailsLabel];
                
                UILabel *detailsLabel2 = [[UILabel alloc] init];
                detailsLabel2.frame = CGRectMake(172, 143, 140, 45);
                detailsLabel2.text = [NSString stringWithFormat:@"%@",self.details];
                detailsLabel2.textAlignment = NSTextAlignmentCenter;
                detailsLabel2.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                detailsLabel2.textColor = [UIColor blackColor];
                detailsLabel2.hidden = YES;
                detailsLabel2.numberOfLines = 0;
                detailsLabel2.adjustsFontSizeToFitWidth = YES;
                [self.view addSubview:detailsLabel2];
                
                
                mapViewOpenDays = [[MKMapView alloc] init];
                mapViewOpenDays.frame = CGRectMake(0, heightFloat - 220, widthFloat, 220);
                mapViewOpenDays.delegate = self;
                //[[mapViewOpenDays layer] setBorderWidth:2.0f];
               // [[mapViewOpenDays layer] setBorderColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f].CGColor];//[UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f].CGColor];
                [self.view addSubview:mapViewOpenDays];
                
                bookNowButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [bookNowButton setTitle:@"Book Now" forState:UIControlStateNormal];
                bookNowButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                [bookNowButton addTarget:self action:@selector(bookNowButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                [bookNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                bookNowButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                bookNowButton.exclusiveTouch = YES;
                bookNowButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];//[UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
                [[bookNowButton layer] setBorderWidth:2.0f];
                [[bookNowButton layer] setBorderColor:[UIColor blackColor].CGColor];
                bookNowButton.frame = CGRectMake(0, heightFloat - 50, widthFloat, 50);
                [self.view addSubview:bookNowButton];
                
                PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
                [locationQuery whereKey:@"UKPRN" equalTo:uniCode];
                [locationQuery whereKeyExists:@"INSTBEDS"];
                
                [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
                    if (!error) {
                        NSArray *bedNumbersString = [objects valueForKey:@"INSTBEDS"];
                        NSLog(@"bed nos: %@",bedNumbersString);
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
                        if (bedNumbersSorted.count == 0) {
                            // THERE IS NO LOCATION ON THE KIS DATABASE
                            isThereLocation = NO;
                            
                        } else {
                        NSNumber *topBedNumber = [bedNumbersSorted objectAtIndex:0];
                        NSString *topBedString = [topBedNumber stringValue];
                        NSInteger originalIndexPath = [bedNumbersString indexOfObject:topBedString];
                        NSArray *latitudes = [objects valueForKey:@"LATITUDE"];
                        NSArray *longitudes = [objects valueForKey:@"LONGITUDE"];
                        uniLatitude = [latitudes objectAtIndex:originalIndexPath];
                        uniLongitude = [longitudes objectAtIndex:originalIndexPath];
                        NSLog(@"latitude: %@ and longitude: %@", uniLatitude, uniLongitude);
                            isThereLocation = YES;
                        }
                        
                        UILabel *addressLabelTitle = [[UILabel alloc] init];
                        addressLabelTitle.frame = CGRectMake(20, 195, widthFloat-40, 25);
                        addressLabelTitle.textAlignment = NSTextAlignmentCenter;
                        addressLabelTitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
                        addressLabelTitle.textColor = [UIColor blackColor];//[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];//[UIColor blackColor];
                        addressLabelTitle.hidden = YES;
                        addressLabelTitle.numberOfLines = 1;
                        // Add a bottomBorder.
                        CALayer *bottomBorder3 = [CALayer layer];
                        bottomBorder3.frame = CGRectMake(0.0f, addressLabelTitle.frame.size.height, addressLabelTitle.frame.size.width, 1.0f);
                        bottomBorder3.backgroundColor = [UIColor blackColor].CGColor;
                        bottomBorder3.hidden = YES;
                        [addressLabelTitle.layer addSublayer:bottomBorder3];
                        [self.view addSubview:addressLabelTitle];
                        
                        addressLabel = [[UILabel alloc] init];
                        addressLabel.frame = CGRectMake(20, 220, widthFloat - 40, 60);
                        addressLabel.textAlignment = NSTextAlignmentCenter;
                        addressLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
                        addressLabel.textColor = [UIColor blackColor];
                        addressLabel.hidden = YES;
                        addressLabel.numberOfLines = 0;
                        addressLabel.adjustsFontSizeToFitWidth = YES;
                        [self.view addSubview:addressLabel];
                        
                        if (isThereLocation == YES) {
                            CLGeocoder *ceo = [[CLGeocoder alloc]init];
                            CLLocation *loc = [[CLLocation alloc]initWithLatitude:[uniLatitude floatValue] longitude:[uniLongitude floatValue]]; //insert your coordinates
                            [ceo reverseGeocodeLocation:loc
                                      completionHandler:^(NSArray *placemarks, NSError *error) {
                                          if (!error) {
                                              
                                              CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                              //String to hold address
                                              locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                                              //locatedAt = [NSString stringWithFormat:@"%@",locatedAt];
                                              addressLabel.text = locatedAt;
                                              addressLabelTitle.text = @"Address";
                                              
                                              
                                          }
                                          else {
                                              NSLog(@"Could not locate");
                                              addressLabelTitle.text = @"Address";
                                              addressLabel.text = @"No address available";
                                              addressLabel.textColor = [UIColor lightGrayColor];
                                              
                                          }
                                      }];
                        } else {
                            addressLabelTitle.text = @"Address";
                            addressLabel.text = @"No address available";
                            addressLabel.textColor = [UIColor grayColor];

                        }
                        
                        
                        self.mapViewOpenDays.hidden = NO;
                        self.bookNowButton.hidden = NO;
                        self.firstTimeLoad = NO;
                        universityLabel.hidden = NO;
                        testImageView.hidden = NO;
                        calendarImageView.hidden = NO;
                        yearLabel.hidden = NO;
                        dayLabel.hidden = NO;
                        dayNumberLabel.hidden = NO;
                        monthLabel.hidden = NO;
                        timingsLabel.hidden = NO;
                        timingsLabel2.hidden = NO;
                        detailsLabel.hidden = NO;
                        detailsLabel2.hidden = NO;
                        addressLabel.hidden = NO;
                        addressLabelTitle.hidden = NO;
                        bottomBorder.hidden = NO;
                        bottomBorder2.hidden = NO;
                        bottomBorder3.hidden = NO;
                        [self.activityIndicator stopAnimating];
                        
                        self.hasLoadedBool = NO;
                        self.firstTimeLoad = NO;
                    }
                    else {
                        NSLog(@"error: %@ %@",error,[error userInfo]);
                    }
                    
                }];
                
            } else {
                // THERE WAS AN ERROR!!
                UIImageView *noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthFloat, heightFloat)];
                noInternetImageView.backgroundColor = [UIColor lightGrayColor];
                UILabel *noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 160, 150)];
                noInternetLabel.text = @"We're sorry, but this data is not available offline";
                noInternetLabel.numberOfLines = 0;
                noInternetLabel.textAlignment = NSTextAlignmentCenter;
                [noInternetImageView addSubview:noInternetLabel];
                [self.view addSubview:noInternetImageView];
            }
        }];
        
        
    }
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    // Image creation code here
    if (self.hasLoadedBool == NO && isThereLocation == YES) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([uniLatitude doubleValue], [uniLongitude doubleValue]);
        point.title = self.uniName;
        NSArray *anotations = [[NSArray alloc] initWithObjects:point, nil];
        [mapViewOpenDays showAnnotations:anotations animated:YES];
        
        MKCoordinateRegion region;
        
        //    region.span=span;
        region.center.latitude = [uniLatitude doubleValue];
        region.center.longitude = [uniLongitude doubleValue];
        float spanX = 0.05;
        float spanY = 0.05;
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        
        [self.mapViewOpenDays setRegion:region animated:YES];
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

-(void)viewWillAppear:(BOOL)animated {
    
    //Uk Region
    if (self.firstTimeLoad == YES) {
        MKCoordinateRegion homeRegion;
        homeRegion.center.latitude = 54.013175;
        homeRegion.center.longitude = 99;//-2.3252278;
        float homeSpanX = 10;
        float homeSpanY = 10;
        homeRegion.span.latitudeDelta = homeSpanX;
        homeRegion.span.longitudeDelta = homeSpanY;
        //[self.mapViewOpenDays setRegion:homeRegion];
        [self.mapViewOpenDays setRegion:homeRegion animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [mapItem setName:self.uniName];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

- (void)bookNowButtonPressed{
    
    NSString *linkWithHttp = @"http://";
    NSLog(@"link first: %@", self.link);
    linkWithHttp = [linkWithHttp stringByAppendingString:self.link];
    NSLog(@"link: %@", linkWithHttp);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",link]]];
    
}
@end
