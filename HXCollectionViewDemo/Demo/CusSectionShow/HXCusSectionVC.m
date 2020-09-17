//
//  HXCusSectionVC.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/11.
//  Copyright © 2020 BroSis. All rights reserved.
//



#import "HXCusSectionVC.h"
#import "CusSectionLayout.h"

#define NormalCusCell @"CusCell"
#define NormalResableView @"NormalResableView"

@interface HXCusSectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UICollectionView * collectioView;
@property (nonatomic, strong) CusSectionLayout * flowLayout;

@end

@implementation HXCusSectionVC

#pragma mark- cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- initUI
- (void)createUI {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //数据源
    for (int j = 0; j < 3; j ++) {
        NSMutableArray * itemArr = [NSMutableArray array];
        for (int i = 0; i < 10; i ++) {
            [itemArr addObject:[NSString stringWithFormat:@"%d",i+ 1]];
        }
        [self.dataArr addObject:itemArr];
    }
    
    
        
    [self.view addSubview:self.collectioView];
    [_collectioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(20);
        make.right.offset(-20);
    }];
    
   
}

#pragma mark- DataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NormalCusCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    
//    NSString * showValue = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.section,indexPath.row];
//    [cell setTitleStr:showValue];
    return cell;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((NSArray *)self.dataArr[section]).count;
}
#pragma mark- Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString * indexValue = self.dataArr[indexPath.row];
    NSLog(@"点击了第几个 section %ld, row %ld",indexPath.section,indexPath.row);
    
}

//头部
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(0, 40);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 20);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //头部
        UICollectionReusableView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NormalResableView forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        
        //顶部圆角
        [self.view layoutIfNeeded];
        UIView * cornerRadioView = reusableView;
        //背景特定圆角
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:cornerRadioView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = cornerRadioView.bounds;
        maskLayer.path = maskPath.CGPath;
        cornerRadioView.layer.mask = maskLayer;
        //避免重复
        
        //否者会重复
//        [reusableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        //或者
        UILabel * titleLab = [reusableView viewWithTag:1000];
        if (!titleLab) {
            UILabel * label = [UILabel new];
            label.tag = 1000;
            
            [reusableView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
            titleLab = label;
        }
        titleLab.text = [NSString stringWithFormat:@"   section %ld",indexPath.section];
        
        
        
        return reusableView;;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        //尾部
        UICollectionReusableView * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NormalResableView forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor grayColor];

         [reusableView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

//        UILabel * label = [UILabel new];
//        label.text = [NSString stringWithFormat:@"section %ld",indexPath.section];
//        [reusableView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsZero);
//        }];
        reusableView.backgroundColor = [UIColor clearColor];
        
        return reusableView;

    }
    
    return nil;
}

#pragma mark- Event

#pragma mark- Setting Getting
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UICollectionView *)collectioView {
    if (!_collectioView) {
        _collectioView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        
        [_collectioView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NormalCusCell];
        [_collectioView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NormalResableView];
         [_collectioView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NormalResableView];
        
        _collectioView.dataSource = self;
        _collectioView.delegate = self;
        
        _collectioView.backgroundColor = [UIColor grayColor];
        _collectioView.clipsToBounds = NO;
    }
    return _collectioView;
}

- (CusSectionLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[CusSectionLayout alloc] init];
        
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        
        //每行个数
        int numOfRow = 4;
        CGFloat itemWidth = (screenSize.width - _flowLayout.sectionInset.left - _flowLayout.sectionInset.right - (numOfRow - 1)*_flowLayout.minimumLineSpacing - 40)/numOfRow;
        _flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        _flowLayout.sectionBgContainFooter = NO;
        
    }
    return _flowLayout;;
}
@end
