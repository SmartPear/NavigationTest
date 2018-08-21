//
//  RefreshComponent.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/18.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationView.h"

#define viewHeight  70
#define RefreshAnimationTime 0.25
#define CriticalProgress 1.0  //可以开始刷新的临界区域
typedef  void(^RefreshBlock)(void);

typedef NS_ENUM(NSUInteger, RefreshState) {
    /** 普通闲置状态 */
    RefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    RefreshStatePulling,
    /** 正在刷新中的状态 */
    RefreshStateRefreshing,
    /** 即将刷新的状态 */
    RefreshStateWillRefresh,
    RefreshStateEnd,//刷新结束
    /** 所有数据加载完毕，没有更多的数据了 */
    RefreshStateNoMoreData
};


//刷新的基类
@interface RefreshComponent : UIView

@property (nonatomic,assign) RefreshState  state;
@property (nonatomic,  weak) UIScrollView * scrollView;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) AnimationView * animationView;
@property (nonatomic,assign) BOOL hasShake;
@property (nonatomic,  copy) RefreshBlock refreshBlock;

@property (nonatomic,assign) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic,assign) CGPoint preContentOffset;
//布局子视图,需子类重写
-(void)setupItems;
-(void)makeShake;
-(void)setupFrame;
-(void)prepare;
//子类重写这些方法
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change;
- (void)executeRefreshingCallback;
-(void)beginRefresh;
//结束刷新
-(void)endRefresh;
@end
