
//
//  BuyCarViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/30.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BuyCarViewController.h"

#import "BuyCarModel.h"

#import "BuyCarTableViewCell.h"
@interface BuyCarViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@property(nonatomic,retain)NSMutableArray* selectArr;

@property (nonatomic, strong) UIImageView* selectIV;
@property (nonatomic, strong) UIImageView* shopIV;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIButton* shopBtn;
@end

@implementation BuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购物车";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    [self makeRightNavBtn];
    
    [self createTableView];
    
    [self makeBottomView];
    
    [self makeData];
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 创建底部按钮
- (void)makeBottomView{
    UIButton* payBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(payBtnClick) Title:@"结算"];
    [payBtn setBackgroundColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:payBtn];
}

#pragma mark - 结算按钮响应
- (void)payBtnClick{
    
}

#pragma mark - 创建导航右按钮
- (void)makeRightNavBtn{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,27)];
    [rightButton1 setTitle:@"编辑" forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightButton1 addTarget:self action:@selector(editBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    self.navigationItem.rightBarButtonItem= rightItem1;
}

#pragma mark - 编辑按钮响应
- (void)editBtnClick{
    NSLog(@"编辑");
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
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
    return aa.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCarModel* model = self.dataSource[indexPath.section][indexPath.row];
    model._isSelect = !model._isSelect;
    
    //一个cell刷新
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"BuyCarTableViewCell";
    BuyCarTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[BuyCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BuyCarModel *model = nil;
    model = self.dataSource[indexPath.section][indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCarModel* model = self.dataSource[indexPath.section][indexPath.row];
    return [BuyCarTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        BuyCarTableViewCell *cell = (BuyCarTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - tableView头标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* bgView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    self.selectIV = [MyController createImageViewWithFrame:bgView.frame ImageName:@"shijian"];
    [bgView addSubview:self.selectIV];
    
    [self.selectIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
    }];
    
    
    self.shopIV = [MyController createImageViewWithFrame:bgView.frame ImageName:@"shijian"];
    [bgView addSubview:self.shopIV];
    
    [self.shopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectIV.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:bgView.frame Font:14 Text:@"牛人小铺"];
    self.nameLable.numberOfLines = 1;
    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [bgView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopIV.mas_right).mas_offset(3);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.shopBtn = [MyController createButtonWithFrame:bgView.frame ImageName:nil Target:self Action:@selector(shopBtnClick:) Title:nil];
    self.shopBtn.tag = section;
    [bgView addSubview:self.shopBtn];
    
    [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    return bgView;
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return   UITableViewCellEditingStyleDelete;
    
}

#pragma mark - 先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}

#pragma mark - 进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        //一个section刷新
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

#pragma mark - 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
    
}

#pragma mark - 设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
    
}


#pragma mark - 选中一组响应
- (void)shopBtnClick:(UIButton*)btn{
    self.selectArr[btn.tag] = [NSString stringWithFormat:@"%d",![self.selectArr[btn.tag] intValue]];
    NSArray* aa = self.dataSource[btn.tag];
    for(int i = 0; i < aa.count; i++){
        BuyCarModel* model = aa[i];
        model._isSelect = [self.selectArr[btn.tag] boolValue];
    }
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:btn.tag];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - tableView头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)makeData{
    self.selectArr = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSMutableArray* temA = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i++) {
            BuyCarModel* model = [[BuyCarModel alloc] init];
            model._img = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
            model._title = @"陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行";
            model._des = @"美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健";
            model._price = @"998.0";
            model._num = @"2";
            [temA addObject:model];
        }
        [self.selectArr addObject:@"0"];
        [self.dataSource addObject:temA];
    }
    [_tableView reloadData];
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
