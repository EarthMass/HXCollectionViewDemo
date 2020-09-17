//
//  ViewController.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/10.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) UITableView * tableV;
@property (nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation ViewController

#pragma mark- cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- initUI
- (void)initUI {
    
    self.dataArr =
    @[
        @{@"title":@"普通显示",@"dataArr":@[
            @{@"vc":@"HXCollectionViewNormalVC",@"title":@"普通"},
            @{@"vc":@"HXCusSectionVC",@"title":@"自定义section背景，圆角阴影"}
        ]},
        @{@"title":@"特殊显示",@"dataArr":@[
            @{@"vc":@"HXCycleCollectionViewVC",@"title":@"圆形显示"},
            @{@"vc":@"HXHorCardVC",@"title":@"水平视差卡片"},
            @{@"vc":@"HXAutoSizeVC",@"title":@"自适应"},
            
        ]},
    ];
    
    [self.view addSubview:self.tableV];
    [_tableV mas_makeConstraints:^(MASConstraintMaker * make) {
        make.edges.equalTo(self.view);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * rows = self.dataArr[section][@"dataArr"];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"XXX";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    NSDictionary * dic = self.dataArr[indexPath.section][@"dataArr"][indexPath.row];
    cell.textLabel.text = dic[@"title"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataArr[section][@"title"];
}


#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = self.dataArr[indexPath.section][@"dataArr"][indexPath.row];
    Class class = NSClassFromString(dic[@"vc"]);
    UIViewController * vc = [[class alloc] init];
    vc.title = dic[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView{
    //隐藏多余的cell分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    //    [tableView setTableHeaderView:view];
    
}

#pragma mark- Event

#pragma mark- Setting Getting

- (UITableView *)tableV {
    if (!_tableV) {
        
        _tableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self setExtraCellLineHidden:_tableV];
        
        _tableV.estimatedRowHeight = 60;
        _tableV.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableV;
}




- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}





@end
