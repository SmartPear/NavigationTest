//
//  CoreFoundationViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/26.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CoreFoundationViewController.h"

@interface CoreFoundationViewController ()
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation CoreFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
    // Do any additional setup after loading the view.
}
//-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"%s",__FUNCTION__);
//}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%s",__FUNCTION__);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self loadImage];
}
-(void)loadImage{
    
    
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"屏幕快照 2018-02-26 上午10.24.31" ofType:@"png"]], NULL);
    CGImageRef ref = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    UIImage * image = [[UIImage alloc]initWithCGImage:ref];
    
    NSLog(@"%@",image);
    self.imgView.image = image;
    
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.frame = self.view.bounds;
    }return _imgView;
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
