//
//  SendOrder2TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "SendOrder2TableViewCell.h"

#import "SendOrder2Model.h"
@interface SendOrder2TableViewCell()
@property (nonatomic, strong) UIImageView* rightIV;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* nameLable1;
@property (nonatomic, strong) UILabel* telLable;
@property (nonatomic, strong) UILabel* telLable1;
@property (nonatomic, strong) UILabel* addLable;
@property (nonatomic, strong) UILabel* addLable1;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@end
@implementation SendOrder2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(6);
    }];
    
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:@"收货人"];
    self.nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(10);
        make.width.mas_offset(75);
    }];
    
    self.nameLable1 = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable1.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    self.nameLable1.numberOfLines = 0;
    self.nameLable1.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.nameLable1];
    
    [self.nameLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable.mas_right);
        make.top.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(-30);
    }];
    
    self.telLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:@"联系电话"];
    self.telLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable1.mas_bottom).mas_offset(12);
        make.width.mas_equalTo(self.nameLable);
    }];
    
    self.telLable1 = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.telLable1.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    self.telLable1.numberOfLines = 0;
    self.telLable1.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.telLable1];
    
    [self.nameLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable.mas_right);
        make.top.mas_equalTo(self.telLable);
        make.right.mas_equalTo(self.nameLable1);
    }];
    
    self.addLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:@"收货地址"];
    self.addLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.addLable];
    
    [self.addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable);
        make.top.mas_equalTo(self.telLable1.mas_bottom).mas_offset(12);
        make.width.mas_equalTo(self.telLable);
    }];
    
    self.addLable1 = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.addLable1.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    self.addLable1.numberOfLines = 0;
    self.addLable1.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.addLable1];
    
    [self.addLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLable.mas_right);
        make.top.mas_equalTo(self.addLable);
        make.right.mas_equalTo(self.telLable1);
    }];
    
    self.rightIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.rightIV];
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.addLable1.mas_bottom).mas_offset(12);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(SendOrder2Model *)model{
    self.nameLable1.text = model._name;
    
    self.telLable1.text = model._tel;
    
    self.addLable1.text = model._add;
}


@end
