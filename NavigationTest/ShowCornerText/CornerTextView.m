//
//  CornerTextView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CornerTextView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//#define Calculate_radius   self.bounds.size.height + 10


@interface CornerTextView()


@end
@implementation CornerTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.startAngle = -M_PI*5/4;
        self.endAngle = M_PI/4;
        self.arcAngle = self.endAngle - self.startAngle;
        self.LuCenter = CGPointMake(self.center.x, 0);
        
    }return self;
}



-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    
    //保存弧线宽度,开始角度，结束角度
    self.startAngle=startAngle;
    self.endAngle=endAngle;
    self.arcAngle=endAngle-startAngle;
    
    CGFloat x = cos(DEGREES_TO_RADIANS(50.25));
    CGFloat y =   pow(x, 2);
    CGFloat z =   sqrt(1 - y) ;
    CGFloat w =   self.bounds.size.width/2/z;
    self.arcRadius=w;
    self.LuCenter = CGPointMake(self.center.x, w);
    UIBezierPath* outArc=[UIBezierPath bezierPathWithArcCenter:self.LuCenter radius:self.arcRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer* shapeLayer=[CAShapeLayer layer];
    shapeLayer.lineWidth= 2;
    shapeLayer.fillColor= [UIColor clearColor].CGColor;
    shapeLayer.strokeColor= [UIColor yellowColor].CGColor;
    shapeLayer.path=outArc.CGPath;
    shapeLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:shapeLayer];
    
    
    
    


    
}

-(void)drawScaleWithDivide:(int)divide complete:(CornerTextBlock)block{
    int newdivide = divide + 1;
    CGFloat perAngle = self.arcAngle/newdivide;
    CGFloat padding = perAngle/60;
    NSMutableArray * points    = [NSMutableArray array];
    
    for (NSInteger i = 0; i<= newdivide; i++) {
        CGFloat startAngel = (self.startAngle+ perAngle * i);
        CGFloat endAngel   = startAngel + padding;
        CGFloat nextStartAngel = startAngel + padding;
        CGFloat nextEndAngle = nextStartAngel + padding;
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.LuCenter radius:self.arcRadius startAngle:startAngel endAngle:endAngel clockwise:YES];
        UIBezierPath *nexttickPath = [UIBezierPath bezierPathWithArcCenter:self.LuCenter radius:self.arcRadius startAngle:nextStartAngel endAngle:nextEndAngle clockwise:YES];
        CGPoint point1 = tickPath.currentPoint;
        CGPoint point2 = nexttickPath.currentPoint;
        CGPoint point3 = CGPointMake(point2.x, point2.y - 1);
        CGFloat angele = [self getAnglesWithThreePoint:point1 pointB:point2 pointC:point3];
        CornerTextModel * model = [[CornerTextModel alloc]init];
        model.centerPoint = tickPath.currentPoint;
        model.radian = angele;
        if (i == 0) {
            model.startPoint  = YES;
            
        }else if (i == newdivide){
            model.endPoint = YES;
        }
        [points addObject:model];
        
    }
    block(points);
}

//计算三点之间的夹角
-(CGFloat)getAnglesWithThreePoint:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC {
    
    CGFloat x1 = pointA.x - pointB.x;
    CGFloat y1 = pointA.y - pointB.y;
    CGFloat x2 = pointC.x - pointB.x;
    CGFloat y2 = pointC.y - pointB.y;
    
    CGFloat x = x1 * x2 + y1 * y2;
    CGFloat y = x1 * y2 - x2 * y1;
    
    CGFloat angle = acos(x/sqrt(x*x+y*y));
    
    return angle;
}
@end

@implementation CornerTextModel


@end
