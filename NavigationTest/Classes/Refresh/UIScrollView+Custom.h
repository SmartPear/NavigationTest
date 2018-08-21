//
//  UIScrollView+Custom.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/17.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Custom)
@property (readonly, nonatomic) UIEdgeInsets re_inset;
@property (assign, nonatomic) CGFloat re_insetT;
@property (assign, nonatomic) CGFloat re_insetB;
@property (assign, nonatomic) CGFloat re_insetL;
@end
