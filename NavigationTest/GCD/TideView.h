//
//  TideView.h
//  NavigationTest
//
//  Created by 王欣 on 2018/3/15.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TideView : UIView
@property (nonatomic, copy) NSString *tileTag;
@property (nonatomic, copy) NSString *tileDirectory;
@property (nonatomic,assign)CGFloat  titleWidth;
- (UIImage*)tileAtCol:(int)col row:(int)row;

@end
