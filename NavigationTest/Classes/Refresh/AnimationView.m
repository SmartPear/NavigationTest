//
//  AnimationView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "AnimationView.h"
@interface AnimationView()
@property (nonatomic,strong)CAShapeLayer * oneLayer;
@property (nonatomic,strong)CAShapeLayer * twoLayer;
@property (nonatomic,strong)UIBezierPath * startPath;
@property (nonatomic,strong)UIBezierPath * midPath;
@property (nonatomic,strong)UIBezierPath * endPath;
@property (nonatomic,assign)CGFloat layerWidth;
@end
#define animationTime 1.2
@implementation AnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSublayers];
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }return self;
}

-(void)setupSublayers{
    
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
    

}

-(void)removeAnimation{
    
    [self.oneLayer removeAllAnimations];
    [self.twoLayer removeAllAnimations];
}
-(void)addAnimaiton{
    CAKeyframeAnimation * animaiton = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animaiton.duration = animationTime;
    animaiton.repeatCount = CGFLOAT_MAX;
    animaiton.path = self.endPath.CGPath;

    CAKeyframeAnimation * baseAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    baseAniamtion.values = @[@(1),@(4),@(1)];
    baseAniamtion.keyTimes = @[@(0),@(0.5),@(1.0)];
    baseAniamtion.duration = animationTime;

    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[animaiton,baseAniamtion];
    group.duration = animationTime;
    group.repeatCount = CGFLOAT_MAX;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.oneLayer addAnimation:group forKey:@"group"];

    CAKeyframeAnimation * animaiton1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animaiton1.path    = self.startPath.CGPath;

    CAAnimationGroup * group2 = [CAAnimationGroup animation];
    group2.animations  = @[animaiton1,baseAniamtion];
    group2.duration    = animationTime;
    group2.repeatCount = CGFLOAT_MAX;
    group2.removedOnCompletion = NO;
    group2.fillMode = kCAFillModeForwards;

    [self.twoLayer addAnimation:group2 forKey:@"group2"];
}



-(void)layoutSubviews{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _layerWidth = height * 0.4;
    CGRect onerect = CGRectMake(0 ,height * 0.5 - _layerWidth/2, _layerWidth, _layerWidth);
    CGRect twoRect = CGRectMake(width - height * 0.4,height * 0.5 - _layerWidth/2, _layerWidth,_layerWidth);
    
    self.oneLayer.frame = onerect;
    self.twoLayer.frame = twoRect;
    UIBezierPath * twoPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_twoLayer.bounds, 2, 2) cornerRadius:(_twoLayer.bounds.size.height - 2)/2];
    self.twoLayer.path = twoPath.CGPath;
    UIBezierPath * onePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.oneLayer.bounds, 2, 2) cornerRadius:(self.oneLayer.bounds.size.height - 2)/2];
    self.oneLayer.path = onePath.CGPath;
}
-(UIBezierPath *)startPath{
    CGPoint point = CGPointMake(_layerWidth/2 + 5, CGRectGetMidY(self.bounds));
    CGPoint point1 = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 5);
    CGPoint point2 = CGPointMake(self.bounds.size.width - _layerWidth/2 - 5, CGRectGetMidY(self.bounds));
    CGPoint point3 = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - 5);
    _startPath = [UIBezierPath bezierPath];
    [_startPath moveToPoint:point2];
    [_startPath addLineToPoint:point3];
    [_startPath addLineToPoint:point];
    [_startPath addLineToPoint:point1];
    [_startPath addLineToPoint:point2];
    _startPath.lineJoinStyle =  kCGLineJoinRound;
    return _startPath;
}
-(UIBezierPath *)endPath{
    CGPoint point = CGPointMake(_layerWidth/2 + 5, CGRectGetMidY(self.bounds));
    CGPoint point1 = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 5);
    CGPoint point2 = CGPointMake(self.bounds.size.width - _layerWidth/2 - 5, CGRectGetMidY(self.bounds));
    CGPoint point3 = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - 5);
    _endPath = [UIBezierPath bezierPath];
    [_endPath moveToPoint:point];
    [_endPath addLineToPoint:point1];
    [_endPath addLineToPoint:point2];
    [_endPath addLineToPoint:point3];
    [_endPath addLineToPoint:point];
    _endPath.lineJoinStyle =  kCGLineJoinRound;
    return _endPath;
}

-(CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.lineWidth = 1;
        _oneLayer.fillColor = UIColor.redColor.CGColor;
    }return _oneLayer;
}
-(CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.lineWidth = 1;
        _twoLayer.fillColor = [UIColor greenColor].CGColor;
    }return _twoLayer;
}



@end
