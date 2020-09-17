//
//  HXCycleLayout.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/12.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXCycleLayout.h"

@interface HXCycleLayout ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray * itemsArr;


/** 上一次滑动到的点 */
@property (assign, nonatomic) CGPoint lastPoint;

/** collectionView中心点 ，也是菜单的中心点 */
@property (assign, nonatomic) CGPoint centerPoint;

/** 相对于初始状态滑动过的角度总和 */
@property (assign, nonatomic) CGFloat totalRads;

/** 圆环上按钮直径 */
@property (assign, nonatomic) CGFloat itemRadius;

/** 圆环外径 */
@property (assign, nonatomic) CGFloat larRadius;


/** 按钮中心相对菜单中心旋转角度*/
@property (assign, nonatomic) CGFloat rotationAngle;

@end

@implementation HXCycleLayout

- (id)init {
    if (self = [super init]) {
        self.canRotate = YES;
        self.itemSize = CGSizeMake(80, 80);
        self.itemRadius = 80;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(menuBeingPaned:)];
       pan.delegate = self;
    [self.collectionView addGestureRecognizer:pan];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //半径
    self.larRadius = MIN(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame))/2 - self.itemSize.width/2;
    //圆心
    self.centerPoint = CGPointMake(self.collectionView.frame.size.width / 2, self.collectionView.frame.size.height / 2);
//    CGPoint centerPoint = self.collectionView.center;

    NSInteger numOfItems = [self.collectionView numberOfItemsInSection:0];


    for (int i =0; i < numOfItems; i ++) {
        UICollectionViewLayoutAttributes * item = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        item.size = self.itemSize;
        //iOS系统坐标系 Y 相反
//        CGFloat x = _centerPoint.x + sin(2*M_PI/numOfItems*i)*(_larRadius);
//        CGFloat y = _centerPoint.y - cos(2*M_PI/numOfItems*i)*(_larRadius);
        
         CGFloat x = _centerPoint.x + sin(2*M_PI/numOfItems*i + _totalRads)*(_larRadius);
         CGFloat y = _centerPoint.y - cos(2*M_PI/numOfItems*i + _totalRads)*(_larRadius);

        item.center = CGPointMake(x, y);

        [self.itemsArr addObject:item];
    }
    return self.itemsArr;
}


// 设置contentSize每次滚动都会调用
-(CGSize)collectionViewContentSize{
    return self.collectionView.frame.size;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark- Other

#pragma mark- 手势
#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 初始滑动时记录点为当前点
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
        _lastPoint = point;
    }
    return YES;
}

#pragma mark -- 菜单滑动，重新布局
- (void)menuBeingPaned:(UIPanGestureRecognizer *)panGR {
    if (!self.canRotate) return;
    
    CGPoint point = [panGR locationInView:panGR.view];
    CGFloat rLength = sqrt(pow((point.x - _centerPoint.x), 2.0)  +  pow((point.y - _centerPoint.y), 2.0));
    
    // 手势范围
    if (rLength <= _larRadius && rLength >= _larRadius - _itemRadius) {
        [self touchMoving:point];
    }
    // 由范围外进入范围内时将当前点赋值于记录点
    else if (_lastPoint.x == -100 && _lastPoint.y == -100) {
        _lastPoint = point;
    }
    // 由范围内进入范围外时清除记录点
    else {
        _lastPoint = CGPointMake(-100, -100);
    }
}

// 正在滑动中
- (void)touchMoving:(CGPoint )point{
    
    // 以collectionView center为中心计算滑动角度
    CGFloat rads = [self angleBetweenFirstLineStart:_centerPoint
                                       firstLineEnd:_lastPoint
                                 andSecondLineStart:_centerPoint
                                      secondLineEnd:point];
    
    if (_lastPoint.x != _centerPoint.x && point.x != _centerPoint.x) {

        CGFloat k1 = (_lastPoint.y - _centerPoint.y) / (_lastPoint.x - _centerPoint.x);
        CGFloat k2 = (point.y - _centerPoint.y) / (point.x - _centerPoint.x);
        if (k2 > k1) {
            _totalRads += rads;
        } else {
            _totalRads -= rads;
        }
    }
    
    self.rotationAngle = _totalRads;
    // 重新布局
    [self invalidateLayout];
    
    // 更新记录点
    _lastPoint = point;
}

// 两条直线之间的夹角
- (CGFloat)angleBetweenFirstLineStart:(CGPoint)firstLineStart
                         firstLineEnd:(CGPoint)firstLineEnd
                   andSecondLineStart:(CGPoint)secondLineStart
                        secondLineEnd:(CGPoint)secondLineEnd
{
    CGFloat a1 = firstLineEnd.x - firstLineStart.x;
    CGFloat b1 = firstLineEnd.y - firstLineStart.y;
    CGFloat a2 = secondLineEnd.x - secondLineStart.x;
    CGFloat b2 = secondLineEnd.y - secondLineStart.y;
    
    // 夹角余弦
    double cos = (a1 * a2 + b1 * b2) / (sqrt(pow(a1, 2.0) + pow(b1, 2.0)) * sqrt(pow(a2, 2.0) + pow(b2, 2.0)));
    // 浮点计算结果可能超过1，需要控制
    cos = cos > 1 ? 1 : cos;
    return acos(cos);
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

@end
