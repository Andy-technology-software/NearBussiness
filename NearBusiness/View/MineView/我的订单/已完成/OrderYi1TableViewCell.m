//
//  OrderYi1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/23.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "OrderYi1TableViewCell.h"

#import "OrderYi1Model.h"
@interface OrderYi1TableViewCell()
@property (nonatomic, strong) UILabel* countPriceLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UIButton* comBtn;
@end
@implementation OrderYi1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.countPriceLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.countPriceLable.textColor = [MyController colorWithHexString:@"4c4c4c"];
    [self.contentView addSubview:self.countPriceLable];
    
    [self.countPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_offset(25);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f0f0f0"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.countPriceLable.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.comBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(comBtnClick) Title:@"评价"];
    [self.comBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.comBtn setBackgroundColor:[MyController colorWithHexString:@"ffad16"]];
    self.comBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.comBtn];
    
    [self.comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(10);
        make.height.mas_offset(22);
        make.width.mas_offset(60);
    }];
    
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.comBtn.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(OrderYi1Model *)model {
    self.countPriceLable.text = model._countPrice;
}

- (void)comBtnClick{
    [self.OrderYi1TableViewCellDelegate didselectCom:self.sectionIndex];
}

@end
