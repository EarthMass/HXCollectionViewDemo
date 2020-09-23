//
//  HXAutoSizeFlow.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/23.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXAutoSizeFlow.h"

@implementation HXAutoSizeFlow

- (void)prepareLayout {
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    
    self.estimatedItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
   NSArray <UICollectionViewLayoutAttributes *> * arr = [super layoutAttributesForElementsInRect:rect];
    
    //左对齐
    for (int i = 0; i < arr.count; i ++) {
        if (i != arr.count - 1) {
            UICollectionViewLayoutAttributes * currItem = arr[i];
            UICollectionViewLayoutAttributes * nextItem = arr[i + 1];
            
            //如果下一个在同一行则调整，不在同一行则跳过
            if (CGRectGetMinY(currItem.frame) == CGRectGetMinY(nextItem.frame)) {
                if (CGRectGetMinX(nextItem.frame) - CGRectGetMaxX(currItem.frame) > self.minimumInteritemSpacing){
                    CGRect frame = nextItem.frame;
                    CGFloat x = CGRectGetMaxX(currItem.frame) + self.minimumInteritemSpacing;
                    frame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
                    nextItem.frame = frame;
                }
            }
        }
        
    }
 
    
    return arr;
}



@end
