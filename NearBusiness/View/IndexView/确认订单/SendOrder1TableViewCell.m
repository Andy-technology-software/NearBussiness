//
//  SendOrder1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "SendOrder1TableViewCell.h"

#import "SendOrder1Model.h"
@interface SendOrder1TableViewCell()
@property (nonatomic, strong) UIImageView* payTypeIV;
@property (nonatomic, strong) UIImageView* rightIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* typeLable;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation SendOrder1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(14);
        make.width.mas_offset(75);
    }];
    
    self.payTypeIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.payTypeIV];
    
    [self.payTypeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_right);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.typeLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.typeLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.typeLable];
    
    [self.typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.payTypeIV.mas_right).mas_offset(10);
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.rightIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.rightIV];
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"ededed"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(14);
        make.height.mas_offset(6);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(SendOrder1Model *)model{
    self.titleLable.text = @"支付方式";
    
    self.payTypeIV.image = [UIImage imageNamed:@"shijian"];//[UIImage imageNamed:model._payType];
    
    self.typeLable.text = model._payType;
}


@end
