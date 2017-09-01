//
//  ModifyPWViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ModifyPWViewController.h"

#import "RegistModel.h"

#import "RegistTableViewCell.h"
@interface ModifyPWViewController ()<UITableViewDataSource,UITableViewDelegate,RegistTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation ModifyPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改密码";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomView];
}

#pragma mark - 创建底部按钮
- (void)makeBottomView{
    UIButton* payBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(outBtnClick) Title:@"保存"];
    [payBtn setBackgroundColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:payBtn];
}

- (void)outBtnClick{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.dataSource.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"RegistTableViewCell";
    RegistTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[RegistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell0.RegistTableViewCellDelegate = self;
    cell0.indexRow = indexPath.row;
    RegistModel *model = nil;
    model = self.dataSource[indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegistModel* model = self.dataSource[indexPath.row];
    return [RegistTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        RegistTableViewCell *cell = (RegistTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    NSArray* _arr = [[NSArray alloc] initWithObjects:@"原密码",@"新密码",@"确认密码", nil];
    NSArray* _arr1 = [[NSArray alloc] initWithObjects:@"请输入原密码",@"请输入新密码",@"请输入确认密码", nil];
    for (int i = 0; i < _arr.count; i++) {
        RegistModel* model = [[RegistModel alloc] init];
        model._lableText = _arr[i];
        model._tfText = @"";
        model._placeText = _arr1[i];
        [self.dataSource addObject:model];
    }
    [_tableView reloadData];
}

#pragma markr - 返回右边数据
- (void)sendbackRegistText:(NSString *)text indexRow:(NSInteger)indexRow{
    RegistModel* model = self.dataSource[indexRow];
    model._tfText = text;
    
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
