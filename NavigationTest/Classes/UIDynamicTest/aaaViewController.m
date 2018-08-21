//
//  aaaViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/7/20.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "aaaViewController.h"
#import "CustomCollectionViewCell.h"
@interface aaaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CAAnimationDelegate>

@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,strong)UIView * currentCell;
@property (nonatomic,strong)NSIndexPath * deleteIndex;
@end

@implementation aaaViewController

- (void)viewDidLoad {
    self.count = 20;
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).inset(10);
    }];
    
    // Do any additional setup after loading the view from its nib.
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 100);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.tipLab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    cell.block = ^{
        self.editing = !self.editing;
        [self makeCellEdit:self.editing];
        
    };
    cell.deleteAction = ^(CustomCollectionViewCell *deletCell) {
        
        [self deleteActionIndexPath:deletCell];
    };

    [self shakeCell:cell isShake:self.editing];
    return  cell;
}

//cell删除按钮的事件
-(void)deleteActionIndexPath:(CustomCollectionViewCell *)cell{
    
    if (self.currentCell) {
        [self.currentCell.layer removeAllAnimations];
        [self.navigationController.view addSubview:self.currentCell];
    }
    cell.hidden = YES;
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    self.deleteIndex = indexPath;
    CGRect rect = [self.collectionView convertRect:cell.frame toView:self.view];
    CGRect navRect = [self.view convertRect:rect toView:self.navigationController.view];
    self.currentCell.frame = navRect;
    CGRect newRect = CGRectMake(navRect.origin.x, -navRect.size.height, navRect.size.width, navRect.size.height);
    self.currentCell.backgroundColor = UIColor.yellowColor;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = @(rect);
    animation.toValue   = @(newRect);
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    [self.currentCell.layer addAnimation:animation forKey:@"cee"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.count -= 1;
    [self.collectionView deleteItemsAtIndexPaths:@[self.deleteIndex]];
    [self.currentCell removeFromSuperview];
    NSLog(@"动画结束");
}
//让cell视图开始抖动
-(void)makeCellEdit:(BOOL)edit{
    NSArray * cells = [self.collectionView visibleCells];
    for (UICollectionViewCell * cell in cells) {
        [self shakeCell:cell isShake:edit];
    }
}

//cell视图是否抖动
-(void)shakeCell:(UICollectionViewCell*)cell isShake:(BOOL)shake{

    if (shake) {
        CAKeyframeAnimation * animation = [[CAKeyframeAnimation alloc]init];
        animation.keyPath = @"transform.rotation";
        animation.values = @[@((-2)/180.0*M_PI),@((2)/180.0*M_PI),@((-2)/180.0*M_PI)];
        animation.repeatCount = MAXFLOAT;
        animation.duration = 0.3;
        [cell.layer addAnimation:animation forKey:@"shake"];
    }else{
        [cell.layer removeAnimationForKey:@"shake"];
    }
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        UINib *celNib = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
        [_collectionView registerNib:celNib forCellWithReuseIdentifier:@"cell"];
        
        
    }return _collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)currentCell{
    if (!_currentCell) {
        _currentCell = [[UIView alloc]init];
        _currentCell.backgroundColor = [UIColor redColor];
        [self.navigationController.view addSubview:_currentCell];
    }return _currentCell;
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
