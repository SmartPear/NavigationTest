//
//  CiFilterViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CiFilterViewController.h"
#import "ImageUtil.h"
#import "CiFilterView.h"
#import "CiFilterModel.h"
@interface CiFilterViewController ()<CiFilterTableViewCellDelegate>

@property (nonatomic,strong)UIImageView * img;
@property (nonatomic,strong)UIImage * image;
@property (nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)CiFilterView * filterView;
@end

@implementation CiFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.img];
    self.img.image = self.image;
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(self.img.mas_width).multipliedBy(620.0/828.0);
    }];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-64);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
}
-(void)ciFiltersliderValueChanged:(NSArray*)arr{
    @synchronized(self){
        @autoreleasepool{
            float v1[30] ={1,2,3,4};
            for (int i = 0; i< arr.count; i++) {
                CiFilterModel * model = arr[i];
                v1[i] = model.currentValue;
            }
            
            UIImage * image = [ImageUtil imageWithImage:self.image withColorMatrix:v1];
            self.img.image = image;
        }
    }
}

-(void)setAction:(UIButton*)btn{
    self.filterView.delegate = self;
    [self.filterView animationShowOnView:self.navigationController.view];

}

-(CiFilterView *)filterView{
    if (!_filterView) {
        _filterView = [[CiFilterView alloc]init];
    }return _filterView;
}

-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.contentMode = UIViewContentModeScaleAspectFit;
        _img.userInteractionEnabled = YES;
    }return _img;
}
-(UIImage *)image{
    if (!_image) {
        _image = [UIImage imageNamed:@"IMG_0332"];
    }return _image;
}
-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btn setTitle:@"设置" forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(setAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _btn.layer.cornerRadius = 6;
        _btn.layer.masksToBounds = YES;
    }return _btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
