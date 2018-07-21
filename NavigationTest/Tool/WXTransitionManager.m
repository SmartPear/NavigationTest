
//
//  WXTransitionManager.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/6.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "WXTransitionManager.h"
#import "GLTransitionAnimation.h"
@interface WXTransitionManager()

/**
 入场动画
 */
@property (nonatomic,strong) GLTransitionAnimation *toTransitionAnimation;

/**
 退场动画
 */
@property (nonatomic,strong) GLTransitionAnimation *backTransitionAnimation;

@end
@implementation WXTransitionManager
- (id)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
    }
    return self;
}

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;

    CGRect toFrame = toView.frame;
    toView.frame = CGRectMake(0, 0, 100, 100);
    toView.center = fromView.center;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = toFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:true];
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.toTransitionAnimation;
}

//非手势转场交互 for dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.backTransitionAnimation;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    
    return self;
}
#pragma mark == 懒加载
- (GLTransitionAnimation *)toTransitionAnimation
{
    if (nil == _toTransitionAnimation) {
//        __weak typeof(self) weakSelf = self;
        _toTransitionAnimation = [[GLTransitionAnimation alloc] initWithDuration:self.duration ];
//        _toTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition)
//        {
//            [weakSelf setToAnimation:contextTransition];
//        };
    }
    return _toTransitionAnimation;
}
- (GLTransitionAnimation *)backTransitionAnimation
{
    if (nil == _backTransitionAnimation) {
//        __weak typeof(self) weakSelf = self;
        _backTransitionAnimation = [[GLTransitionAnimation alloc] initWithDuration:self.duration];
//        _backTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition)
//        {
//            [weakSelf setBackAnimation:contextTransition];
//        };
    }
    return _backTransitionAnimation;
}


@end
