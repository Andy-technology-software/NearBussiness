//
//  OrderYiTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/23.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "OrderYiTableViewCell.h"

#import "OrderYiModel.h"
@interface OrderYiTableViewCell()
@property (nonatomic, strong) UIImageView* leftIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* priceLable;
@property (nonatomic, strong) UILabel* numLable;
@property (nonatomic, strong) UILabel* countLable;

@property (nonatomic, strong) UIView* lineView;

@end
@implementation OrderYiTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    
    self.leftIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.leftIV];
    
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(12);
        make.height.mas_offset(53);
        make.width.mas_offset(71);
    }];
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.priceLable.textColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    self.priceLable.numberOfLines = 1;
    self.priceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(14);
        make.width.mas_greaterThanOrEqualTo(51);
    }];
    
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLable.numberOfLines = 1;
    self.titleLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.priceLable.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.priceLable);
    }];
    
    self.numLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.numLable.textColor = [MyController colorWithHexString:@"4c4c4c"];
    self.numLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLable];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.leftIV);
        make.width.mas_greaterThanOrEqualTo(51);
        make.right.mas_equalTo(self.priceLable);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.desLable.numberOfLines = 2;
    self.desLable.textColor = [MyController colorWithHexString:@"4c4c4c"];
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.numLable.mas_left).mas_offset(-5);
        make.bottom.mas_equalTo(self.leftIV);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f0f0f0"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(12);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(OrderYiModel *)model {
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model._img] placeholderImage:[UIImage imageNamed:@""]];

    self.titleLable.text = model._title;

    self.desLable.text = model._des;
    
    self.numLable.text = [NSString stringWithFormat:@"X%@",model._num];
    
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model._price];
}


@end
