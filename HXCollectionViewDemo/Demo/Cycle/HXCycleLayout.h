//
//  HXCycleLayout.h
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/12.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 圆形布局
@interface HXCycleLayout : UICollectionViewLayout

@property (nonatomic, assign) BOOL canRotate; //是否可以旋转
@property (nonatomic, assign) CGSize  itemSize; //显示的item大小

@end

NS_ASSUME_NONNULL_END
