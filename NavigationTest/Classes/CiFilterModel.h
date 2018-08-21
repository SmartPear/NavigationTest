//
//  CiFilterModel.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CiFilterModel : NSObject
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) CGFloat  currentValue;
@property (nonatomic,assign) CGFloat  maxValue;
@property (nonatomic,assign) CGFloat  minValue;

@end
