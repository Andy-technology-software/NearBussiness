//
//  SeetingCenterTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "SeetingCenterTableViewCell.h"

#import "SeetingCenterModel.h"
@interface SeetingCenterTableViewCell()

@property (nonatomic, strong) UIImageView* rIV;

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UIView* lineView;
@end

@implementation SeetingCenterTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.textColor = [MyController colorWithHexString:@"4d4d4d"];
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-30);
    }];
    
    self.rIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.rIV];
    
    [self.rIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    self.lineView = [MyController viewWithFrame:self.contentView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(14);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(SeetingCenterModel *)model{
    self.titleLable.text = model._title;
}

@end
