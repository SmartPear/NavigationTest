//
//  RefreshComponent.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/18.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RefreshComponent.h"
#import "UIScrollView+Custom.h"
#import "UIScrollView+Refresh.h"


@interface RefreshComponent()
@property (nonatomic,assign)BOOL hasDrag;
@property (nonatomic,strong) UIPanGestureRecognizer * pan;
@end
@implementation RefreshComponent

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self prepare];
        [self setupItems];
    }return self;
}
//准备
-(void)prepare{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.progress = 0.0;
    self.state = RefreshStateIdle;
}

-(void)setupItems{}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.state == RefreshStateWillRefresh) {
        // 预防view还没显示出来就调用了beginRefreshing
        self.state = RefreshStateRefreshing;
    }
}

-(void)setState:(RefreshState)state{
    _state = state;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
    
}
//将要添加到父视图
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (![newSuperview isKindOfClass:[UIScrollView class]])return;
    [self removeObservers];
    if (newSuperview) {
        self.scrollView = (UIScrollView*)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
        [self setupFrame];
        [self addObservers];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setupFrame];
    
}
-(void)setupFrame{}
-(void)beginRefresh{
    self.hasDrag = YES;
}
//结束刷新
-(void)endRefresh{
    
}
#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:@"state" options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [self.superview removeObserver:self forKeyPath:@"contentSize"];
    [self.pan removeObserver:self forKeyPath:@"state"];
    self.pan = nil;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange:change];
    }
    // 看不见
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (!self.hasDrag) {
            self.preContentOffset = self.scrollView.contentOffset;
            self.scrollViewOriginalInset = self.scrollView.re_inset;
            [self setupFrame];
            return;
        }
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:@"state"]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    self.hasDrag = YES;
    
}
- (void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshBlock) {
            self.refreshBlock();
        }
    });
}

-(void)makeShake{
    
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleLight];
        [generator prepare];
        [generator impactOccurred];
    }
}

-(AnimationView *)animationView{
    if(!_animationView){
        _animationView = [[AnimationView alloc]initWithFrame:CGRectMake(0, 0, 120, 50)];
    }return _animationView;
}

@end
