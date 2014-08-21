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
#import <MessageUI/MessageUI.h>

@interface ContactUniversityPageViewController : UIViewController <MKMapViewDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *contactMapView;

@property (strong, nonatomic) NSString *universityCode;
@property (strong, nonatomic) NSString *universityName;
@property (strong, nonatomic) NSNumber *uniLatitude;
@property (strong, nonatomic) NSNumber *uniLongitude;
@property (nonatomic) BOOL hasLoadedBool;

@property (nonatomic, strong) UIButton *telephoneButton;
@property (nonatomic, strong) UIButton *emailButton;
@property (nonatomic, strong) UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;

@property (nonatomic) BOOL firstTimeLoad;
@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;


@end
