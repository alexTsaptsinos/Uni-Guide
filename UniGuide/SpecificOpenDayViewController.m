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

@synthesize openDayDateLabel,timeEndLabel,timeStartLabel,mapViewOpenDays,bookNowButton,startTime,endTime,link,date,details,uniLatitude,uniLongitude,hasLoadedBool,uniName,activityIndicator,detailsTitleLabel,openDayLabel,firstTimeLoad,hyphenLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.timeStartLabel.text = self.startTime;
    self.timeEndLabel.text = self.endTime;
    NSLog(@"details: %@",self.details);
    self.detailsTextView.text = self.details;
    self.detailsTextView.font = [UIFont fontWithName:@"Arial" size:15];
    self.detailsTextView.editable = NO;
    self.detailsTextView.scrollEnabled = NO;
    self.detailsTextView.backgroundColor = [UIColor clearColor];
    self.openDayDateLabel.text = self.date;
    self.bookNowButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self.activityIndicator startAnimating];
    self.timeStartLabel.hidden = YES;
    self.timeEndLabel.hidden = YES;
    self.openDayLabel.hidden = YES;
    self.openDayDateLabel.hidden = YES;
    self.detailsTextView.hidden = YES;
    self.detailsTitleLabel.hidden = YES;
    self.mapViewOpenDays.hidden = YES;
    self.bookNowButton.hidden = YES;
    self.hyphenLabel.hidden = YES;
    self.firstTimeLoad = YES;
    
    
    CALayer *btnLayer = [bookNowButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.firstTimeLoad == YES) {
        //NSLog(@"uni name: %@", self.uniName);
        PFQuery *queryForUniCode = [PFQuery queryWithClassName:@"Universities"];
        [queryForUniCode whereKey:@"Name" matchesRegex:self.uniName modifiers:@"i"];
        PFObject *object = [queryForUniCode getFirstObject];
        NSString *uniCode = [object valueForKey:@"UKPRN"];
        //NSLog(@"object: %@, unicode: %@",object,uniCode);
        
        PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
        [locationQuery whereKey:@"UKPRN" equalTo:uniCode];
        
        [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
            if (!error) {
                NSArray *bedNumbersString = [objects valueForKey:@"INSTBEDS"];
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
                
                self.timeStartLabel.hidden = NO;
                self.timeEndLabel.hidden = NO;
                self.openDayLabel.hidden = NO;
                self.openDayDateLabel.hidden = NO;
                self.detailsTextView.hidden = NO;
                self.detailsTitleLabel.hidden = NO;
                self.mapViewOpenDays.hidden = NO;
                self.bookNowButton.hidden = NO;
                self.firstTimeLoad = NO;
                self.hyphenLabel.hidden = NO;
                [self.activityIndicator stopAnimating];
                
                self.hasLoadedBool = NO;
                self.firstTimeLoad = NO;
            }
            else {
                NSLog(@"error: %@ %@",error,[error userInfo]);
            }
            
        }];
    }
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    // Image creation code here
    if (self.hasLoadedBool == NO) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([uniLatitude doubleValue], [uniLongitude doubleValue]);
        point.title = self.navigationItem.title;
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

-(void)viewWillAppear:(BOOL)animated {
    
    //Uk Region
    MKCoordinateRegion homeRegion;
    homeRegion.center.latitude = 54.013175;
    homeRegion.center.longitude = -2.3252278;
    float homeSpanX = 10;
    float homeSpanY = 10;
    homeRegion.span.latitudeDelta = homeSpanX;
    homeRegion.span.longitudeDelta = homeSpanY;
    
    [self.mapViewOpenDays setRegion:homeRegion animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookNowButtonPressed:(id)sender {
    
    NSString *linkWithHttp = @"http://";
    NSLog(@"link first: %@", self.link);
    linkWithHttp = [linkWithHttp stringByAppendingString:self.link];
    NSLog(@"link: %@", linkWithHttp);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",link]]];

}
@end
