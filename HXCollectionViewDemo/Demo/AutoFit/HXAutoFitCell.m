//
//  HXAutoFitCell.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/23.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXAutoFitCell.h"

@interface HXAutoFitCell ()



@end

@implementation HXAutoFitCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.lab];
        
        //约束动画无法执行
        [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.left.offset(10);
            make.right.offset(-10);
            make.width.lessThanOrEqualTo(@(kScreenWidth- 40));
            make.height.greaterThanOrEqualTo(@30);
            make.height.lessThanOrEqualTo(@100);
        }];
    
//        self.lab.frame = CGRectMake(0, 0, 100, 30);
        self.layer.cornerRadius = 7;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UILabel *)lab
{
    if(!_lab)
    {
        _lab=[[UILabel alloc]init];
        _lab.textColor = [UIColor whiteColor];
        _lab.font = [UIFont systemFontOfSize:14];
        _lab.numberOfLines = 1;
        _lab.textAlignment = NSTextAlignmentCenter;
        
       
    }
    return _lab;
}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height = size.height;
//    cellFrame.size.width = size.width;
//    layoutAttributes.frame = cellFrame;
//    return layoutAttributes;
//}

@end
