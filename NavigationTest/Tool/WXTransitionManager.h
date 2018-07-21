//
//  WXTransitionManager.h
//  NavigationTest
//
//  Created by 王欣 on 2018/7/6.
//  Copyright © 2018年 王欣. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WXTransitionManager : NSObject<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

/**
 转场动画的时间 默认为0.5s
 */
@property (nonatomic,assign) NSTimeInterval duration;
@end
