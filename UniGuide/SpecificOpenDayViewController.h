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

@interface SpecificOpenDayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *openDayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapViewOpenDays;
@property (weak, nonatomic) IBOutlet UIButton *bookNowButton;
- (IBAction)bookNowButtonPressed:(id)sender;

@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *uniName;
@property (strong, nonatomic) NSNumber *uniLatitude;
@property (strong, nonatomic) NSNumber *uniLongitude;
@property (nonatomic) BOOL hasLoadedBool;

@end
