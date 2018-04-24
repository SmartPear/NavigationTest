//
//  MainViewController.h
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
//主视图
@property (nonatomic, strong) UIViewController *rootViewController;
//左侧视图
@property (nonatomic, strong) UIViewController *leftViewController;
//菜单宽度
@property (nonatomic, assign, readonly) CGFloat menuWidth;

-(instancetype)initWithRootViewController:(UIViewController*)rootViewController;

//显示左侧菜单
-(void)showLeftViewControllerAnimated:(BOOL)animated;
@end
