//
//  HXAutoFitLabVC.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/23.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "HXAutoFitLabVC.h"
#import "HXAutoSizeFlow.h"
#import "HXAutoFitCell.h"

@interface HXAutoFitLabVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UICollectionView * collectioView;
@property (nonatomic, strong) HXAutoSizeFlow * flowLayout;

@end

@implementation HXAutoFitLabVC

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据源
    self.dataArr = @[@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把第把第把第把第把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as"];
    
    
        
    [self.view addSubview:self.collectioView];
    [_collectioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-kSafeArea_Height);
        make.top.offset(kNavBar_Height);
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
    
    HXAutoFitCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXAutoFitCell" forIndexPath:indexPath];
    
    UIColor * color =  [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor grayColor];//color;
    cell.lab.text = self.dataArr[indexPath.row];
   
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
#pragma mark- Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString * indexValue = self.dataArr[indexPath.row];
    NSLog(@"点击了第几个 section %ld, row %ld",indexPath.section,indexPath.row);
    [self.collectioView scrollToItemAtIndexPath:indexPath
    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
    animated:YES];
}

#pragma mark 长按 移动操作
//- long


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
        
        [_collectioView registerClass:[HXAutoFitCell class] forCellWithReuseIdentifier:@"HXAutoFitCell"];
       
        
        _collectioView.dataSource = self;
        _collectioView.delegate = self;
        
        _collectioView.backgroundColor = [UIColor whiteColor];
        

        if (@available(iOS 11.0, *)) {
            _collectioView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
//        if (@available(iOS 11.0, *)) {
//            _collectioView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//        }else {
//            self.automaticallyAdjustsScrollViewInsets = YES;
//        }
    }
    return _collectioView;
}

- (HXAutoSizeFlow *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[HXAutoSizeFlow alloc] init];
        
    }
    return _flowLayout;;
}
@end
