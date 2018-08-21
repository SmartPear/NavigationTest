//
//  UIScrollView+Refresh.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <objc/runtime.h>
@implementation UIScrollView (Refresh)

static const char FZRrefreshHeaderKey  = '\0';
static const char FZRrefreshFooterKey  = '\1';

-(void)setFz_header:(RefreshHeaderView *)fz_header{
    if (![fz_header isKindOfClass:[RefreshHeaderView class]]) {
        return;
    }
    if(fz_header != self.fz_header){
        [self.fz_header removeFromSuperview];
        [self insertSubview:fz_header atIndex:0];
        objc_setAssociatedObject(self, &FZRrefreshHeaderKey, fz_header, OBJC_ASSOCIATION_RETAIN);
    }
}

-(RefreshHeaderView *)fz_header{
    return objc_getAssociatedObject(self, &FZRrefreshHeaderKey);
}

-(void)setFz_footer:(RefreshFooterView *)fz_footer{
    if (![fz_footer isKindOfClass:[RefreshFooterView class]]) {
        return;
    }
    if(fz_footer != self.fz_footer){
        [self.fz_footer removeFromSuperview];
        [self insertSubview:fz_footer atIndex:0];
        objc_setAssociatedObject(self, &FZRrefreshFooterKey, fz_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

-(RefreshFooterView *)fz_footer{
    return objc_getAssociatedObject(self, &FZRrefreshFooterKey);
}
@end
