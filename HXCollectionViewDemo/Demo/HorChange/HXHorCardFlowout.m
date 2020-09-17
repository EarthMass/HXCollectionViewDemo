//
//  HXHorCardFlowout.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/13.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXHorCardFlowout.h"

@interface HXHorCardFlowout ()

@property (nonatomic, strong) NSMutableArray * itemsArr;

@end

@implementation HXHorCardFlowout

- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.sectionInset = UIEdgeInsetsMake(10, 60, 10,60);
//    self.minimumLineSpacing = self.sectionInset.left + self.sectionInset.right;
//    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right, CGRectGetHeight(self.collectionView.frame) - self.sectionInset.top - self.sectionInset.bottom);
    
    //最边缘的到中间的最小偏移 作为left & right，否者边缘的无法居中显示，自行调整
    self.itemSize = CGSizeMake(100 , 500);
    CGFloat offsetEdge = CGRectGetWidth(self.collectionView.frame)/2 - self.itemSize.width/2;
    self.sectionInset = UIEdgeInsetsMake(10, offsetEdge, 10,offsetEdge);
    self.minimumLineSpacing = 10;
    
//    self.collectionView.pagingEnabled = YES;
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray <UICollectionViewLayoutAttributes *> * allAttr = [super layoutAttributesForElementsInRect:rect];
//    return allAttr;
    
   
    for (UICollectionViewLayoutAttributes * item in allAttr) {
        
//        CGFloat centerX = self.collectionView.center.x;
//           CGFloat collectionOffsetX = self.collectionView.contentOffset.x;
//        //中点对应，看相差几个单位  (偏移量 + 中点坐标) - (项偏移 + 项的中心点x)
//       CGFloat itemOffsetCenter = fabs((collectionOffsetX + centerX) - (item.frame.origin.x +  CGRectGetWidth(item.frame)/2));
//
//
//        CGFloat scale = 1 - itemOffsetCenter/CGRectGetWidth(self.collectionView.frame)*0.5;
//        item.transform = CGAffineTransformMakeScale(scale, scale);
        
        //获取卡片所在index 余弦
        //获取ScrollView滚动的位置
        CGFloat scrollOffset = self.collectionView.contentOffset.x;
        //获取卡片中间位置滚动的相对位置
        CGFloat cardCenterX = item.center.x - scrollOffset;
        //获取卡片中间位置和父视图中间位置的间距，目标是间距越大卡片越短
        CGFloat apartLength = fabs(self.collectionView.frame.size.width/2.0f - cardCenterX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = apartLength/self.collectionView.frame.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置卡片的缩放
        item.transform = CGAffineTransformMakeScale(1.0, scale);

    }

    return allAttr;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
