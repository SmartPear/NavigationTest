//
//  BaseAnimationView.m
//  PullToRefresh
//
//  Created by 王欣 on 2018/8/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "BaseAnimationView.h"

@implementation BaseAnimationView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepare];
    }return self;
}
-(void)prepare{
    self.backgroundColor = [UIColor yellowColor];
}
//更新进度
-(void)animationWithProgress:(CGFloat)progress{
    
}
//开始动画
-(void)startAnimation{
    
}

//结束动画
-(void)stopAnimaiton{
    
}
@end
