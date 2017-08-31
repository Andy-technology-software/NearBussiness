//
//  FundManagementCashViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "FundManagementCashViewController.h"

#import "FundManagementCashModel.h"

#import "FundManagementCashTableViewCell.h"
@interface FundManagementCashViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation FundManagementCashViewController

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
    return self.dataSource.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FundManagementCashTableViewCell";
    FundManagementCashTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[FundManagementCashTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    FundManagementCashModel *model = nil;
    model = self.dataSource[indexPath.section];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
    
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FundManagementCashModel* model = self.dataSource[indexPath.section];
    return [FundManagementCashTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        FundManagementCashTableViewCell *cell = (FundManagementCashTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - tableView头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65;
}

#pragma mark - tableView头标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* bgView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 65)];
    bgView.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    UIView* whiteView = [MyController viewWithFrame:bgView.frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(6);
        make.height.mas_offset(31);
    }];
    
    UILabel* titL = [MyController createLabelWithFrame:whiteView.frame Font:14 Text:@"账户余额  900.0"];
    [MyController fuwenbenLabel:titL FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, titL.text.length - 4) AndColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [whiteView addSubview:titL];
    
    [titL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(0);
        make.height.mas_offset(31);
    }];
    
    UILabel* titL1 = [MyController createLabelWithFrame:whiteView.frame Font:14 Text:@"充值"];
    titL1.textColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    titL1.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:titL1];
    
    [titL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_offset(40);
        make.height.mas_offset(31);
    }];
    
    UIButton* chongzhiBtn = [MyController createButtonWithFrame:whiteView.frame ImageName:nil Target:self Action:@selector(chongzhiBtnClick) Title:nil];
    [whiteView addSubview:chongzhiBtn];
    
    [chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.top.mas_equalTo(0);
        make.width.mas_offset(40);
        make.height.mas_offset(31);
    }];
    
    UIView* lineV = [MyController viewWithFrame:bgView.frame];
    lineV.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [bgView addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(whiteView.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    UIView* whiteView1 = [MyController viewWithFrame:bgView.frame];
    whiteView1.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView1];
    
    [whiteView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(lineV.mas_bottom).mas_offset(6);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-0.5);
    }];
    
    UILabel* titL2 = [MyController createLabelWithFrame:whiteView.frame Font:12 Text:@"收支记录"];
    titL2.textColor = [MyController colorWithHexString:@"979797"];
    [whiteView1 addSubview:titL2];
    
    [titL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(whiteView1.mas_bottom);
    }];
    
    UIView* lineV1 = [MyController viewWithFrame:bgView.frame];
    lineV1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [bgView addSubview:lineV1];
    
    [lineV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(whiteView1.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    return bgView;
}

#pragma mark - 充值按钮响应
- (void)chongzhiBtnClick{
    NSLog(@"充值");
}

- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        FundManagementCashModel* model = [[FundManagementCashModel alloc] init];
        model._img = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model._title = @"充值";
        model._time = @"2017-09-09 12:33:22";
        model._num = @"￥200.0";
        [self.dataSource addObject:model];
    }
    [_tableView reloadData];
}


- (void)sendBackShop:(NSInteger)sectionItem{
    
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
