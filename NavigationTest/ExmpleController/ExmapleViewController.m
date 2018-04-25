//
//  ExmapleViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/25.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "ExmapleViewController.h"

@interface ExmapleViewController ()
@property (nonatomic,strong)UIImageView * img;
@end

@implementation ExmapleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.img];
    self.img.image = [UIImage imageNamed:@"QQChatList"];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.contentMode = UIViewContentModeScaleToFill;
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
