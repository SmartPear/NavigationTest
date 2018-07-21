//
//  UIDynamicViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIDynamicViewController.h"
#import "AttachView.h"
@interface UIDynamicViewController ()
@property (strong, nonatomic) AttachView * attchVie;

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

}


-(AttachView *)attchVie{
    if (!_attchVie) {
        _attchVie = [[AttachView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        _attchVie.backgroundColor = [UIColor purpleColor];
    }return _attchVie;
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
