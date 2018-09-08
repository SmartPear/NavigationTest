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
#import "WebViewViewController.h"
#import "EncryptionViewController.h"
#import "TempleViewController.h"
#import "RotateViewController.h"
#import "TestViewController.h"
#import <FZRefresh/FZ_Refresh.h>
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray  * dataArr;
@property (nonatomic,strong) UIButton * avterBtn;
@property (nonatomic,strong) NSArray * classNames;

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
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
       __weak typeof(self) weakSelf = self;
    RefreshHeaderView * header = [RefreshHeaderView headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableview.fz_header endRefresh];
        });
    } AnimationType:(AnimationTypeCustom)];
    self.tableview.fz_header = header;
//    [self transFormTime];
    
}
-(void)transFormTime{
    NSInteger  timeInterval = 1526272225000;
    NSDateFormatter * formate = [[NSDateFormatter alloc]init];
    formate.timeZone = [NSTimeZone localTimeZone];
    formate.timeStyle = NSDateFormatterMediumStyle;
    formate.dateStyle = NSDateFormatterMediumStyle;
    formate.dateFormat = @"YYYY-MM-dd HH:mm";
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSString * str = [formate stringFromDate:date];
    self.navigationItem.title = str;
}

-(void)headTapAction:(UIButton*)btn{
    
    [self.sldeMenu showLeftViewControllerAnimated:true];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self transFormTime];
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
    NSString * text = self.classNames[indexPath.row];
    UIViewController * control ;
    
    if ([text isEqualToString:@"UIDynamicViewController"]|[text isEqualToString:@"RefreshViewController"]) {
        control = [[NSClassFromString(text) alloc]initWithNibName:text bundle:nil];
    }else {
        control = [[NSClassFromString(text) alloc]init];
    }

    [self.navigationController pushViewController:control animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]initWithObjects:@"Core Foundation",@"自定义Collection Layout",@"Realmx学习",@"TextKit",@"GCD",@"扇形显示文字",@"谓词",@"柱状图",@"webview",@"加密",@"新组件",@"旋转",@"测试",@"悬浮按钮",@"删除动画",@"滤镜",@"下拉刷新",@"视频播放", nil];
    }return _dataArr;
}
-(NSArray *)classNames{
    if (!_classNames) {
        _classNames = [[NSArray alloc]initWithObjects:@"CoreFoundationViewController",@"CollectionViewController",@"RealmViewController",@"TextKitUViewController",@"GCDViewController",@"CornerTextViewController",@"NSPredicateController",@"PNChartViewController",@"WebViewViewController",@"EncryptionViewController",@"TempleViewController",@"RotateViewController",@"TestViewController",@"UIDynamicViewController",@"aaaViewController",@"CiFilterViewController",@"RefreshViewController",@"PlayerViewController", nil];
        
    }return _classNames;
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
