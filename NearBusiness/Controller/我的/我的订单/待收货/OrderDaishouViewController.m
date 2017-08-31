//
//  OrderDaishouViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/23.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "OrderDaishouViewController.h"

#import "OrderYiModel.h"

#import "OrderYi1Model.h"

#import "OrderYiTableViewCell.h"

#import "OrderDaishouTableViewCell.h"

#import "OrderYi2TableViewCell.h"
@interface OrderDaishouViewController ()<UITableViewDataSource,UITableViewDelegate,OrderDaishouTableViewCellDelegate,OrderYi2TableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;
@property(nonatomic,retain)NSMutableArray* dataSource1;
@property(nonatomic,retain)NSMutableArray* dataSource2;

@end

@implementation OrderDaishouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    [self createTableView];
    
    [self makeData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* aa = self.dataSource[section];
    return aa.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* aa = self.dataSource[indexPath.section];
    
    if (0 == indexPath.row) {
        static NSString *cellIdentifier = @"OrderYi2TableViewCell";
        OrderYi2TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell0) {
            cell0 = [[OrderYi2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell0.OrderYi2TableViewCellDelegate = self;
        cell0.sectionItem = indexPath.section;
        OrderYiModel *model = nil;
        model = self.dataSource2[indexPath.section];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }else if (indexPath.row > aa.count){
        static NSString *cellIdentifier = @"OrderDaishouTableViewCell";
        OrderDaishouTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell0) {
            cell0 = [[OrderDaishouTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell0.OrderDaishouTableViewCellDelegate = self;
        cell0.sectionIndex = indexPath.section;
        OrderYi1Model *model = nil;
        model = self.dataSource1[indexPath.section];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }
    
    static NSString *cellIdentifier = @"OrderYiTableViewCell";
    OrderYiTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[OrderYiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OrderYiModel *model = nil;
    model = self.dataSource[indexPath.section][indexPath.row - 1];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
    
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* aa = self.dataSource[indexPath.section];
    
    if (0 == indexPath.row) {
        OrderYiModel* model = self.dataSource2[indexPath.section];
        return [OrderYi2TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            OrderYi2TableViewCell *cell = (OrderYi2TableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }else if (indexPath.row > aa.count){
        OrderYi1Model* model = self.dataSource1[indexPath.section];
        return [OrderDaishouTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            OrderDaishouTableViewCell *cell = (OrderDaishouTableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }
    
    OrderYiModel* model = self.dataSource[indexPath.section][indexPath.row - 1];
    return [OrderYiTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        OrderYiTableViewCell *cell = (OrderYiTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    self.dataSource1 = [[NSMutableArray alloc] init];
    self.dataSource2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSMutableArray* temA = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i++) {
            OrderYiModel* model = [[OrderYiModel alloc] init];
            model._img = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
            model._title = @"陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行";
            model._des = @"美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健";
            model._price = @"998.0";
            model._num = @"2";
            [temA addObject:model];
        }
        [self.dataSource addObject:temA];
        
        OrderYi1Model* model1 = [[OrderYi1Model alloc] init];
        model1._countNum = @"2";
        model1._countPrice = @"998.0";
        [self.dataSource1 addObject:model1];
        
        
        OrderYiModel* model2 = [[OrderYiModel alloc] init];
        model2._name = @"牛牛小铺";
        model2._sta = @"卖家已发货";
        [self.dataSource2 addObject:model2];
    }
    [_tableView reloadData];
}

#pragma mark - 点击商铺代理
- (void)sendBackShop:(NSInteger)sectionItem{
    
}

#pragma mark - 点击确认收货代理
- (void)didselectMakesure:(NSInteger)sectionIndex{
    
}

#pragma mark - 点击查看物流代理
- (void)didselectCheckWL:(NSInteger)sectionIndex{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
