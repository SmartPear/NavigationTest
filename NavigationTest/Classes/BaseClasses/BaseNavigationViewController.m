//
//  BaseNavigationViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/6/13.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = false;
    // Do any additional setup after loading the view.
}

-(BOOL)shouldAutorotate{
    return YES;
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
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
