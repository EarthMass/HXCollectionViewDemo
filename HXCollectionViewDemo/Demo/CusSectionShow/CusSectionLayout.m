//
//  CusSectionLayout.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/11.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "CusSectionLayout.h"
#import "HXCusSecReusableView.h"

@interface CusSectionLayout ()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> * decorationViewAttrs; //装饰视图【Section背景视图】

@end

//原理 给 section添加一个元素作为背景
@implementation CusSectionLayout

//背景视图的类名
- (NSString *)decorationViewName {
    return NSStringFromClass(HXCusSecReusableView.class);
}

- (id)init {
    if (self = [super init]) {
        //code ...
        self.sectionBgContainHeader = YES;
           self.sectionBgContainFooter = YES;
    }
    return self;
}

- (void)prepareLayout {
    //初始化，外部已经设置了，这边我就不设置了，正常来说扩展写属性来写

   
    //初始化装饰视图
    [self registerClass:[HXCusSecReusableView class] forDecorationViewOfKind:[self decorationViewName]];
}

//添加背景元素
- (void)addDecorationView {
    //找到sec 第一个最后一个cell 算出当前背景的大小位置
    NSInteger sectionNum = [self.collectionView numberOfSections];
    for (NSInteger currSec = 0; currSec < sectionNum; currSec ++) {
        NSInteger numOfRowInSection = [self.collectionView numberOfItemsInSection:currSec];
        if (numOfRowInSection > 0) {
            
            UICollectionViewLayoutAttributes * firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currSec]];
            UICollectionViewLayoutAttributes * lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numOfRowInSection - 1) inSection:currSec]];
            
            
            UICollectionViewLayoutAttributes * headerItem = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:currSec]];
            
            UICollectionViewLayoutAttributes * footerItem = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:currSec]];
            
            UICollectionViewLayoutAttributes * bgItem = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[self decorationViewName] withIndexPath:[NSIndexPath indexPathForRow:0 inSection:currSec]];
            
            CGFloat headerOffset  = self.sectionBgContainHeader? CGRectGetHeight(headerItem.frame):0;
            CGFloat footerOffset  = self.sectionBgContainFooter? CGRectGetHeight(footerItem.frame):0;
            
            bgItem.frame = CGRectMake(0,
                                      firstItem.frame.origin.y - self.sectionInset.top - headerOffset,
                                      self.collectionViewContentSize.width,
                                      (CGRectGetMaxY(lastItem.frame) - CGRectGetMinY(firstItem.frame)) + self.sectionInset.bottom + self.sectionInset.top + headerOffset + footerOffset);
            
            bgItem.zIndex = firstItem.zIndex -1;
            [self.decorationViewAttrs addObject:bgItem];
        }
        
        
    }

}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    //显示的项
    NSMutableArray <UICollectionViewLayoutAttributes *> * attrs = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    //添加section背景
    [self addDecorationView];
    [attrs addObjectsFromArray:self.decorationViewAttrs];
    return attrs;

}


- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = [NSMutableArray array];
    }
    return _decorationViewAttrs;
}

@end
