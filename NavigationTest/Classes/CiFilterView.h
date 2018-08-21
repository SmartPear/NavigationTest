//
//  CiFilterView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CiFilterTableViewCell.h"
@interface CiFilterView : UIView

@property (nonatomic,strong) void(^block)(NSArray * arr);
@property (nonatomic,weak)id<CiFilterTableViewCellDelegate>delegate;
-(void)animationShowOnView:(UIView*)view;

-(void)animationClose;

@end
