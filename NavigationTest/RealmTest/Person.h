//
//  Person.h
//  NavigationTest
//
//  Created by 王欣 on 2018/3/2.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface Person : RLMObject
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) NSInteger  age;


@end
