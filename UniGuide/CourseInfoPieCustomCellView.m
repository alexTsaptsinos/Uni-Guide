//
//  CourseInfoPieCustomCellView.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "CourseInfoPieCustomCellView.h"

@implementation CourseInfoPieCustomCellView



@synthesize cellTitleLabel,middleCircleImageView,legendTitles,sectionData,legendPoint,whichPieChart;

@synthesize hostView = hostView_;
@synthesize selectedTheme = selectedTheme_;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}



#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return self.legendTitles.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    if (CPTPieChartFieldSliceWidth == fieldEnum)
    {
        return [self.sectionData objectAtIndex:index];
    }
    return [NSDecimalNumber zero];
}


-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    return [self.legendTitles objectAtIndex:index];
}


- (CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
{
    CPTFill *areaGradientFill ;
    
    if (self.whichPieChart == 1) {
        if (idx==0)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:227.0f/255.0f green:174.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
        else if (idx==1)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:151.0f/255.0f green:205.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
        else if (idx==2)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:203.0f/255.0f green:83.0f/255.0f blue:87.0f/255.0f alpha:1.0f]];
        else if (idx == 3)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:82.0f/255.0f green:194.0f/255.0f blue:198.0f/255.0f alpha:1.0f]];
        else if (idx==4)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:122.0f/255.0f green:83.0f/255.0f blue:173.0f/255.0f alpha:1.0f]];
        else if (idx==5)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:42.0f/255.0f green:56.0f/255.0f blue:68.0f/255.0f alpha:1.0f]];
    }
    else if (self.whichPieChart == 2) {
        if (idx==0)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:82.0f/255.0f green:194.0f/255.0f blue:198.0f/255.0f alpha:1.0f]];
        else if (idx==1)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:203.0f/255.0f green:83.0f/255.0f blue:87.0f/255.0f alpha:1.0f]];
        else if (idx==2)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:42.0f/255.0f green:56.0f/255.0f blue:68.0f/255.0f alpha:1.0f]];
        
    }
    else if (self.whichPieChart == 3) {
        if (idx==0)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:151.0f/255.0f green:205.0f/255.0f blue:103.0f/255.0f alpha:1.0f]];
        else if (idx==1)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:227.0f/255.0f green:174.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
        else if (idx==2)
            return areaGradientFill= [CPTFill fillWithColor:[CPTColor colorWithComponentRed:122.0f/255.0f green:83.0f/255.0f blue:173.0f/255.0f alpha:1.0f]];
        
    }
    
    return areaGradientFill;
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configureChart];
    [self configureLegend];
   
}

-(void)configureHost {

    // 2 - Create host view
    CGRect parentRect = CGRectMake(190, 0, 130, 130);
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:parentRect];
    self.hostView.allowPinchScaling = NO;

    [self addSubview:self.hostView];
}

-(void)configureGraph {
    
    // 1 - Create and initialize graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    self.hostView.hostedGraph = graph;
    graph.paddingLeft = 10.0f;
    graph.paddingTop = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingBottom = 0.0f;
    graph.axisSet = nil;

}

-(void)configureChart {
    // 1 - Get reference to graph
    CPTGraph *graph = self.hostView.hostedGraph;
    // 2 - Create chart
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
    pieChart.delegate = self;
    pieChart.pieRadius = (self.hostView.bounds.size.height * 0.6) / 2;
    pieChart.identifier = graph.title;
    pieChart.startAngle = M_PI_4;
    pieChart.sliceDirection = CPTPieDirectionClockwise;
    // 3 - Create gradient
    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
    overlayGradient.gradientType = CPTGradientTypeRadial;
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.9];
    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.4] atPosition:1.0];
    pieChart.overlayFill = [CPTFill fillWithGradient:overlayGradient];
    // 4 - Add chart to graph    
    [graph addPlot:pieChart];
}

-(void)configureLegend {
    
    CPTGraph *graph = self.hostView.hostedGraph;
    // 2 - Create legend
    CPTLegend *theLegend = [CPTLegend legendWithGraph:graph];
    // 3 - Configure legend
    theLegend.numberOfColumns = 2;
    theLegend.fill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f]];
    CPTMutableTextStyle *textStyle = [[CPTMutableTextStyle alloc] init];
    [textStyle setFontName:@"Arial"];
    [textStyle setColor:[CPTColor colorWithComponentRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    [textStyle setFontSize:12];
    [theLegend setTextStyle:textStyle];
    // 4 - Add legend to graph
    graph.legend = theLegend;
    graph.legendDisplacement = self.legendPoint;

    CPTLayer *subLayer = [[CPTLayer alloc] init];
    [subLayer setFrame:CGRectMake(42, 37, 56, 56)];
    subLayer.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor;
    subLayer.cornerRadius = 28.0f;

    [self.hostView.layer addSublayer:subLayer];
}

- (void)layoutSubviews
{
   // NSLog(@"legend titles: %@",self.legendTitles);
   // NSLog(@"data: %@", self.sectionData);
    if (self.sectionData.count != 0) {
        [self initPlot];
    } else {
        UIImageView *noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 100)];
        noDataImageView.backgroundColor = [UIColor clearColor];
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 80)];
        noDataLabel.text = @"We're sorry, but we appear to have no data for this course.";
        noDataLabel.numberOfLines = 0;
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        noDataLabel.font = [UIFont fontWithName:@"Arial" size:13];
        [noDataImageView addSubview:noDataLabel];
        [self addSubview:noDataImageView];
    }

}

- (void)awakeFromNib
{
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
