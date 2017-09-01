//
//  SendOrderTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "SendOrderTableViewCell.h"

#import "SendOrderModel.h"
@interface SendOrderTableViewCell()
@property (nonatomic, strong) UIImageView* leftIV;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* priceLable;
@property (nonatomic, strong) UILabel* numLable;

@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIButton* jiaBtn;
@property (nonatomic, strong) UIButton* jianBtn;

@end
@implementation SendOrderTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.leftIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.leftIV];
    
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(12);
        make.height.mas_offset(52);
        make.width.mas_offset(71);
    }];
    
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable.numberOfLines = 1;
    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.nameLable];
    
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(10);
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-10);
    }];
    
    self.jiaBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(jiaBtnClick) Title:@"+"];
    [self.jiaBtn setTitleColor:[MyController colorWithHexString:SUBTITLECOLOR] forState:UIControlStateNormal];
    self.jiaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(12);
        make.right.mas_equalTo(-10);
        make.width.mas_offset(25);
        make.height.mas_offset(25);
    }];
    
    self.numLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.numLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.numLable];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiaBtn);
        make.right.mas_equalTo(self.jiaBtn.mas_left).mas_offset(-2);
        make.bottom.mas_equalTo(self.jiaBtn);
        make.width.mas_offset(40);
    }];
    
    self.jianBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(jianBtnClick) Title:@"-"];
    [self.jianBtn setTitleColor:[MyController colorWithHexString:SUBTITLECOLOR] forState:UIControlStateNormal];
    self.jianBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLable);
        make.right.mas_equalTo(self.numLable.mas_left).mas_offset(-2);
        make.width.mas_equalTo(self.jiaBtn);
        make.height.mas_equalTo(self.jiaBtn);
    }];
    
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.priceLable.textColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.jianBtn);
        make.right.mas_equalTo(self.jianBtn.mas_left).mas_offset(-10);
    }];
    
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"ededed"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(14);
        make.height.mas_offset(6);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(SendOrderModel *)model{
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model._img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLable.text = model._name;
    
    self.numLable.text = model._num;
    
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model._price];
}

- (void)jiaBtnClick{
    
}

- (void)jianBtnClick{
    
}

@end
