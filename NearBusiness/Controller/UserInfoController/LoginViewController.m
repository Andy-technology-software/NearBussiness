//
//  LoginViewController.m
//  E展汇
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@property(nonatomic,retain)JVFloatLabeledTextField *nameTF;
@property(nonatomic,retain)JVFloatLabeledTextField *PWTF;
@property(nonatomic,strong)UIView* lineView;
@property(nonatomic,strong)UIView* lineView1;

@property(nonatomic,retain)UIButton* dengluBtn;

@property (nonatomic,assign)CLLocationCoordinate2D dingwei;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self getLat];
    
}
#pragma mark -- 获取经纬度
-(void)getLat {
//    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
//        NSLog(@"%f +++++++++++ %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
//        self.dingwei = locationCorrrdinate;
//    }];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.image = [UIImage imageNamed:@"背景"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self makecellUI:cell];
    return cell;
}
- (void)makecellUI:(UITableViewCell*)cell{
    self.nameTF = [[JVFloatLabeledTextField alloc] init];
    self.nameTF.font = [UIFont systemFontOfSize:16];
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"手机号", @"")
                                                                       attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.nameTF.floatingLabelFont = [UIFont boldSystemFontOfSize:14];
    self.nameTF.floatingLabelTextColor = [UIColor brownColor];
    self.nameTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameTF.keyboardType = UIKeyboardTypeNumberPad;
    [cell addSubview:self.nameTF];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(65);
        make.right.mas_equalTo(-40);
        make.height.mas_offset(60);
    }];
    
    self.lineView = [[UIView alloc] init];
    [cell addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTF);
        make.right.mas_equalTo(self.nameTF);
        make.top.mas_equalTo(self.nameTF.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.PWTF = [[JVFloatLabeledTextField alloc] init];
    self.PWTF.font = [UIFont systemFontOfSize:16];
    self.PWTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码", @"")
                                                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.PWTF.floatingLabelFont = [UIFont boldSystemFontOfSize:14];
    self.PWTF.floatingLabelTextColor = [UIColor brownColor];
    self.PWTF.translatesAutoresizingMaskIntoConstraints = NO;
    [self.PWTF setSecureTextEntry:YES];
    [cell addSubview:self.PWTF];
    
    [self.PWTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTF);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(40);
        make.right.mas_equalTo(self.nameTF);
        make.height.mas_equalTo(self.nameTF);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    [cell addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.PWTF);
        make.right.mas_equalTo(self.PWTF);
        make.top.mas_equalTo(self.PWTF.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.dengluBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(dengluBtnClick) Title:@"登录"];
    [self.dengluBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dengluBtn setBackgroundColor:[UIColor blackColor]];
    self.dengluBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell addSubview:self.dengluBtn];
    
    [self.dengluBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.PWTF);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(40);
        make.right.mas_equalTo(self.PWTF);
        make.height.mas_offset(40);
    }];
}
#pragma mark - 左边登录响应
- (void)leftDengluBtnClick{
    NSLog(@"登录1");
    [self rdv_tabBarController].selectedIndex = 0;
    [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
}
#pragma mark - 登录响应
- (void)dengluBtnClick{
    NSLog(@"登录2");
    [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
    if (![RegularExpressions validateMobile:self.nameTF.text]) {
        
        [HUD warning:@"请正确输入手机号"];
        return;
    }else if (self.PWTF.text.length < 6){
        
        [HUD warning:@"请输入六位以上密码"];
        return;
    }else{
//        [HUD loading];
//        [self createLoginRequest];
//        [self testWithUserName:self.nameTF.text AndPassword:self.PWTF.text];
    }
    
}
#pragma mark - 注册响应
- (void)zhuceBtnClick{
    NSLog(@"注册");
}
#pragma mark - 忘记密码响应
- (void)wangjimimaBtnClick{
    NSLog(@"忘记密码");
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}

- (void)createLoginRequest{
    [JPUSHService setAlias:@"" callbackSelector:@selector(callBack) object:nil];
    
    //登录环信
    [[EMClient sharedClient] loginWithUsername:self.nameTF.text password:self.nameTF.text completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            NSLog(@"登陆成功");
            [[EMClient sharedClient] setApnsNickname:@""];
        } else {
            NSLog(@"登陆失败");
        }
    }];
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
}

@end
