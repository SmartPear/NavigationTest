//
//  CornerTextViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CornerTextViewController.h"
#import "CornerTextView.h"
#import <Masonry/Masonry.h>
@interface CornerTextViewController ()
@property (nonatomic,strong) CornerTextView * subView;
@property (nonatomic,strong) UIImageView * backImage;

@end

@implementation CornerTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subView = [[CornerTextView alloc]init];
    self.subView.center = self.view.center;
    [self.view addSubview:self.backImage];
    self.subView.frame = self.backImage.bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.backImage addSubview:self.subView];
    //弧线
    [_subView drawArcWithStartAngle:-M_PI * 23/30 endAngle:-M_PI * 7/30];
    
    //刻度
    
    __weak typeof(self) weakSelf = self;
    
    [_subView drawScaleWithDivide:3 complete:^(NSArray *pointModels) {
        for (int i = 0; i<pointModels.count; i++) {
            CornerTextModel * model =pointModels[i];
            CGPoint  point = model.centerPoint;
            UILabel * label = [[UILabel alloc]init];
            label.backgroundColor = [UIColor redColor];
            if (i ==0 || i == pointModels.count - 1) {
                label.frame  = CGRectMake(0, 0, 10, 40);
            }else{
                label.frame  = CGRectMake(0, 0, 20, 50);
            }
        
            label.center = point;
            [weakSelf.subView addSubview:label];
            label.font = [UIFont systemFontOfSize:14];
            label.text = @"哈哈";
            label.textColor = [UIColor blackColor];
            label.transform = CGAffineTransformMakeRotation(M_PI_2 - model.radian );
        }
    } ];
   
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:1541125816];
    
    NSLog(@"时间戳转化时间 >>> %@",[stampFormatter stringFromDate:stampDate2]);
    


    self.navigationItem.title = @"扇形显示图片";
    
    // Do any additional setup after loading the view.
}

-(UIImageView *)backImage{
    if (!_backImage) {
        
        UIImage * image = [UIImage imageNamed:@"shanmian2"];
        CGSize size = image.size;
        CGFloat height = size.height/( size.width/self.view.bounds.size.width);
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width , height)];

        _backImage.image = [UIImage imageNamed:@"shanmian2"];
        _backImage.center = self.view.center;
    }return _backImage;
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
