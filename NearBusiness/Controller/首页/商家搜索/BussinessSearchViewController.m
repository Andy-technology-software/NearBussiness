//
//  BussinessSearchViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BussinessSearchViewController.h"

#import "BussinessSearchModel.h"

#import "BussinessSearchTableViewCell.h"
@interface BussinessSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,WJMenuDelegate>{
    UITableView* _tableView;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic,retain)NSMutableArray* dataSource;
@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic,strong)NSMutableArray *data;

@property(nonatomic,assign)NSInteger pageIndex;

@property(nonatomic,retain)NSMutableArray* dataSource1;

@end

@implementation BussinessSearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarButtonItem];
    [self createTableView];
    [self makeMenu];
    self.dataSource = [[NSMutableArray alloc] init];
    [self makeData];
    
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - 创建删选菜单
- (void)makeMenu {
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    self.menu = menu;
    menu.menuArrowStyle = menuArrowStyleHollow; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    menu.selectedColor = [MyController colorWithHexString:@"ff7854"];   //  选中的字体颜色
    menu.unSelectedColor = [MyController colorWithHexString:@"81889d"];//  未选中的字体颜色
    [self.view addSubview:menu];
    [self createAllMenuData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 40, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRefresh];
    }];
    [self.view addSubview:_tableView];
}
#pragma mark - 下拉刷新
- (void)headerRefresh{
    self.pageIndex = 1;
    [self postData];
    
}

#pragma mark - 上拉加载
- (void)footerRefresh{
    self.pageIndex ++;
    [self postData];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BussinessDetailViewController* vc = [[BussinessDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"BussinessSearchTableViewCell";
    BussinessSearchTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[BussinessSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BussinessSearchModel *model = nil;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BussinessSearchModel* model = self.dataSource[indexPath.row];
    return [BussinessSearchTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        BussinessSearchTableViewCell *cell = (BussinessSearchTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    for (int i = 0; i < 10; i++) {
        BussinessSearchModel* model = [[BussinessSearchModel alloc] init];
        model.img = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model.name = @"陈伟霆03年以歌手身份入行";
        model.zhuying = @"美甲、大保健";
        model.distance = @"<200M";
        model.tel = @"18888888888";
        model.address = @"九华山路与香江路交叉口南50米";
        model.isRedPack = YES;
        [self.dataSource addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark - 创建查询窗口
- (void)setBarButtonItem {
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 66, 44)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 44)];
    searchBar.placeholder = @"请输入要搜索的商家";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = NO;
    UIView *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor whiteColor];
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //    //修改标题和标题颜色
    //    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    //    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
//    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}


- (void)presentVCFirstBackClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToSearchResultWithSearchStr:(NSString *)str{
    
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self pushToSearchResultWithSearchStr:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}

- (void)createAllMenuData{
    NSArray *threeMenuTitleArray =  @[@"分类",@"距离",@"价格"];
    //  创建第一个菜单的first数据second数据
    NSArray *firstOne = [NSArray arrayWithObjects:@"饮品",@"家电", nil];
    NSArray *secondOne = @[@[@"酒水"],@[@"电视",@"冰箱"]];
    NSArray *thirdOne = @[@[@"茅台",@"五粮液",@"西凤酒"],@[@"海信电视",@"海尔电视"],@[@"美的冰箱",@"海尔冰箱"],@[]];
    NSArray *firstMenu = [NSArray arrayWithObjects:firstOne,secondOne,thirdOne, nil];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"100米",@"500米", nil];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"由高到低",@"由低到高", nil];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree, nil];
    
    [self.menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
}

- (void)hideMenu{
    [self.menu drawBackMenu];
}

#pragma mark -- 代理方法3 返回点击时对应的内容和index(合并了方法1和方法2)
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,menuIndex,firstContent,firstIndex,secondContent,secondIndex,thirdContent,thirdIndex);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)postData {
    self.dataSource1 = [[NSMutableArray alloc] init];
    [requestService postOrderListWithUserid:@"402881b85e4b5fbe015e4b730ee60005" pageIndex:[NSString stringWithFormat:@"%ld",self.pageIndex] pageSize:@"10" complate:^(id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        NSArray* arr = [MyController arraryWithJsonString:responseObject[@"data"]];
        for (NSDictionary* dic in arr) {
            BussinessSearchModel *model = [BussinessSearchModel mj_objectWithKeyValues:dic];
            [self.dataSource1 addObject:model];
        }
        
        NSLog(@"-----%d",self.dataSource1.count);
        for (int i = 0; i < self.dataSource1.count; i++) {
            BussinessSearchModel *model = self.dataSource1[i];
            NSLog(@"%@\n",model.zhjg);
        }
    } failure:^(NSError *error) {
        
    }];
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
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
