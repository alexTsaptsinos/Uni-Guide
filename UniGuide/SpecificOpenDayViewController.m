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

@synthesize openDayDateLabel,timeEndLabel,timeStartLabel,detailsLabel,mapViewOpenDays,bookNowButton,startTime,endTime,link,date,details,uniLatitude,uniLongitude,hasLoadedBool,uniName;

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
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.timeStartLabel.text = self.startTime;
    self.timeEndLabel.text = self.endTime;
    self.detailsLabel.text = self.details;
    self.openDayDateLabel.text = self.date;
    self.bookNowButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CALayer *btnLayer = [bookNowButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    //NSLog(@"uni name: %@", self.uniName);
    PFQuery *queryForUniCode = [PFQuery queryWithClassName:@"Universities"];
    [queryForUniCode whereKey:@"Name" matchesRegex:self.uniName modifiers:@"i"];
    PFObject *object = [queryForUniCode getFirstObject];
    NSString *uniCode = [object valueForKey:@"UKPRN"];
    //NSLog(@"object: %@, unicode: %@",object,uniCode);
    
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
    [locationQuery whereKey:@"UKPRN" equalTo:uniCode];
    PFObject *university = [locationQuery getFirstObject];
    uniLatitude = [university valueForKey:@"LATITUDE"];
    uniLongitude = [university valueForKey:@"LONGITUDE"];
    //NSLog(@"latitude: %@ and longitude: %@", uniLatitude, uniLongitude);
    
    self.hasLoadedBool = NO;
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
