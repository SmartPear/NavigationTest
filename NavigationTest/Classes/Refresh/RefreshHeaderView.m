//
//  RefreshHeaderView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RefreshHeaderView.h"
#import  <Foundation/Foundation.h>
#import "AnimationView.h"
#import "UIScrollView+Custom.h"

@interface RefreshHeaderView()<UIScrollViewDelegate>

@end
@implementation RefreshHeaderView


+ (RefreshHeaderView*)headerWithRefreshingBlock:(RefreshBlock)refreshingBlock
{
    RefreshHeaderView *cmp = [[self alloc] init];
    cmp.refreshBlock = refreshingBlock;
    return cmp;
}
-(void)prepare{
    [super prepare];
    self.backgroundColor = [UIColor clearColor];
}

-(void)setupFrame{
    CGRect rect = CGRectMake(0, -viewHeight , self.scrollView.bounds.size.width, viewHeight);
    self.frame = rect;
}

//添加
-(void)setupItems{
    [self addSubview:self.animationView];
    self.animationView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * CenterX = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * CenterY = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0];
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeWidth) multiplier:1 constant:120];
        NSLayoutConstraint * Height = [NSLayoutConstraint constraintWithItem:self.animationView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1 constant:50];
    [self addConstraints:@[CenterX,CenterY,width,Height]];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.state == RefreshStateRefreshing){
        return;
    }
    CGFloat preoffset = -self.preContentOffset.y - self.scrollViewOriginalInset.top;
    CGFloat offsetY   = -self.scrollView.contentOffset.y - self.scrollView.re_inset.top;
    CGFloat offset    = MAX(0, offsetY - preoffset);
    self.progress     = MIN(1, offset/viewHeight);
    if (self.progress <= 0) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    if (self.progress >= CriticalProgress) {
        self.state = RefreshStateWillRefresh;
    }else if(self.progress <= 0){
        self.state = RefreshStateIdle;
    }else if (self.progress > 0){
        self.state = RefreshStatePulling;
    }
}

-(void)setState:(RefreshState)state{
    if (self.state == state) {
        NSLog(@"return");
        return;
    }
    [super setState:state];
    if (self.state == RefreshStateIdle) {
        self.hasShake = false;
        self.hidden = YES;
    }else if (self.state == RefreshStatePulling){
        
    }else if ( self.state == RefreshStateWillRefresh){
        if (!self.hasShake) {
            self.hasShake = YES;
            [self makeShake];
        }
        self.hidden = NO;
    }else if (self.state == RefreshStateRefreshing ){
        self.hidden = NO;
        [self Refresh];
    }
}


- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
    UIGestureRecognizerState  state = [[change valueForKey:@"new"] integerValue];
    if (state == UIGestureRecognizerStateEnded) {
        if(self.progress >= CriticalProgress){
            self.state = RefreshStateRefreshing;
        }
    }
}

//开始刷新
-(void)beginRefresh{
    self.state = RefreshStateRefreshing;
}

-(void)Refresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [super beginRefresh];
        self.progress = 1.0;
        [self.animationView addAnimaiton];
        [UIView animateWithDuration:RefreshAnimationTime animations:^{
            CGFloat top = self.scrollViewOriginalInset.top + viewHeight;
            // 增加滚动区域top
            self.scrollView.re_insetT = top;
            // 设置滚动位置
            CGPoint offset = self.scrollView.contentOffset;
            offset.y = -top;
            [self.scrollView setContentOffset:offset animated:YES];
        } completion:^(BOOL finished) {
            [self executeRefreshingCallback];
        }];
    });
}



//结束刷新
-(void)endRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.state != RefreshStateRefreshing)return;
        [UIView animateWithDuration:RefreshAnimationTime animations:^{
            self.scrollView.re_insetT = self.scrollViewOriginalInset.top;
        } completion:^(BOOL finished) {
            [self.animationView removeAnimation];
            self.state = RefreshStateIdle;
        }];
    });
}

@end
