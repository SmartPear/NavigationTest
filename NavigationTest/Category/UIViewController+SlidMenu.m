//
//  UIViewController+SlidMenu.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIViewController+SlidMenu.h"

@implementation UIViewController (SlidMenu)

- (MainViewController *)sldeMenu {
    
    UIViewController *sldeMenu = self.parentViewController;
    
    while (sldeMenu) {
        
        if ([sldeMenu isKindOfClass:[MainViewController class]]) {
            
            return (MainViewController*)sldeMenu;

        } else if (sldeMenu.parentViewController && sldeMenu.parentViewController != sldeMenu) {
            
            sldeMenu = sldeMenu.parentViewController;
            
        } else {
            
            sldeMenu = nil;
        }
    }
    return nil;
}
//push转场动画
- (void)wx_pushViewControler:(UIViewController *)viewController withAnimation:(WXTransitionManager*)transitionManager{
    if (!viewController) {
        return;
    }
    if (!transitionManager) {
        return;
    }
    
    if (self.navigationController) {
        self.navigationController.delegate  = transitionManager;
        viewController.transitioningDelegate = transitionManager;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}
@end
