//
//  HXNormalCollectionCell.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/10.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXNormalCollectionCell.h"

@interface HXNormalCollectionCell()

@property (nonatomic, strong) UILabel * titleLab;

@end

@implementation HXNormalCollectionCell

//必须实现的
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UILabel * lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:20];
    [self.contentView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    lab.layer.cornerRadius = 5;
    lab.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    lab.layer.borderWidth = 0.5;
    lab.clipsToBounds = YES;
    
    self.titleLab = lab;
}

- (void)setTitleStr:(NSString *)title {
    self.titleLab.text = title;
}

@end
