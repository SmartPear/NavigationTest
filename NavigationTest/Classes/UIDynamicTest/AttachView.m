//
//  AttachView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "AttachView.h"
@interface AttachView ()
@property (nonatomic,strong)UIPanGestureRecognizer * pan;

@end
@implementation AttachView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.completeHidden = YES;
        [self addGestureRecognizer:self.pan];
        self.Spacing  = 10.0;
        self.alpha = 0.5;
    }return self;
}

-(void)panges:(UIPanGestureRecognizer*)sender{
    
    CGPoint  point = [sender locationInView:self.superview];
    self.alpha = 1.0;
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.center = point;
        
    }else if (sender.state == UIGestureRecognizerStateChanged){
        self.center = point;
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        self.center = point;
        [self moveEndWithPoint:point];
        
    }
}
-(void)setSpacing:(CGFloat)Spacing{
    if (Spacing<0) {
        Spacing = 0;
    }
    _Spacing = Spacing;
}

//移动结束后执行吸附
-(void)moveEndWithPoint:(CGPoint)point{
    CGRect frame = self.frame;
    UIView * superView = self.superview;
    CGPoint anchor;
  
    
    if (self.center.x > superView.center.x) {
        anchor = CGPointMake(self.superview.bounds.size.width - frame.size.width - self.Spacing, point.y);
    }else{
        anchor = CGPointMake(self.Spacing, point.y);
    }
    CGFloat y = anchor.y;
    if (y <= self.Spacing) {
        y = self.Spacing;
    }else if (y > (CGRectGetMaxY(self.superview.bounds) - frame.size.height) - self.Spacing ){
        y  = (CGRectGetMaxY(self.superview.bounds) - frame.size.height) - self.Spacing;
    }
    CGRect newFrame = CGRectMake(anchor.x, y, frame.size.width, frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = newFrame;
        if (self.completeHidden) {
            self.alpha = 0.5;
        }
    } completion:^(BOOL finished) {
        
    }];
    
}

-(UIPanGestureRecognizer *)pan{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]init];
        [_pan addTarget:self action:@selector(panges:)];
    }return _pan;
}
@end
