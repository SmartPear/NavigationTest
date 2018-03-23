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
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray  * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    self.navigationItem.title = @"自主学习";
    self.tableview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%s",__FUNCTION__);
}

//-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"%s",__FUNCTION__);
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString * text = self.dataArr[indexPath.row];
    cell.textLabel.text = text;
    return cell;
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
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]initWithObjects:@"Core Foundation",@"自定义Collection Layout",@"Realmx学习",@"TextKit",@"GCD",@"扇形显示文字", nil];
    }return _dataArr;
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
