//
//  TestViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/5.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "TestViewController.h"
#import "WXTransitionManager.h"
#import "UIViewController+SlidMenu.h"
@interface TestViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIButton * btn;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1];
    [self test];
    self.modalTransitionStyle = UIModalPresentationCustom;
    self.navigationController.modalTransitionStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [self.view layoutIfNeeded];
    // Do any additional setup after loading the view.
}
-(void)test{
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, CFSTR("您好"));
    CFStringTransform(string, NULL, kCFStringTransformToLatin, false);
    NSString *aNSString = (__bridge NSString *)string;
    NSLog(@"%@",aNSString);
}
-(void)transfrom:(UIButton*)btn{
    
    WXTransitionManager * manager = [[WXTransitionManager alloc]init];
    TestViewController * test = [[TestViewController alloc]init];
    test.transitioningDelegate = self;
    [self wx_pushViewControler:test withAnimation:manager];
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        [_btn setTitle:@"转场" forState:(UIControlStateNormal)];
        _btn.backgroundColor = [UIColor blackColor];
        [_btn addTarget:self action:@selector(transfrom:) forControlEvents:(UIControlEventTouchUpInside)];
    }return _btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
