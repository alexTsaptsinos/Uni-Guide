//
//  PieCompareCollectionViewCell.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"


@interface PieCompareCollectionViewCell : UICollectionViewCell <CPTPlotDataSource,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (nonatomic, strong) CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTTheme *selectedTheme;
@property (nonatomic,strong) NSMutableArray *legendTitles;
@property (strong, nonatomic) NSMutableArray *sectionData;
@property (nonatomic) int whichPieChart;
@property (nonatomic) CGPoint legendPoint;
@property (strong, nonatomic) UIImageView *noDataImageView;
@property (strong, nonatomic) UILabel *noDataLabel;
@property (nonatomic) BOOL onlyPieChart;

-(void)initPlot;
-(void)configureHost;
-(void)configureGraph;
-(void)configureChart;
-(void)configureLegend;


@end
