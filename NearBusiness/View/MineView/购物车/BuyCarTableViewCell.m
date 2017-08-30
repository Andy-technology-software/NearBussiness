//
//  BuyCarTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/30.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BuyCarTableViewCell.h"

#import "BuyCarModel.h"
@interface BuyCarTableViewCell()

@property (nonatomic, strong) UIImageView* selectIV;
@property (nonatomic, strong) UIImageView* headIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* priceLable;
@property (nonatomic, strong) UILabel* numLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView0;

@end
@implementation BuyCarTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.selectIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.selectIV];
    
    [self.selectIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_offset(13);
        make.width.mas_offset(13);
    }];
    
    self.headIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectIV.mas_right).mas_offset(5);
        make.top.mas_equalTo(16);
        make.height.mas_offset(106/2);
        make.width.mas_offset(71);
    }];
    
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.priceLable.textAlignment = NSTextAlignmentRight;
    self.priceLable.textColor = [MyController colorWithHexString:@"ee4737"];
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(19);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.textColor = [MyController colorWithHexString:@"393939"];
    self.titleLable.numberOfLines = 1;
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLable);
        make.left.mas_equalTo(self.headIV.mas_right).mas_offset(9);
        make.right.mas_equalTo(self.priceLable.mas_left).mas_offset(-2);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.textColor = [MyController colorWithHexString:@"8d8d8d"];
    self.desLable.numberOfLines = 2;
    self.desLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(-40);
    }];
    
    self.numLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.numLable.textColor = [MyController colorWithHexString:@"393939"];
    self.numLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLable];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headIV.mas_bottom);
        make.left.mas_equalTo(self.desLable.mas_right);
        make.right.mas_equalTo(-5);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headIV.mas_bottom).mas_offset(16);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView0.mas_bottom);
        make.height.mas_offset(6);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(BuyCarModel *)model{
    if (model._isSelect) {
        self.selectIV.image = [UIImage imageNamed:@"shijian"];
    }else{
        self.selectIV.image = [UIImage imageNamed:@""];
    }
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model._img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.titleLable.text = model._title;
    
    self.desLable.text = model._des;
    
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model._price];
    
    self.numLable.text = [NSString stringWithFormat:@"X%@",model._num];
}

@end
