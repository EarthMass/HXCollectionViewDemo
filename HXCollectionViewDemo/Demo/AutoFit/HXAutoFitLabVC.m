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

@property (nonatomic, strong) UIView * snapView; //移动的Cell


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

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.collectioView.collectionViewLayout invalidateLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- initUI
- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据源 第一个固定不能移动 先写死，后面可以通过数据来做处理
    self.dataArr = [NSMutableArray arrayWithArray:@[@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as",@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as",@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as"@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as"@"dabfda",@"123rrwrsaa",@"都好难打打死撒大风把",@"fadasd",@"但凡达到",@"第八发快递发送打赏发送打",@"打发撒",@"大发大发大发安抚as"@"dabfda"]];
    
    
    
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
    [cell setText: self.dataArr[indexPath.row]];
   
    
    if (self.isEdit) {
        if (indexPath.row != 0) {
            [self sharkAnimation:cell];
        }
        
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
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self.dataArr exchangeObjectAtIndex:destinationIndexPath.item withObjectAtIndex:sourceIndexPath.item];
    
    
    
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
//    BOOL canMove = YES;
    
    CGPoint touchPoint = [ges locationInView:self.collectioView];
    NSIndexPath * touchIndex =  [self.collectioView indexPathForItemAtPoint:touchPoint];
    HXAutoFitCell * cell = (HXAutoFitCell *)[self.collectioView cellForItemAtIndexPath:touchIndex];
    
   switch (state) {
       case UIGestureRecognizerStateBegan:
       {
           //判断是否在当前cell的点击
           if (touchIndex  && touchIndex.row != 0) {
               //开始交互 运动
               [self.collectioView beginInteractiveMovementForItemAtIndexPath:touchIndex];
               //编辑当前项变大
               [self addOpCellInCell:cell touchPoint:touchPoint];
               
           }
           
       }
           break;
       case UIGestureRecognizerStateChanged:
       {
           //这边可以加过滤条件
           [self opCellMoveToPoint:touchPoint];
           if (touchIndex  && touchIndex.row != 0) {
               [self.collectioView updateInteractiveMovementTargetPosition:[ges locationInView:self.collectioView]];
               
           }
           
       }
           break;
       case UIGestureRecognizerStateEnded:
       {

           [self.collectioView endInteractiveMovement];
           [self removeOpCellInCell:cell];
       }
           break;
           
       default: {

           [self.collectioView cancelInteractiveMovement];
           [self removeOpCellInCell:cell];
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

- (void)addOpCellInCell:(UICollectionViewCell *)cell touchPoint:(CGPoint)touchPoint {
    self.snapView = [cell snapshotViewAfterScreenUpdates:NO];
    // 添加到 collectionView 不然无法显示
    [self.collectioView addSubview:self.snapView];
    // 设置frame
    self.snapView.frame = cell.frame;
    
    // 截图后隐藏当前 cell
    cell.hidden = YES;

    // 动画放大和移动到触摸点下面
    [UIView animateWithDuration:0.25 animations:^{
        self.snapView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.snapView.center = CGPointMake(touchPoint.x, touchPoint.y);
        self.snapView.alpha = 0.8;
    }];
}

- (void)opCellMoveToPoint:(CGPoint)point {
    // 截图视图位置移动
    [UIView animateWithDuration:0.1 animations:^{
        self.snapView.center = point;
    }];
}

- (void)removeOpCellInCell:(UICollectionViewCell *)cell {
    cell.hidden = NO;
    if (self.snapView.superview) {
        [self.snapView removeFromSuperview];
        self.snapView = nil;
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



- (UIView *)snapView {
    if (!_snapView) {
        _snapView  = [[UIView alloc] init];
    }
    return _snapView;
}

@end
