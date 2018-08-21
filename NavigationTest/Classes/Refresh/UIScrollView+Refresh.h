//
//  UIScrollView+Refresh.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeaderView.h"
#import "RefreshFooterView.h"
@interface UIScrollView (Refresh)

@property (nonatomic,strong)RefreshHeaderView * fz_header;
@property (nonatomic,strong)RefreshFooterView* fz_footer;

@end
