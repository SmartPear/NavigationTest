//
//  RotateViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/6/13.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()
@property (nonatomic,strong)UIImageView * img;
@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).inset(10);
    }];
    // Do any additional setup after loading the view.
}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jj"]];
        _img.contentMode = UIViewContentModeScaleAspectFit;
    }return _img;
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
