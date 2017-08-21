//
//  LoginTableViewCell.m
//  NearBusiness
//
//  Created by 徐仁强 on 2017/8/20.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "LoginTableViewCell.h"

#import "LoginAndRegistModel.h"
@interface LoginTableViewCell()
@property (nonatomic,strong) UILabel* pwLable;
@property (nonatomic,strong) UILabel* telLable;

@property (nonatomic,strong) UITextField* pwTF;
@property (nonatomic,strong) UITextField* telTF;

@property (nonatomic,strong) UIImageView* logoIV;

@property (nonatomic,strong) UIButton* loginBtn;
@property (nonatomic,strong) UIButton* registBtn;
@property (nonatomic,strong) UIButton* forgetPWBtn;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@end
@implementation LoginTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    
    self.logoIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    self.logoIV.backgroundColor = [MyController colorWithHexString:@"c5c5c5"];
    //将图层的边框设置为圆脚
    self.logoIV.layer.cornerRadius = 40;
    self.logoIV.layer.masksToBounds = YES;
    [self.logoIV setContentMode:UIViewContentModeScaleAspectFill];
    self.logoIV.clipsToBounds = YES;
    [self.contentView addSubview:self.logoIV];
    
    [self.logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.height.mas_offset(80);
        make.width.mas_offset(80);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    
    self.telLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:@"用户名"];
    self.telLable.textColor = [MyController colorWithHexString:@"aeadad"];
    [self.contentView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoIV.mas_bottom).mas_offset(45);
        make.left.mas_equalTo(25);
        make.width.mas_offset(60);
    }];

    self.telTF = [MyController createTextFieldWithFrame:self.contentView.frame placeholder:@"请输入用户名" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    [self.contentView addSubview:self.telTF];
    
    [self.telTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.telLable);
        make.left.mas_equalTo(self.telLable.mas_right);
        make.right.mas_equalTo(-35);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e2e2"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.top.mas_equalTo(self.telLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    self.pwLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:@"密码"];
    self.pwLable.textColor = [MyController colorWithHexString:@"aeadad"];
    [self.contentView addSubview:self.pwLable];
    
    [self.pwLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(19);
        make.left.mas_equalTo(self.telLable);
        make.width.mas_equalTo(self.telLable);
    }];
    
    self.pwTF = [MyController createTextFieldWithFrame:self.contentView.frame placeholder:@"请输入密码" passWord:YES leftImageView:nil rightImageView:nil Font:14];
    [self.contentView addSubview:self.pwTF];
    
    [self.pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwLable);
        make.left.mas_equalTo(self.telTF);
        make.right.mas_equalTo(self.telTF);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e2e2"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView);
        make.right.mas_equalTo(self.lineView);
        make.top.mas_equalTo(self.pwLable.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(self.lineView);
    }];
    

    self.loginBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(loginBtnClick:) Title:@"登录"];
    self.loginBtn.backgroundColor = [MyController colorWithHexString:@"ee4737"];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(self.lineView1);
        make.right.mas_equalTo(self.lineView1);
        make.height.mas_offset(45);
    }];
    
    self.registBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(registBtnClick:) Title:@"注册"];
    self.registBtn.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    [self.registBtn setTitleColor:[MyController colorWithHexString:@"acacac"] forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.registBtn];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.loginBtn);
        make.height.mas_offset(30);
        make.width.mas_offset(40);
        
    }];
    
    self.forgetPWBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(forgetPWBtnClick) Title:@"忘记密码"];
    self.forgetPWBtn.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    [self.forgetPWBtn setTitleColor:[MyController colorWithHexString:@"acacac"] forState:UIControlStateNormal];
    self.forgetPWBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.forgetPWBtn];
    
    [self.forgetPWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.registBtn);
        make.right.mas_equalTo(self.loginBtn);
        make.height.mas_offset(30);
        make.width.mas_offset(60);
        
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.forgetPWBtn;
    self.hyb_bottomOffsetToCell = 30;
}
- (void)configCellWithModel:(LoginAndRegistModel *)model {
    self.telTF.text = model._tel;
    
    self.pwTF.text = model._pw;
}

- (void)loginBtnClick:(UIButton*)btn{
    [self.LoginTableViewCellDelegate login];
}

- (void)registBtnClick:(UIButton*)btn{
    [self.LoginTableViewCellDelegate regist];
}

- (void)forgetPWBtnClick{
    [self.LoginTableViewCellDelegate forgetPW];
}

@end
