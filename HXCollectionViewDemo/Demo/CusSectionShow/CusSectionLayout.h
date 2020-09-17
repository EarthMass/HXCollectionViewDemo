//
//  CusSectionLayout.h
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/11.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CusSectionLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) BOOL sectionBgContainHeader; //包含头部,默认YES
@property (nonatomic, assign) BOOL sectionBgContainFooter; //包含尾部,默认YES

@end

NS_ASSUME_NONNULL_END
