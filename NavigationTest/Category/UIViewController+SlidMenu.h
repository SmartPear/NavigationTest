//
//  UIViewController+SlidMenu.h
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "WXTransitionManager.h"
@interface UIViewController (SlidMenu)

@property (nonatomic, strong, readonly) MainViewController * sldeMenu;

/**
 push动画
 
 @param viewController 被push viewController
 @param transitionManager 控制类
 */
- (void)wx_pushViewControler:(UIViewController *)viewController withAnimation:(WXTransitionManager*)transitionManager;

@end
