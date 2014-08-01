//
//  UniInfoCoursePageViewController.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UniInfoCoursePageViewController : UIViewController <CPTPlotDataSource, UIActionSheetDelegate,CPTPieChartDataSource,CPTPieChartDelegate>

@property (strong, nonatomic) NSString *uniCodeUniInfo;
@property (strong, nonatomic) PFObject *universityObject;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberOfStudentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBedsLabel;
@property (weak, nonatomic) IBOutlet UILabel *averagePrivateLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageInstituteLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *studentSatisfactionLabel;


@end