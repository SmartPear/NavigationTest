//
//  AttachView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/7/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachView : UIButton

//移动结束后是否自动降低透明度/ 默认YES
@property (nonatomic,assign) BOOL completeHidden;

@property (nonatomic,assign) CGFloat Spacing;

@end
