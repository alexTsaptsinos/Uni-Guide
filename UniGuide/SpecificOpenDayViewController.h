//
//  SpecificOpenDayViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface SpecificOpenDayViewController : UIViewController <MKMapViewDelegate>
@property (strong,nonatomic) MKMapView *mapViewOpenDays;
@property (strong,nonatomic) UIButton *bookNowButton;
@property (strong,nonatomic) UILabel *universityLabel;
@property (strong,nonatomic) UILabel *addressLabel;

@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSDate *dateDate;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *uniName;
@property (strong, nonatomic) NSString *locatedAt;


@property (strong, nonatomic) NSNumber *uniLatitude;
@property (strong, nonatomic) NSNumber *uniLongitude;
@property (nonatomic) BOOL hasLoadedBool;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) BOOL firstTimeLoad;
@property (nonatomic) BOOL isThereLocation;


@end
