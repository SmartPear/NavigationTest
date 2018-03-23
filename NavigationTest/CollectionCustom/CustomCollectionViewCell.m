//
//  CustomCollectionViewCell.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/28.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CustomCollectionViewCell.h"
@interface CustomCollectionViewCell()
@property (nonatomic,strong) UIImageView * imgView;

@end
@implementation CustomCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }return self;
}
-(void)setupSubviews{
    [self addSubview:self.imgView];
    self.imgView.frame = self.bounds;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"屏幕快照 2018-02-28 下午5.24.56"];
    }return _imgView;
}
@end
