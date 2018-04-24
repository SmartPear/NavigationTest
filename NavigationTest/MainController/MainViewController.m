//
//  MainViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/24.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "UserViewController.h"


//菜单的显示区域占屏幕宽度的百分比
static CGFloat MenuWidthScale = 0.8f;
//遮罩层最高透明度
static CGFloat MaxCoverAlpha = 0.3;
//快速滑动最小触发速度
static CGFloat MinActionSpeed = 500;
#define userWidth [UIScreen mainScreen].bounds.size.width * MenuWidthScale
@interface MainViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UINavigationController * Nav;
@property (nonatomic,strong)UserViewController     * user;
@property (nonatomic,strong)ViewController         * mainControl;
@property (nonatomic,assign)CGPoint  originalPoint;
@property (nonatomic, strong) UIView *coverView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalPoint = CGPointZero;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.Nav.view];
    [self.view addSubview:self.user.view];
    self.Nav.view.frame = self.view.bounds;
    self.user.view.frame  = CGRectMake(-userWidth, 0, userWidth, self.view.bounds.size.height);
    [self addGesture];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    [_Nav.view addSubview:_coverView];
    
}
- (void)tap {
    
    [self showRootViewControllerAnimated:true];
}

-(void)addGesture{
    UIPanGestureRecognizer * ges = [[UIPanGestureRecognizer alloc]init];
    [ges addTarget:self action:@selector(panGestureRecognizerAction:)];
    [self.view addGestureRecognizer:ges];
    ges.delegate = self;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (_Nav.viewControllers.count > 1) {
        return NO;
    }
    return YES;
}
//滑动手势
-(void)panGestureRecognizerAction:(UIPanGestureRecognizer*)pan{
    switch (pan.state) {
            //记录起始位置 方便拖拽移动
        case UIGestureRecognizerStateBegan:
            _originalPoint = _Nav.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChanged:pan];
            break;
        case UIGestureRecognizerStateEnded:
            //滑动结束后自动归位
            [self panEnd:pan];
            break;
        default:
            break;
    }
}

//拖拽方法
-(void)panChanged:(UIPanGestureRecognizer*)pan{
    //拖拽的距离
    CGPoint translation = [pan translationInView:self.view];

    CGFloat X = CGRectGetMinX(_Nav.view.frame);
    if (X<=0 && translation.x<0) {
        return;
    }
    if (X >= userWidth && translation.x>0) {
        return;
    }
    
    //移动主控制器
    _Nav.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
    _coverView.hidden = false;
    [_Nav.view bringSubviewToFront:_coverView];
    
    //判断是否设置了左右菜单
    if (X > 0) {
        _coverView.alpha = CGRectGetMinX(_Nav.view.frame)/userWidth * MaxCoverAlpha;
        self.user.view.frame = CGRectMake(X-userWidth, 0, userWidth, self.view.bounds.size.height);
    }
    
}
//拖拽结束
- (void)panEnd:(UIPanGestureRecognizer*)pan {
    
    //处理快速滑动
    CGFloat speedX = [pan velocityInView:pan.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self dealWithFastSliding:speedX];
        return;
    }
    //正常速度
    if (CGRectGetMinX(_Nav.view.frame) > userWidth/2) {
        [self showLeftViewControllerAnimated:true];
    }else{
        [self showRootViewControllerAnimated:true];
    }
}
//处理快速滑动
- (void)dealWithFastSliding:(CGFloat)speedX {
    //向左滑动
    BOOL swipeRight = speedX > 0;
    //向右滑动
    if (swipeRight) {//向右滑动
        [self showLeftViewControllerAnimated:true];
    }else{
        
        [self showRootViewControllerAnimated:true];
    }
    return;
}
//显示左侧菜单
- (void)showLeftViewControllerAnimated:(BOOL)animated {
    

    [UIView animateWithDuration:0.25 animations:^{
        _Nav.view.frame = CGRectMake(userWidth, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _user.view.frame = CGRectMake(0, 0, userWidth, self.view.bounds.size.height);
    }];
}
//显示主视图
-(void)showRootViewControllerAnimated:(BOOL)animated{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _Nav.view.frame;
        frame.origin.x = 0;
        _Nav.view.frame = frame;
        [self updateLeftMenuFrame];
        _coverView.alpha = 0;

    }completion:^(BOOL finished) {
        _coverView.hidden = true;

    }];
}

//更新左侧菜单位置
- (void)updateLeftMenuFrame {
    
    _user.view.frame = CGRectMake(-userWidth, 0, userWidth, self.view.bounds.size.height);
}

-(UINavigationController *)Nav{
    if (!_Nav) {
        _Nav = [[UINavigationController alloc]initWithRootViewController:self.mainControl];
        [self addChildViewController:_Nav];
    }return _Nav;
}
-(ViewController *)mainControl{
    if (!_mainControl) {
        _mainControl = [[ViewController alloc]init];
    }return _mainControl;
}
-(UserViewController *)user{
    if (!_user) {
        _user = [[UserViewController alloc]init];
        [self addChildViewController:_user];
    }return _user;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
