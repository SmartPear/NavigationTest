//
//  CircularRunout.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/13.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CircularRunout.h"
@interface CircularRunout()
@property (nonatomic,strong)CAShapeLayer * oneLayer;
@property (nonatomic,strong)CAShapeLayer * twoLayer;
@property (nonatomic,assign)CGFloat layerWidth;
@property (nonatomic,strong)UIBezierPath * startPath;
@property (nonatomic,strong)UIBezierPath * midPath;
@property (nonatomic,strong)UIBezierPath * endPath;
@property (nonatomic,strong)UIView * baseView;
@end

@implementation CircularRunout

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSublayers];
        self.clipsToBounds = YES;
        
    }return self;
}

-(void)setupSublayers{
    
    [self addSubview:self.baseView];
    self.baseView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint * centerXCons = [NSLayoutConstraint constraintWithItem:self.baseView attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0];
    NSLayoutConstraint * centerYCons = [NSLayoutConstraint constraintWithItem:self.baseView attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1 constant:0];
    NSLayoutConstraint * widthCons = [NSLayoutConstraint constraintWithItem:self.baseView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeWidth) multiplier:1 constant:80];
    NSLayoutConstraint * heightCons = [NSLayoutConstraint constraintWithItem:self.baseView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeHeight) multiplier:1.0 constant:80];
    [self addConstraints:@[centerXCons,centerYCons]];
    [self.baseView addConstraints:@[widthCons,heightCons]];
    [self layoutIfNeeded];
    [self.baseView.layer addSublayer:self.oneLayer];
    [self.baseView.layer addSublayer:self.twoLayer];
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
    [self addAnimaiton];
}

//添加动画
-(void)addAnimaiton{
    CAKeyframeAnimation * animaiton = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animaiton.repeatCount = CGFLOAT_MAX;
    animaiton.path = self.startPath.CGPath;
    
    CAKeyframeAnimation * baseAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    baseAniamtion.values = @[@(1),@(4),@(1)];
    baseAniamtion.keyTimes = @[@(0),@(0.5),@(1.0)];

    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[animaiton,baseAniamtion];
    group.duration = 1.5;
    group.repeatCount = CGFLOAT_MAX;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.oneLayer addAnimation:group forKey:@"group"];
    
    CAKeyframeAnimation * animaiton1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animaiton1.path        = self.endPath.CGPath;
    
    CAAnimationGroup * group2 = [CAAnimationGroup animation];
    group2.animations  = @[animaiton1,baseAniamtion];
    group2.duration    = 1.5;
    group2.repeatCount = CGFLOAT_MAX;
    group2.removedOnCompletion = NO;
    group2.fillMode = kCAFillModeForwards;
    
    [self.twoLayer addAnimation:group2 forKey:@"group2"];
}

-(void)layoutSubviews{
    CGFloat width = self.baseView.bounds.size.width;
    CGFloat height = self.baseView.bounds.size.height;
    CGFloat layerWidth = height * 0.25;
    CGRect onerect = CGRectMake(0 ,height * 0.5 - layerWidth/2, layerWidth, layerWidth);
    CGRect twoRect = CGRectMake(width - height * 0.4,height * 0.5 - layerWidth/2, layerWidth,layerWidth);

    self.oneLayer.frame = onerect;
    self.twoLayer.frame = twoRect;
    UIBezierPath * twoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_twoLayer.bounds, 2, 2) cornerRadius:(_twoLayer.bounds.size.height - 2)/2];
    self.twoLayer.path = twoPath.CGPath;

    UIBezierPath * onePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.oneLayer.bounds, 2, 2) cornerRadius:(self.oneLayer.bounds.size.height - 2)/2];
    self.oneLayer.path = onePath.CGPath;
}


-(UIBezierPath *)startPath{
    CGFloat width = self.baseView.bounds.size.width;
    CGFloat height = self.baseView.bounds.size.height;
    CGRect rect = self.oneLayer.frame;
    _startPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, height/2.0) radius:width/2.0 - (rect.origin.x + rect.size.width/2 + 14) startAngle:M_PI endAngle:M_PI * 3 clockwise:YES];
    return _startPath;
}
-(UIBezierPath *)endPath{
    CGFloat width = self.baseView.bounds.size.width;
    CGFloat height = self.baseView.bounds.size.height;
    CGRect rect = self.twoLayer.frame;
    _endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, height/2.0) radius:width/2.0 - (rect.origin.x + rect.size.width/2 + 14) startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    return _endPath;
}


-(CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.lineWidth = 1;
        _oneLayer.strokeColor = UIColor.whiteColor.CGColor;
        _oneLayer.fillColor = UIColor.greenColor.CGColor;
        _oneLayer.backgroundColor = UIColor.clearColor.CGColor;
    }return _oneLayer;
}
-(CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.strokeColor = UIColor.whiteColor.CGColor;
        _twoLayer.lineWidth = 1;
        _twoLayer.fillColor = [UIColor redColor].CGColor;
        _twoLayer.backgroundColor = UIColor.clearColor.CGColor;
    }return _twoLayer;
}

-(UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc]initWithFrame:CGRectZero];
        _baseView.layer.cornerRadius = 6;
        _baseView.layer.masksToBounds = YES;
        _baseView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }return _baseView;
}

@end
