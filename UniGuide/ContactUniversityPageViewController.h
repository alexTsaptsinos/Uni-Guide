//
//  ContactUniversityPageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface ContactUniversityPageViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *contactMapView;

@property (weak, nonatomic) IBOutlet UILabel *telephoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *faxNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteAddressLabel;
@property (strong, nonatomic) NSString *universityCode;
@property (strong, nonatomic) NSString *universityName;
@property (strong, nonatomic) NSNumber *uniLatitude;
@property (strong, nonatomic) NSNumber *uniLongitude;


@end
