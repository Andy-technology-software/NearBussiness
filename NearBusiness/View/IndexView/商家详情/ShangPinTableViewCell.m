
//
//  ShangPinTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ShangPinTableViewCell.h"

#import "ShangPinModel.h"
@interface ShangPinTableViewCell(){
    //    UIPageControl * pageCtl;
}
@property (nonatomic, strong) UIImageView* leftIV;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* priceLable;

@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;

@end
@implementation ShangPinTableViewCell

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
        make.top.mas_equalTo(10);
        make.height.mas_offset(78);
        make.width.mas_offset(96);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.titleLable.numberOfLines = 1;
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(8);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.leftIV);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.numberOfLines = 2;
    self.desLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.desLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(7);
    }];
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.priceLable.textColor = [MyController colorWithHexString:@"f05e50"];
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.desLable);
        make.right.mas_equalTo(self.desLable);
        make.top.mas_equalTo(self.desLable.mas_bottom).mas_offset(8);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView0.mas_bottom);
        make.height.mas_offset(5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(ShangPinModel *)model {
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model._image] placeholderImage:[UIImage imageNamed:@""]];
    
    self.titleLable.text = model._title;
    
    self.desLable.text = model._des;
    
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model._price];
}


@end
