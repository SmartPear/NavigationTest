//
//  FlowLayout.m
//  NavigationTest
//
//  Created by 王欣 on 2018/2/28.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout
-(instancetype)init{
    if (self = [super init]) {
        [self initConfigation];
    }return self;
}
//初始化配置
-(void)initConfigation{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
}
-(void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width * 0.4, self.collectionView.frame.size.width * 0.4 * 1.4);
    [self.collectionView setContentOffset:CGPointMake(10, 0) animated:YES];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //获得当前屏幕上所有的Attrs
    NSArray <UICollectionViewLayoutAttributes*> *arrayAttrs = [super layoutAttributesForElementsInRect:rect];
    //计算可见范围内 collectionView 在屏幕中的 中心点位置.
    CGFloat centerX =  self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    //
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        
        //屏幕中 cell的中心点距离屏幕的中心点的距离 (可知道这个距离最小是0 最大是self.collectionView.frame.size.width/2)
        CGFloat distance = ABS(attr.center.x - centerX);
        
        //根据cell 距离中心点的这个动态 变化的距离制造一个缩放比例.
        CGFloat scale = 1 - distance /self.collectionView.frame.size.width /2;
        if (scale < 0.3) {
            scale = 0.3;
        }
        //当到达边界的时候 scale = 0 当时到达中心的时候 scale = 1;
        attr.transform = CGAffineTransformMakeScale(1, scale);
        
        
    }
    
    return arrayAttrs;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSLog(@"%@",NSStringFromCGPoint(proposedContentOffset));
    //获得super已经计算好的布局的属性
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    //计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDelta = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        //取出距离位置最近的
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
            
        }
    }
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}
@end
