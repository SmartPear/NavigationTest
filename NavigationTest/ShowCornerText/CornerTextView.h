//
//  CornerTextView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CornerTextView : UIView
/**
 *  圆盘开始角度
 */
@property(nonatomic,assign)CGFloat startAngle;
/**
 *  圆盘结束角度
 */
@property(nonatomic,assign)CGFloat endAngle;
/**
 *  圆盘总共弧度弧度
 */
@property(nonatomic,assign)CGFloat arcAngle;
/**
 *  线宽
 */
@property(nonatomic,assign)CGFloat lineWidth;
/**
 *  刻度值长度
 */
@property(nonatomic,assign)CGFloat scaleValueRadiusWidth;
/**
 *  速度表半径
 */
@property(nonatomic,assign)CGFloat arcRadius;
/**
 *  刻度半径
 */
@property(nonatomic,assign)CGFloat scaleRadius;
/**
 *  刻度值半径
 */
@property(nonatomic,assign)CGFloat scaleValueRadius;


@property (nonatomic, strong) CAShapeLayer *progressLayer;
/**
 *  画弧度
 *
 *  @param startAngle  开始角度
 *  @param endAngle    结束角度
 *  @param lineWitdth  线宽
 *  @param filleColor  扇形填充颜色
 *  @param strokeColor 弧线颜色
 */
-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWitdth fillColor:(UIColor*)filleColor strokeColor:(UIColor*)strokeColor;

-(void)drawScaleWithDivide:(int)divide andRemainder:(NSInteger)remainder strokeColor:(UIColor*)strokeColor filleColor:(UIColor*)fillColor scaleLineNormalWidth:(CGFloat)scaleLineNormalWidth scaleLineBigWidth:(CGFloat)scaleLineBigWidth;
@end
