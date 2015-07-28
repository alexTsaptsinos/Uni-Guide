//
//  UniInfoCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UniInfoCustomCellView.h"
#import <QuartzCore/QuartzCore.h>
#import "Favourites.h"

@interface UniInfoCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString *uniCodeUniInfo;
@property (strong, nonatomic) NSString *uniNameUniInfo;
@property (strong, nonatomic) NSString *courseCodeUniInfo;

@property (strong, nonatomic) UITableView *tableViewUniInfo;

@property (strong, nonatomic) NSMutableArray *uniInfoDataSets;
@property (strong, nonatomic) NSMutableArray *uniInfoDataNumbers;
@property (nonatomic, strong) NSString *studentSatisfactionPercentage;
//@property (nonatomic, strong) NSString *averageCostOfLivingInstitute;
//@property (nonatomic, strong) NSString *averageCostOfLivingPrivate;


@property (nonatomic) BOOL haveWeComeFromUniversities;
@property (nonatomic) BOOL firstTimeLoad;
@property (strong,nonatomic) UILabel *universityNameLabel;
@property (strong,nonatomic) UIScrollView *scroll;
@property (nonatomic) BOOL haveComeFromFavourites;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@end