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
    self.sectionInset = UIEdgeInsetsMake(10, 60, 10,60);
    self.minimumLineSpacing = self.sectionInset.left + self.sectionInset.right;
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right, CGRectGetHeight(self.collectionView.frame) - self.sectionInset.top - self.sectionInset.bottom);
    
//    self.itemSize = CGSizeMake(100 , 500);
//    self.collectionView.pagingEnabled = YES;
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray <UICollectionViewLayoutAttributes *> * allAttr = [super layoutAttributesForElementsInRect:rect];
//    return allAttr;
    
    CGFloat centerX = self.collectionView.center.x;
    CGFloat collectionOffsetX = self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes * item in allAttr) {
        
        //中点对应，看相差几个单位  (偏移量 + 中点坐标) - (项偏移 + 项的中心点x)
       CGFloat itemOffsetCenter = fabs((collectionOffsetX + centerX) - (item.frame.origin.x +  CGRectGetWidth(item.frame)/2));
  
        
        CGFloat scale = 1 - itemOffsetCenter/CGRectGetWidth(self.collectionView.frame)*0.5;
        item.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return allAttr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
