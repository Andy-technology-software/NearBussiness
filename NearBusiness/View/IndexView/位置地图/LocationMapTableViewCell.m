//
//  LocationMapTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/30.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "LocationMapTableViewCell.h"

#import "LocationMapModel.h"
@interface LocationMapTableViewCell()
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* rnameLable;

@property (nonatomic, strong) UIImageView* duiImageview;

@end
@implementation LocationMapTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    
    self.nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLable];
    self.nameLable.numberOfLines = 0;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.right.mas_equalTo(-19);
        make.top.mas_equalTo(19);
    }];
    
//    self.rnameLable = [[UILabel alloc] init];
//    [self.bgView addSubview:self.rnameLable];
//    self.rnameLable.numberOfLines = 1;
//    self.rnameLable.textColor = [MyController colorWithHexString:@"81889d"];
//    self.rnameLable.font = [UIFont systemFontOfSize:12];
//    
//    [self.rnameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.nameLable);
//        make.right.mas_equalTo(self.nameLable);
//        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(5);
//    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-9);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(19);
    }];
    
    self.duiImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.duiImageview];
    
    [self.duiImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(16);
        make.height.mas_offset(16);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(LocationMapModel *)model{
    self.nameLable.text = model.name;
//    self.rnameLable.text = model.rname;
    if (model.isSelect) {
        self.duiImageview.image = [UIImage imageNamed:@"duihao"];
    }else{
        self.duiImageview.image = [UIImage imageNamed:@""];
    }
}
@end
