//
//  PNChartViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "PNChartViewController.h"

@interface PNChartViewController ()<PNChartDelegate>
@property (nonatomic,strong) PNLineChart * lineChart;

@end

@implementation PNChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeLineChart];
    // Do any additional setup after loading the view.
}
//设置柱状图
-(void)makeLineChart{

    self.lineChart = [[PNLineChart alloc]init];
    
    self.lineChart.backgroundColor = [UIColor whiteColor];
    self.lineChart.yGridLinesColor = [UIColor grayColor];
    [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
        obj.pointLabelColor = [UIColor blackColor];
    }];
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    self.lineChart.showCoordinateAxis = YES;
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.xLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:8.0];
    //        [self.lineChart setXLabels:@[@"SEP 1", @"SEP 2", @"SEP 3", @"SEP 4", @"SEP 5", @"SEP 6", @"SEP 7"]];
    [self.lineChart setXLabels:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11",@"5", @"6", @"7", @"8", @"9", @"10", @"11"]];
    self.lineChart.yLabelColor = [UIColor blackColor];
    self.lineChart.xLabelColor = [UIColor blackColor];
    
    // added an example to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.showGenYLabels = NO;
    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 200;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0",
                                 @"50",
                                 @"100",
                                 @"150",
                                 @"200",
                                 @"250",
                                 @"300",
                                 @"50",
                                 @"100",
                                 @"150",
                                 @"200",
                                 @"250",
                                 @"300",
                                 ]
     ];
    
    // Line Chart #1
    NSArray *data01Array = @[@124, @134, @128, @127, @144, @139, @134, @134, @132, @130, @116, @95];
    PNLineChartData *data01 = [PNLineChartData new];
    
//    data01.rangeColors = @[
//                           [[PNLineChartColorRange alloc] initWithRange:NSMakeRange(1, 54) color:[UIColor redColor]],
//                           [[PNLineChartColorRange alloc] initWithRange:NSMakeRange(55, 6) color:[UIColor yellowColor]],
//                           [[PNLineChartColorRange alloc] initWithRange:NSMakeRange(61, 49) color:[UIColor greenColor]],
//                           [[PNLineChartColorRange alloc] initWithRange:NSMakeRange(110, 20) color:[UIColor yellowColor]],
//                           [[PNLineChartColorRange alloc] initWithRange:NSMakeRange(130, 470) color:[UIColor redColor]]
//                           ];
    data01.dataTitle = @"Alpha";
    data01.color = PNFreshGreen;
    data01.pointLabelColor = [UIColor blackColor];
    data01.alpha = 0.3f;
    data01.showPointLabel = YES;
    data01.pointLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:9.0];
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = PNRed;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray *data02Array = @[@0.0, @18.1, @26.4, @30.2, @12.2, @16.2, @27.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Beta";
    data02.pointLabelColor = [UIColor blackColor];
    data02.color = PNTwitterColor;
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
        obj.pointLabelColor = [UIColor blackColor];
    }];
    
    
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor redColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
}
/**
 * Callback method that gets invoked when the user taps on the chart line.
 */
- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    
}

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex{
    
}

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex{
    
}


- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex{
    
}
- (void)didUnselectPieItem{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
