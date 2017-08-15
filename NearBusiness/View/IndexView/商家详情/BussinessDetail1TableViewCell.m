
//
//  BussinessDetail1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BussinessDetail1TableViewCell.h"

#import "BussinessDetail1Model.h"
@interface BussinessDetail1TableViewCell()
@property (nonatomic, strong) UIImageView* addIV;
@property (nonatomic, strong) UIImageView* telIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* jieshaoLable;
@property (nonatomic, strong) UILabel* addLable;
@property (nonatomic, strong) UILabel* telLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;
@property (nonatomic, strong) UIView* lineView3;

@property (nonatomic, strong) UIButton* telBtn;
@end
@implementation BussinessDetail1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(8);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:@"商家介绍"];
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(12);
    }];
    
    self.jieshaoLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.jieshaoLable.numberOfLines = 0;
    self.jieshaoLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.jieshaoLable];
    
    [self.jieshaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(15);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.jieshaoLable.mas_bottom).mas_offset(15);
        make.height.mas_offset(0.5);
    }];
    
    self.addIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    self.addIV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.addIV];
    
    [self.addIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(12);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];

    
    self.addLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.addLable.numberOfLines = 0;
    self.addLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.addLable];
    
    [self.addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addIV.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.jieshaoLable);
        make.top.mas_equalTo(self.addIV);
    }];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.addLable.mas_bottom).mas_offset(12);
        make.height.mas_offset(0.5);
    }];
    
    
    self.telIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    self.telIV.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.telIV];
    
    [self.telIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView2.mas_bottom).mas_offset(12);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    
    self.telLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.telLable.numberOfLines = 0;
    self.telLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable);
        make.right.mas_equalTo(self.addLable);
        make.top.mas_equalTo(self.telIV);
    }];

    self.telBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(telBtnClick) Title:nil];
    [self.contentView addSubview:self.telBtn];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView1);
        make.bottom.mas_equalTo(self.lineView2.mas_bottom);
    }];
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView3];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.telLable.mas_bottom).mas_offset(12);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView3;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(BussinessDetail1Model *)model {
    self.jieshaoLable.text = model.jieshao;
    
    self.addLable.text = model.add;
    
    self.telLable.text = model.tel;
}

- (void)telBtnClick{
    [self.BussinessDetail1TableViewCellDelegate didselectTel];
}


@end
