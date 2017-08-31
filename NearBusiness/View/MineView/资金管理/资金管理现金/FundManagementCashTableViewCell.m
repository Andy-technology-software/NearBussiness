//
//  FundManagementCashTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "FundManagementCashTableViewCell.h"

#import "FundManagementCashModel.h"
@interface FundManagementCashTableViewCell()
@property (nonatomic, strong) UIImageView* leftIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* tiemLable;
@property (nonatomic, strong) UILabel* numLable;

@property (nonatomic, strong) UIView* lineView;

@end
@implementation FundManagementCashTableViewCell

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
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];
    
    self.numLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.numLable.textAlignment = NSTextAlignmentRight;
    self.numLable.textColor = [MyController colorWithHexString:@"393939"];
    [self.contentView addSubview:self.numLable];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(19);
    }];
    
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.textColor = [MyController colorWithHexString:@"525252"];
    self.titleLable.numberOfLines = 1;
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.numLable.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.numLable);
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(10);
    }];
    
    
    self.tiemLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.tiemLable.textColor = [MyController colorWithHexString:@"979797"];
    [self.contentView addSubview:self.tiemLable];
    
    [self.tiemLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.titleLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(15);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(FundManagementCashModel *)model{
    self.titleLable.text = model._title;
    
    self.numLable.text = model._num;
    
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model._img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.tiemLable.text = model._time;
}

@end
