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

@interface UniInfoCoursePageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString *uniCodeUniInfo;
@property (strong, nonatomic) NSString *uniNameUniInfo;

@property (strong, nonatomic) UITableView *tableViewUniInfo;

@property (strong, nonatomic) NSMutableArray *uniInfoDataSets;
@property (strong, nonatomic) NSMutableArray *uniInfoDataNumbers;
@property (nonatomic, strong) NSString *studentSatisfactionPercentage;

@property (nonatomic) BOOL haveWeComeFromUniversities;
@property (nonatomic) BOOL firstTimeLoad;
@property (strong,nonatomic) UILabel *universityNameLabel;
@property (strong,nonatomic) UIScrollView *scroll;

@property (strong, nonatomic) UIImageView *noInternetImageView;
@property (strong, nonatomic) UILabel *noInternetLabel;


@end