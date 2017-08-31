//
//  OrderYi2TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "OrderYi2TableViewCell.h"

#import "OrderYiModel.h"
@interface OrderYi2TableViewCell()
@property (nonatomic, strong) UIImageView* shopIV;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* staLable;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIButton* shopBtn;
@property (nonatomic, strong) UIView* bgView1;
@property (nonatomic, strong) UIView* bgView;

@end

@implementation OrderYi2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.bgView1 = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 46)];
    self.bgView1.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    [self.contentView addSubview:self.bgView1];
    
    self.bgView = [MyController viewWithFrame:CGRectMake(0, 6, [MyController getScreenWidth], 40)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView1 addSubview:self.bgView];
    
    self.shopIV = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"shijian"];
    [self.bgView addSubview:self.shopIV];
    
    [self.shopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.staLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.staLable.numberOfLines = 1;
//    self.staLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.staLable.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.staLable];
    
    [self.staLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
        make.top.mas_equalTo(0);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"牛人小铺"];
    self.nameLable.numberOfLines = 1;
    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.bgView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopIV.mas_right).mas_offset(3);
        make.right.mas_equalTo(self.staLable.mas_left).mas_offset(-3);
        make.height.mas_offset(40);
        make.top.mas_equalTo(0);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.shopBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(shopBtnClick:) Title:nil];
//    self.shopBtn.tag = section;
    [self.bgView addSubview:self.shopBtn];
    
    [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.bgView1;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)shopBtnClick:(UIButton*)btn{
    [self.OrderYi2TableViewCellDelegate sendBackShop:self.sectionItem];
}


- (void)configCellWithModel:(OrderYiModel *)model{
    self.nameLable.text = model._name;
    
    self.staLable.text = model._sta;
    if ([@"交易成功" isEqualToString:model._sta]) {
        self.staLable.textColor = [MyController colorWithHexString:@"45c45d"];
    }else if ([@"卖家已发货" isEqualToString:model._sta]){
        self.staLable.textColor = [MyController colorWithHexString:@"19a0e5"];
    }else{
        self.staLable.textColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    }
}
@end
