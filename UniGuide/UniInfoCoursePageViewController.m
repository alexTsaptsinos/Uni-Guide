//
//  UniInfoCoursePageViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniInfoCoursePageViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface UniInfoCoursePageViewController (){
    
}

@property (nonatomic, strong) CPTGraphHostingView *hostView;
-(void)initPlot;
-(void)configureHost;
-(void)configureGraph;
-(void)configureChart;
-(void)configureLegend;


@end

@implementation UniInfoCoursePageViewController


@synthesize uniCodeUniInfo;
@synthesize hostView = hostView_;

#pragma mark - UIViewController lifecycle methods
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // The plot is initialized here, since the view bounds have not transformed for landscape until now
    [self initPlot];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Uni Info", @"Uni Info");
        self.tabBarItem.image = [UIImage imageNamed:@"city_hall-32"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"uni code in view will appear: %@",self.uniCodeUniInfo);
    
}

- (CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
{
    CPTFill *areaGradientFill ;
    
    if (idx==0)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor redColor]];
    else if (idx==1)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor blueColor]];

    
    return areaGradientFill;
}


#pragma mark - CPTPlotDataSource methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 2;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    
    NSArray *numbers = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:46],[NSNumber numberWithInt:54], nil];
    
    return [numbers objectAtIndex:index];
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
    
    // 1 - Define label text style
    static CPTMutableTextStyle *labelText = nil;
    if (!labelText) {
        labelText= [[CPTMutableTextStyle alloc] init];
        labelText.color = [CPTColor grayColor];
    }

    // 4 - Set up display label
    NSArray *labelValues = [[NSArray alloc] initWithObjects:@"46%",@"54%", nil];
    
    
    // 5 - Create and return layer with label text
    return [[CPTTextLayer alloc] initWithText:[labelValues objectAtIndex:index] style:labelText];
    
}

-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    NSArray *maleFemaleArray = [[NSArray alloc] initWithObjects:@"Male",@"Female", nil];
    return [maleFemaleArray objectAtIndex:index];
}

#pragma mark - UIActionSheetDelegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
}

#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
    [self configureGraph];
    [self configureChart];
    [self configureLegend];
}

-(void)configureHost {
    
    // 1 - Set up view frame
  //  CGRect parentRect = self.view.bounds;
//    parentRect = CGRectMake(parentRect.origin.x,
//                            (parentRect.origin.y + navigationBarSize.height),
//                            parentRect.size.width,
//                            (parentRect.size.height - navigationBarSize.height));
    CGRect parentRect = CGRectMake(20, 20, 150, 150); //where in x, where in y, width, height
    // 2 - Create host view, this hosts the graph
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:parentRect];
    self.hostView.allowPinchScaling = NO;
    //self.hostView.backgroundColor = [UIColor clearColor]; //automatically does clear!!
    [self.view addSubview:self.hostView];
    
}

-(void)configureGraph {
    
    // 1 - Create and initialize graph
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    self.hostView.hostedGraph = graph;
    graph.paddingLeft = 0.0f;
    graph.paddingTop = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingBottom = 0.0f;
    graph.axisSet = nil;
    // 2 - Set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontName = @"Helvetica-Bold";
    textStyle.fontSize = 16.0f;
    // 3 - Configure title
    NSString *title = @"Male to Female %";
    graph.title = title;
    graph.titleTextStyle = textStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(10.0f, 10.0f);

    
}

-(void)configureChart {
    
    // 1 - Get reference to graph
    CPTGraph *graph = self.hostView.hostedGraph;
    // 2 - Create chart
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
    pieChart.delegate = self;
    pieChart.pieRadius = 50;
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
    
    // 1 - Get graph instance
    CPTGraph *graph = self.hostView.hostedGraph;
    // 2 - Create legend
    CPTLegend *theLegend = [CPTLegend legendWithGraph:graph];
    // 3 - Configure legend
    theLegend.numberOfColumns = 1;
    //theLegend.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    //theLegend.borderLineStyle = [CPTLineStyle lineStyle];
    theLegend.cornerRadius = 5.0;
    // 4 - Add legend to graph
    graph.legend = theLegend;
    graph.legendAnchor = CPTRectAnchorRight;
    graph.legendDisplacement = CGPointMake(100.0f, 0.0f);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
