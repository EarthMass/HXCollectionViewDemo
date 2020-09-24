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

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;
@property (nonatomic, strong) UILongPressGestureRecognizer * longMovePress;

@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation HXAutoFitLabVC

#pragma mark- cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
    [self addCompleteBtn];
    
    //添加 长按抖动的手势
    [self addLongPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- initUI
- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据源
    self.dataArr = [NSMutableArray arrayWithArray:@[@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as"]];
    
    
    
    [self.view addSubview:self.collectioView];
    [_collectioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-kSafeArea_Height);
        make.top.offset(kNavBar_Height);
    }];
    
    
    
    
}

- (void)addCompleteBtn {
    UIButton * searBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 35, 35)];
    [searBtn setTitle:@"完成" forState:UIControlStateNormal];
    [searBtn setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [searBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searBtn addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:searBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark- DataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HXAutoFitCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXAutoFitCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];//color;
    cell.lab.text = self.dataArr[indexPath.row];
    
    if (self.isEdit) {
        [self sharkAnimation:cell];
    } else {
        [self sharkEnd:cell];
    }
    
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
#pragma mark- Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSString * indexValue = self.dataArr[indexPath.row];
//    NSLog(@"点击了第几个 section %ld, row %ld",indexPath.section,indexPath.row);
   
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //取出源item数据
    id objc = [self.dataArr objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.dataArr removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.dataArr insertObject:objc atIndex:destinationIndexPath.item];
}
#pragma mark- 手势操作
#pragma mark 长按 移动操作
- (void)addLongPress {
    [self.collectioView addGestureRecognizer:self.longPress];
    [self.collectioView removeGestureRecognizer:self.longMovePress];
}
- (void)longPressAction:(UILongPressGestureRecognizer *)ges {
    
    
    UIGestureRecognizerState state = ges.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            //判断是否在当前cell的点击
            NSIndexPath * touchIndex =  [self.collectioView indexPathForItemAtPoint:[ges locationInView:self.collectioView]];
            if (touchIndex) {
                self.isEdit = YES;
                //添加移动手势
                [self addMovePress];
                
                //移除 长按手势
                [self.collectioView removeGestureRecognizer:self.longPress];
                [self.collectioView reloadData];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark 移动操作
- (void)addMovePress {
    
    [self.collectioView addGestureRecognizer:self.longMovePress];
     [self.collectioView removeGestureRecognizer:self.longPress];
}
- (void)longMovePressAction:(UILongPressGestureRecognizer *)ges {
   UIGestureRecognizerState state = ges.state;
    BOOL canMove = YES;
   switch (state) {
       case UIGestureRecognizerStateBegan:
       {
           //判断是否在当前cell的点击
           NSIndexPath * touchIndex =  [self.collectioView indexPathForItemAtPoint:[ges locationInView:self.collectioView]];
           if (touchIndex) {
               //开始交互 运动
               [self.collectioView beginInteractiveMovementForItemAtIndexPath:touchIndex];
           }
           
       }
           break;
       case UIGestureRecognizerStateChanged:
       {
           NSIndexPath * touchIndex =  [self.collectioView indexPathForItemAtPoint:[ges locationInView:self.collectioView]];
           if (touchIndex) {
               [self.collectioView updateInteractiveMovementTargetPosition:[ges locationInView:self.collectioView]];
           }
           
       }
           break;
       case UIGestureRecognizerStateEnded:
       {
           [self.collectioView endInteractiveMovement];
       }
           break;
           
       default: {
           [self.collectioView cancelInteractiveMovement];
       }
           break;
   }
}

#pragma mark 编辑抖动动画

- (void)sharkAnimation:(UICollectionViewCell *)cell {
    CABasicAnimation * shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shakeAnimation.duration = 0.1;
    shakeAnimation.repeatCount = HUGE_VAL;
    shakeAnimation.fromValue = @(-M_PI_4/8);
    shakeAnimation.toValue = @(M_PI_4/8);
    shakeAnimation.autoreverses = YES;
    [cell.layer addAnimation:shakeAnimation forKey:@"CellShake"];
}
- (void)sharkEnd:(UICollectionViewCell *)cell {
    CABasicAnimation * shakeAnimation = [cell.layer animationForKey:@"CellShake"];
    if (shakeAnimation) {
        [cell.layer removeAnimationForKey:@"CellShake"];
    }
}

#pragma mark- Event
- (void)completeAction {
    
    if (self.isEdit) {
        [self addLongPress];
        [self.collectioView reloadData];
    }
    self.isEdit = NO;
}

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
        _collectioView.userInteractionEnabled = YES;
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


- (UILongPressGestureRecognizer *)longPress
{
    if(!_longPress)
    {
        _longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        _longPress.minimumPressDuration = 0.2;
    }
    return _longPress;
}

- (UILongPressGestureRecognizer *)longMovePress
{
    if(!_longMovePress)
    {
        _longMovePress= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longMovePressAction:)];
        _longMovePress.minimumPressDuration = 0.f;
    }
    return _longMovePress;
}

@end
