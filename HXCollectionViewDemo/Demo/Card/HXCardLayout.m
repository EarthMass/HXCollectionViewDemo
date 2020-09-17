//
//  HXCardLayout.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/17.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXCardLayout.h"

@implementation HXCardLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(kScreenWidth- 60, kScreenHeight/2);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray <UICollectionViewLayoutAttributes *> * allAttr = [super layoutAttributesForElementsInRect:rect];
    
    NSInteger numOfRow = [self.collectionView numberOfItemsInSection:0];
    for (UICollectionViewLayoutAttributes * item in allAttr) {
        if (item.representedElementCategory == UICollectionElementCategoryCell) {
            
            //卡片效果
            CGFloat totalSpaceOffset = 10.0; //卡片偏移
            
            CGFloat itemCenterX = self.collectionView.center.x + totalSpaceOffset/numOfRow*item.indexPath.row - totalSpaceOffset;
            CGFloat itemCenterY = self.collectionView.center.y + totalSpaceOffset/numOfRow*item.indexPath.row - totalSpaceOffset;
            item.center = CGPointMake(itemCenterX, itemCenterY);
        }
    }
    return allAttr;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame));
}

@end
