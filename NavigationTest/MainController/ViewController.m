//
//  ViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/7.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "ViewController.h"
#import "CoreFoundationViewController.h"
#import "CollectionViewController.h"
#import "RealmViewController.h"
#import "TextKitUViewController.h"
#import <objc/runtime.h>
#import "GCDViewController.h"
#import "CornerTextViewController.h"
#import "NSPredicateController.h"
#import "UIViewController+SlidMenu.h"
#import "PNChartViewController.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray  * dataArr;
@property (nonatomic,strong) UIButton * avterBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.navigationItem.title = @"自主学习";
    UIView * view = [[UIView alloc]initWithFrame:self.avterBtn.frame];
    [view addSubview:self.avterBtn];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem  = left;
    self.tableview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void)headTapAction:(UIButton*)btn{
    
    [self.sldeMenu showLeftViewControllerAnimated:true];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString * text = self.dataArr[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}
- (NSString *)transform:(NSString *)chinese {
    
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * text = self.dataArr[indexPath.row];
    
    if (indexPath.row == 0) {
        CoreFoundationViewController * control = [[CoreFoundationViewController alloc]init];
        control.navigationItem.title = text;
        [self.navigationController pushViewController:control animated:YES];
    }else if (indexPath.row == 1){
        CollectionViewController * collection = [[CollectionViewController alloc]init];
        collection.navigationItem.title =text;
        [self.navigationController pushViewController:collection animated:YES];
    }else if (indexPath.row == 2){
        RealmViewController * realm = [[RealmViewController alloc]init];
        [self.navigationController pushViewController:realm animated:YES];
    }else if (indexPath.row == 3){
        TextKitUViewController * text = [[TextKitUViewController alloc]init];
        [self.navigationController pushViewController:text animated:YES];
    }else if(indexPath.row ==4){
        GCDViewController * gcd = [[GCDViewController alloc]init];
        [self.navigationController pushViewController:gcd animated:YES];
    }else if (indexPath.row == 5){
        CornerTextViewController* cornerText = [[CornerTextViewController alloc]init];
        [self.navigationController pushViewController:cornerText animated:YES];
    }else if (indexPath.row == 6){
        NSPredicateController * control = [[NSPredicateController alloc]init];
        [self.navigationController pushViewController:control animated:true];
    }else if (indexPath.row == 7){
        PNChartViewController * chart = [[PNChartViewController alloc]init];
        [self.navigationController pushViewController:chart animated:true];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]initWithObjects:@"Core Foundation",@"自定义Collection Layout",@"Realmx学习",@"TextKit",@"GCD",@"扇形显示文字",@"谓词",@"柱状图", nil];
    }return _dataArr;
}

-(UIButton *)avterBtn{
    if (!_avterBtn) {
        _avterBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _avterBtn.frame = CGRectMake(0, 0, 34, 34);
        _avterBtn.layer.masksToBounds = true;
        _avterBtn.layer.cornerRadius = 17;
        [_avterBtn setImage:[UIImage imageNamed:@"ChatHead"] forState:(UIControlStateNormal)];
        [_avterBtn addTarget:self action:@selector(headTapAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }return _avterBtn;
}

-(UITableView *)tableview {
    
    if(!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource =self;
    }return _tableview;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
