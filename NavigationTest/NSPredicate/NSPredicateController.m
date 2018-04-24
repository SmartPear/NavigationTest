//
//  NSPredicateController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/4/16.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "NSPredicateController.h"

@interface NSPredicateController ()

@end

@implementation NSPredicateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray * arrs = [[NSMutableArray alloc]init];
    for (int i = 0; i <100; i++) {
        Model * mode = [[Model alloc]init];
        mode.name = [NSString stringWithFormat:@"%d",i];
        mode.age = i;
        [arrs addObject:mode];
    }
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"age = 80"];
    [arrs filterUsingPredicate:pre];
    for (Model * m in arrs) {
        NSLog(@"%ld",m.age);
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation Model:NSObject


@end
