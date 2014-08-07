//
//  CourseInfoPieCustomCellView.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface CourseInfoPieCustomCellView : UITableViewCell <CPTPlotDataSource,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (nonatomic, strong) CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTTheme *selectedTheme;
@property (nonatomic,strong) NSMutableArray *legendTitles;
@property (strong, nonatomic) NSMutableArray *sectionData;
@property (nonatomic) int whichPieChart;
@property (nonatomic) CGPoint legendPoint;
-(void)initPlot;
-(void)configureHost;
-(void)configureGraph;
-(void)configureChart;
-(void)configureLegend;

@property (weak, nonatomic) IBOutlet UIImageView *middleCircleImageView;

@end
