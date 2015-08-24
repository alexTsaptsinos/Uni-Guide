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
#import "Favourites.h"

@interface ContactUniversityPageViewController : UIViewController <MKMapViewDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MKMapView *contactMapView;

@property (strong, nonatomic) NSString *universityCode;
@property (strong, nonatomic) NSString *universityName;
@property (strong, nonatomic) NSString *courseCodeContact;
@property (strong, nonatomic) NSString *uniLatitude;
@property (strong, nonatomic) NSString *uniLongitude;
@property (nonatomic) BOOL hasLoadedBool;
@property (nonatomic) BOOL haveWeComeFromUniversities;

@property (nonatomic, strong) UIButton *telephoneButton;
@property (nonatomic, strong) UIButton *emailButton;
@property (nonatomic, strong) UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *telephoneLabel;
@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UILabel *websiteLabel;
@property (strong,nonatomic) UILabel *universityNameLabel;
@property (strong,nonatomic) UILabel *addressLabel;
@property (strong,nonatomic) UILabel *addressLabel2;


@property (nonatomic) BOOL firstTimeLoad;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;


@end
