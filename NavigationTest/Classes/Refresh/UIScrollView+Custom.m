//
//  UIScrollView+Custom.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/17.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIScrollView+Custom.h"

@implementation UIScrollView (Custom)

static BOOL respondsToAdjustedContentInset_;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self respondsToSelector:@selector(adjustedContentInset)];
    });
}
-(void)setRe_insetT:(CGFloat)re_insetT{
    UIEdgeInsets inset = self.contentInset;
    inset.top = re_insetT;
    if (@available(iOS 11,*)){
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);//减去安全区域的距离
    }
    self.contentInset = inset;
}
-(void)setRe_insetB:(CGFloat)re_insetB{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = re_insetB;
    if (@available(iOS 11,*)){
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);//减去安全区域的距离
    }
    self.contentInset = inset;
}
-(CGFloat)re_insetT{
    
    return self.re_inset.top;
}
-(CGFloat)re_insetB{
    return self.re_inset.bottom;
}

-(UIEdgeInsets)re_inset{
    if (@available(iOS 11,*)) {
        return self.adjustedContentInset;
    }
    return self.contentInset;
}
-(void)setRe_insetL:(CGFloat)re_insetL{
    UIEdgeInsets inset = self.contentInset;
    inset.left = re_insetL;
    if (@available(iOS 11,*)){
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);//减去安全区域的距离
    }
    self.contentInset = inset;
}

- (CGFloat)re_insetL
{
    return self.re_inset.left;
}




-(BOOL)respondsToAdjustedContentInset{
    
    return [self respondsToSelector:@selector(adjustedContentInset)];
}
@end
