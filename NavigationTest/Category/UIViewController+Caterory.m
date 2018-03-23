//
//  UIViewController+Caterory.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/7.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "UIViewController+Caterory.h"
#import <objc/runtime.h>


@implementation UIViewController (Caterory)

static void swizzInstance(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+(void)load{
    
    NSLog(@"----%s",__func__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzviewWillAppear:);
        swizzInstance(class, originalSelector, swizzledSelector);
    });
}


- (void)swizzviewWillAppear:(BOOL)animated {
    [self swizzviewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end

