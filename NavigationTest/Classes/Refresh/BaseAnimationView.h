//
//  BaseAnimationView.h
//  PullToRefresh
//
//  Created by 王欣 on 2018/8/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAnimationView : UIView
-(void)animationWithProgress:(CGFloat)progress;
-(void)startAnimation;
-(void)stopAnimaiton;
@end
