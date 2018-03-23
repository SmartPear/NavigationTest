//
//  CornerTextViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CornerTextViewController.h"
#import "CornerTextView.h"
@interface CornerTextViewController ()
@property (nonatomic,strong) CornerTextView * subView;


@end

@implementation CornerTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subView = [[CornerTextView alloc]init];
    self.subView.frame = CGRectMake(0, 74, self.view.bounds.size.width , self.view.bounds.size.height - 20);
    self.subView.center = self.view.center;
    [self.view addSubview:self.subView];
    self.subView.backgroundColor = [UIColor whiteColor];
    //弧线
    [_subView drawArcWithStartAngle:-M_PI*5/4 endAngle:M_PI/4 lineWidth:10.0f fillColor:[UIColor clearColor] strokeColor:[UIColor grayColor]];
    //刻度
    [_subView drawScaleWithDivide:5 andRemainder:5 strokeColor:[UIColor cyanColor] filleColor:[UIColor clearColor]scaleLineNormalWidth:5 scaleLineBigWidth:10];
    [_subView setNeedsDisplay];
    self.navigationItem.title = @"扇形显示图片";
    self.view.backgroundColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
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
