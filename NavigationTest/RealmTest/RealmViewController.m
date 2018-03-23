//
//  RealmViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/2.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "RealmViewController.h"
#import "Person.h"
@interface RealmViewController ()

@end

@implementation RealmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Get the URL to the bundled file
    NSString * cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString * realmPath = [cachesDir stringByAppendingPathComponent:@"devzeng.realm"];
    config.fileURL = [NSURL fileURLWithPath:realmPath];
    // Open the file in read-only mode as application bundles are not writeable
    config.readOnly = YES;
    // Open the Realm with the configuration
    NSLog(@"%@",config.fileURL);
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    Person * p  = [[Person alloc]init];
    p.name = @"哈哈哈";
    p.age = 13;

    [realm transactionWithBlock:^{
        [realm addObject:p];
    }];


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
