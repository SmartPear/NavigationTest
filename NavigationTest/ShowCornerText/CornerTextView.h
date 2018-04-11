//
//  CornerTextView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CornerTextModel:NSObject
@property (nonatomic,assign) CGPoint  centerPoint;
@property (nonatomic,assign) CGFloat  radian;//弧度
@property (nonatomic,assign,getter=startPoint) BOOL  startPoint;
@property (nonatomic,assign,getter=endPoint)   BOOL  endPoint;

@end


typedef void(^CornerTextBlock)(NSArray <CornerTextModel*>*  pointModels);


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

@property (nonatomic,assign) CGPoint LuCenter;



-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

-(void)drawScaleWithDivide:(int)divide complete:(CornerTextBlock)block;

@end


