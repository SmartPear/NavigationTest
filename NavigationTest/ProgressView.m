//
//  ProgressView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/7.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "ProgressView.h"

#define kWidth(view)   view.bounds.size.width
#define kHeight(view)  view.bounds.size.height


@interface ProgressView()<CAAnimationDelegate>


@property (nonatomic,strong)CAShapeLayer * backLayer;
@property (nonatomic,strong)UIView * baseView;

@property (nonatomic,strong)UIBezierPath * startPath;
@property (nonatomic,strong)UIBezierPath * midPath;
@property (nonatomic,strong)UIBezierPath * endPath;

@end
@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        [self setupSubView];
    }
    return self;
    
}

-(void)setupSubView{
    
    [self addSubview:self.baseView];
    [self.baseView.layer addSublayer:self.backLayer];
    [self.backLayer removeAllAnimations];
    [self addAnimation];
    
}

//添加动画
-(void)addAnimation{
    CABasicAnimation * base = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    base.fromValue = @[@(0)];
    base.toValue = @[@(M_PI * 2)];
    base.duration = 1.0;
    base.repeatCount = CGFLOAT_MAX;
    base.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_backLayer addAnimation:base forKey:@"aa"];
}



-(UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _baseView.layer.cornerRadius = 6;
        _baseView.layer.masksToBounds = YES;
        _baseView.center = self.center;
        _baseView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }return _baseView;
}

- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        _backLayer.frame = CGRectInset(self.baseView.bounds, 10, 10);
        _backLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _backLayer.lineWidth = 3;
        _backLayer.strokeColor = [UIColor whiteColor].CGColor;
        _backLayer.lineCap = @"round";
        _backLayer.path = self.startPath.CGPath;
        _backLayer.strokeStart = 0.0;
        _backLayer.strokeEnd = 0.3;
        _backLayer.fillMode = kCAFillModeForwards;
    }
    return _backLayer;
}
-(UIBezierPath *)startPath{
    if (!_startPath) {
        _startPath = [UIBezierPath bezierPathWithRoundedRect:_backLayer.bounds cornerRadius:_backLayer.frame.size.width / 2];
        
    }return _startPath;
}


@end
