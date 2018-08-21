//
//  UIDynamicViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIDynamicViewController.h"
#import "AttachView.h"
#import "BezierView.h"
@interface UIDynamicViewController ()
@property (strong, nonatomic) AttachView * attchVie;
@property (nonatomic,strong)BezierView *bezerView;
//@Por
@end

@implementation UIDynamicViewController

-(void)awakeFromNib{
    [super awakeFromNib];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.attchVie];
    [self.view addSubview:self.bezerView];
    [self.bezerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

}


-(AttachView *)attchVie{
    if (!_attchVie) {
        _attchVie = [[AttachView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _attchVie.backgroundColor = [UIColor purpleColor];
    }return _attchVie;
}
-(BezierView *)bezerView{
    if (!_bezerView) {
        _bezerView = [[BezierView alloc]init];
    }return _bezerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
