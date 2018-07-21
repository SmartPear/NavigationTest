//
//  TempleViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/6/11.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "TempleViewController.h"

@interface TempleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UIImageView * img;
@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation TempleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.img];
    [self.view addSubview:self.collectionView];

    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).offset(-40);
        make.size.mas_equalTo(CGSizeMake(70, 400));
    }];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return CGSizeMake(collectionView.bounds.size.width, (collectionView.bounds.size.height -  ( 3 + 2) * 20)/3);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect rect =  [self.collectionView convertRect:cell.frame toView:self.view];
    [self makeAnimationToRect:rect Fromview:cell];
}

-(void)makeAnimationToRect:(CGRect)rect Fromview:(UIView*)fromview{
    CGRect originRect = self.img.frame;
    
    [UIView animateWithDuration:.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.img.frame = rect;
    } completion:^(BOOL finished) {
        self.img.alpha = 0;
        fromview.alpha = 0;
        self.img.frame = originRect;
        [UIView animateWithDuration:0.3 animations:^{
            fromview.alpha = 1;
            self.img.alpha = 1;
        } completion:^(BOOL finished) {
 
        }];
    }];
    
    
    
    
}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.backgroundColor = [UIColor redColor];
    }return _img;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor yellowColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
