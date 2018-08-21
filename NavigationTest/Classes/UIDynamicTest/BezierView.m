//
//  BezierView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "BezierView.h"
@interface BezierView()
{
    CGFloat halfSquare;
    CGFloat arrowLineH;
    CGFloat arrowTH;
    CGFloat arrowTW;
    CGFloat linePoinY;
    CGFloat arrowPointX;
    CGFloat arrowPointY;
    CGFloat lineW;
    CGFloat midPointX;
    CGFloat pointSpacing;
    CGFloat verticalLineEndPointX;
    CGFloat verticalLinePointX;
    CGFloat waveHeight;
}
@property(nonatomic,strong)UIBezierPath * boxPath;
@property (nonatomic, strong) UIBezierPath *arrowMidtPath;

@end
@implementation BezierView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        
    }return self;
}

//绘制
-(void)drawRect:(CGRect)rect{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [[UIColor redColor]setStroke];
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height /2);
    CGPoint top = CGPointMake(rect.size.width / 2, center.y - 10);
    CGPoint bottom = CGPointMake(rect.size.width / 2, center.y + 10);
    [path  moveToPoint:top];
    [path addLineToPoint:bottom];
    path.lineWidth = 2;
    [path stroke];
    
}
//
-(void)drawSubView{
    
}
//箭头开始
//- (UIBezierPath *)arrowMidtPath{

//    _arrowMidtPath = [UIBezierPath bezierPath];
//    [_arrowMidtPath moveToPoint:CGPointMake(midPointX, halfSquare)];
//    [_arrowMidtPath addLineToPoint:CGPointMake(midPointX+lineW/2,halfSquare-kSpacing*2)];
//    [_arrowMidtPath addLineToPoint:CGPointMake(midPointX+lineW, halfSquare)];
//    return _arrowMidtPath;
//}


@end
