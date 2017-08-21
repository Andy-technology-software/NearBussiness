//
//  LoginViewController.m
//  NearBusiness
//
//  Created by 徐仁强 on 2017/8/20.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginAndRegistModel.h"

#import "LoginTableViewCell.h"

#import "RegistViewController.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,LoginTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    self.dataSource = [[NSMutableArray alloc] init];
    [self makeData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
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

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginTableViewCell* cell0 = [[LoginTableViewCell alloc] init];
    LoginAndRegistModel *model = nil;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    cell0.LoginTableViewCellDelegate = self;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginAndRegistModel* model = self.dataSource[indexPath.row];
    return [LoginTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        LoginTableViewCell *cell = (LoginTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    LoginAndRegistModel* model = [[LoginAndRegistModel alloc] init];
    [self.dataSource addObject:model];
    [_tableView reloadData];
}

#pragma mark - 登录代理
- (void)login{
//    [JPUSHService setAlias:@"" callbackSelector:@selector(callBack) object:nil];
//    
//    //登录环信
//    [[EMClient sharedClient] loginWithUsername:self.nameTF.text password:self.nameTF.text completion:^(NSString *aUsername, EMError *aError) {
//        if (!aError) {
//            NSLog(@"登陆成功");
//            [[EMClient sharedClient] setApnsNickname:@""];
//        } else {
//            NSLog(@"登陆失败");
//        }
//    }];
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
}

#pragma mark - 注册代理
- (void)regist{
    RegistViewController* vc = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 忘记密码代理
- (void)forgetPW{
    
    
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
