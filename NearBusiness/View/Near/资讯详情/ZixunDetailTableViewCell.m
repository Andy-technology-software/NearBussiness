//
//  ZixunDetailTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ZixunDetailTableViewCell.h"

#import "ZixunDetailModel.h"
@interface ZixunDetailTableViewCell()

@property (nonatomic, strong) UIImageView* headIV;

@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* timeLable;
@end
@implementation ZixunDetailTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.headIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    //将图层的边框设置为圆脚
    self.headIV.layer.cornerRadius = 45/2;
    self.headIV.layer.masksToBounds = YES;
    [self.headIV setContentMode:UIViewContentModeScaleAspectFill];
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(10);
        make.width.mas_offset(45);
        make.height.mas_offset(45);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.timeLable.textColor = [MyController colorWithHexString:@"b2b2b2"];
    [self.contentView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.width.mas_offset(40);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    self.nameLable.numberOfLines = 0;
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(self.timeLable.mas_left).mas_offset(-2);
        make.left.mas_equalTo(self.headIV.mas_right).mas_offset(14);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.textColor = [MyController colorWithHexString:@"b2b2b2"];
    self.desLable.numberOfLines = 0;
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(8);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.nameLable);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.desLable;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(ZixunDetailModel *)model{
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model._headImg] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLable.text = model._name;
    
    self.desLable.text = model._des;
    
    self.timeLable.text = model._time;
}

@end
