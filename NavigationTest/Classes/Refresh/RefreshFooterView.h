//
//  RefreshFooterView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/18.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RefreshComponent.h"

@interface RefreshFooterView : RefreshComponent

+(RefreshFooterView*)FooterWithRefreshingBlock:(RefreshBlock)refreshingBlock;

@end
