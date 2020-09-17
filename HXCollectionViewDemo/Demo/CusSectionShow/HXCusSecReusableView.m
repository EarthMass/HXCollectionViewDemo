//
//  HXCusSecReusableView.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/11.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXCusSecReusableView.h"

@implementation HXCusSecReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    
    
    self.backgroundColor = [UIColor brownColor];
    //圆角
    self.layer.cornerRadius = 6;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.clipsToBounds = NO;
    
    //阴影
    self.layer.shadowColor = [UIColor redColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 3;

}


@end
