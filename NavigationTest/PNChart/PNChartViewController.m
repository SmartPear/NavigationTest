//
//  PNChartViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "PNChartViewController.h"

@interface PNChartViewController ()<PNChartDelegate>
@property (nonatomic,strong) PNBarChart * barChart;

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

    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^NSString *(CGFloat yLabelValue) {
 
        return [NSString stringWithFormat:@"%alf",yLabelValue];

    };
 

    self.barChart.yChartLabelWidth = 20.0; // Y坐标label宽度
    self.barChart.chartMarginLeft = 30.0;
    self.barChart.chartMarginRight = 10.0;
    self.barChart.chartMarginTop = 5.0;
    self.barChart.chartMarginBottom = 10.0;
    self.barChart.legendPosition  = PNLegendPositionLeft;
    self.barChart.labelMarginTop = 5.0; // X坐标刻度的上边距
    self.barChart.showChartBorder = YES; // 坐标轴
    [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
    [self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
    
    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen]];
    self.barChart.isShowNumbers = NO; // 显示各条状图的数值
    [self.barChart strokeChart];
    self.barChart.delegate = self;
    
    [self.view addSubview:self.barChart];
  
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
