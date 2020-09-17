//
//  HXCycleCollectionViewVC.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/12.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXCycleCollectionViewVC.h"
#import "HXCycleLayout.h"


@interface HXCycleCollectionViewVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UICollectionView * collectioView;
@property (nonatomic, strong) HXCycleLayout * flowLayout;

@end

@implementation HXCycleCollectionViewVC

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
    for (int j = 0; j < 10; j ++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%d",j+ 1]];
    }
    
    
        
    [self.view addSubview:self.collectioView];
    [_collectioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView * centerView = [UIView new];
    centerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(10);
        make.center.equalTo(self.collectioView);
    }];
    
   
}

#pragma mark- DataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XXXX" forIndexPath:indexPath];
    
    UIColor * color =  [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    cell.backgroundColor = color;
    
    cell.layer.cornerRadius = self.flowLayout.itemSize.width/2;
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.clipsToBounds = YES;
    
    UIView * tmpView = [UIView new];
    tmpView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:tmpView];
    [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
        make.height.equalTo(cell.contentView);
        make.width.mas_equalTo(10);
    }];
    
    
//    NSString * showValue = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.section,indexPath.row];
//    [cell setTitleStr:showValue];
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
#pragma mark- Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString * indexValue = self.dataArr[indexPath.row];
    NSLog(@"点击了第几个 section %ld, row %ld",indexPath.section,indexPath.row);
    
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
        
        [_collectioView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"XXXX"];
       
        
        _collectioView.dataSource = self;
        _collectioView.delegate = self;
        
        _collectioView.backgroundColor = [UIColor grayColor];
        
        //这个是重点，否者显示有问题
        if (@available(iOS 11.0, *)) {
            _collectioView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectioView;
}

- (HXCycleLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[HXCycleLayout alloc] init];
        
    }
    return _flowLayout;;
}
@end
