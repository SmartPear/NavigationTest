//
//  CoreFoundationViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/26.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CoreFoundationViewController.h"
#import "ProgressView.h"
#import "CircularRunout.h"
@interface CoreFoundationViewController ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) ProgressView * hud;
@property (nonatomic,strong) CircularRunout * circle;
@end

@implementation CoreFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hud];
    self.hud.center = self.view.center;
    [self.view addSubview:self.circle];
    [self.circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 150));
        make.top.equalTo(self.view).offset(100);
    }];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%s",__FUNCTION__);
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.frame = self.view.bounds;
    }return _imgView;
}
-(ProgressView *)hud{
    if (!_hud) {
        _hud = [[ProgressView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    }return _hud;
}
-(CircularRunout *)circle{
    if (!_circle) {
        _circle = [[CircularRunout alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    }return _circle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
