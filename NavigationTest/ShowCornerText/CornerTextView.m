//
//  CornerTextView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CornerTextView.h"
#define Calculate_radius ((self.bounds.size.height>self.bounds.size.width)?(self.bounds.size.width*0.5-self.lineWidth):(self.bounds.size.height*0.5-self.lineWidth))
#define LuCenter CGPointMake(self.center.x-self.frame.origin.x, self.center.y-self.frame.origin.y)
@interface CornerTextView()


@end
@implementation CornerTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.startAngle = -M_PI*5/4;
        self.endAngle = M_PI/4;
        self.arcAngle = self.endAngle - self.startAngle;
        
    }return self;
}

- (void)drawRect:(CGRect)rect {
    //刻度

    
}
/**
 *  画弧度
 *
 *  @param startAngle  开始角度
 *  @param endAngle    结束角度
 *  @param lineWitdth  线宽
 *  @param filleColor  扇形填充颜色
 *  @param strokeColor 弧线颜色
 */
-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWitdth fillColor:(UIColor*)filleColor strokeColor:(UIColor*)strokeColor{
    //保存弧线宽度,开始角度，结束角度
    self.lineWidth=lineWitdth;
    self.startAngle=startAngle;
    self.endAngle=endAngle;
    self.arcAngle=endAngle-startAngle;
    self.arcRadius=Calculate_radius;
    self.scaleRadius=self.arcRadius-self.lineWidth;
    self.scaleValueRadius=self.scaleRadius-self.lineWidth;    
    
    UIBezierPath* outArc=[UIBezierPath bezierPathWithArcCenter:LuCenter radius:self.arcRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer* shapeLayer=[CAShapeLayer layer];
    shapeLayer.lineWidth=lineWitdth;
    shapeLayer.fillColor=filleColor.CGColor;
    shapeLayer.strokeColor=strokeColor.CGColor;
    shapeLayer.path=outArc.CGPath;
    shapeLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:shapeLayer];
}

-(void)drawScaleWithDivide:(int)divide andRemainder:(NSInteger)remainder strokeColor:(UIColor*)strokeColor filleColor:(UIColor*)fillColor scaleLineNormalWidth:(CGFloat)scaleLineNormalWidth scaleLineBigWidth:(CGFloat)scaleLineBigWidth{
    
    CGFloat perAngle=self.arcAngle/divide;
    //我们需要计算出每段弧线的起始角度和结束角度
    //这里我们从- M_PI 开始，我们需要理解与明白的是我们画的弧线与内侧弧线是同一个圆心
    for (NSInteger i = 0; i<= divide; i++) {
        
        CGFloat startAngel = (self.startAngle+ perAngle * i);
        CGFloat endAngel   = startAngel + perAngle/5;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:LuCenter radius:self.scaleRadius startAngle:startAngel endAngle:endAngel clockwise:YES];
        
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if((remainder!=0)&&(i % remainder) == 0) {
            perLayer.strokeColor = strokeColor.CGColor;
            perLayer.lineWidth   = scaleLineBigWidth;
            
        }else{
            perLayer.strokeColor = strokeColor.CGColor;;
            perLayer.lineWidth   = scaleLineNormalWidth;
            
        }
        
        perLayer.path = tickPath.CGPath;
        [self.layer addSublayer:perLayer];
        
    }
}
@end
