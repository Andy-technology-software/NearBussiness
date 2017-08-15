//
//  BussinessSearchTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BussinessSearchTableViewCell.h"

#import "BussinessSearchModel.h"
@interface BussinessSearchTableViewCell(){
    //    UIPageControl * pageCtl;
}
@property (nonatomic, strong) UIImageView* leftIV;
@property (nonatomic, strong) UIImageView* redPackIV;
@property (nonatomic, strong) UIImageView* zhuyingIV;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* zhuyingLable;
@property (nonatomic, strong) UILabel* distanceLable;
@property (nonatomic, strong) UILabel* telLable;
@property (nonatomic, strong) UILabel* addressLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;

@end
@implementation BussinessSearchTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(6);
    }];
    
    self.leftIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.leftIV];
    
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(14);
        make.height.mas_offset(76);
        make.width.mas_offset(95);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(10);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.leftIV);
    }];
    
    self.redPackIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    self.redPackIV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.redPackIV];
    
    [self.redPackIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.nameLable);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.zhuyingIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    self.zhuyingIV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.zhuyingIV];
    
    [self.zhuyingIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(7);
        make.height.mas_offset(12);
        make.width.mas_offset(12);
    }];
    
    self.zhuyingLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.zhuyingLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.zhuyingLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.zhuyingLable];
    
    [self.zhuyingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zhuyingIV.mas_right).mas_offset(3);
        make.right.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.zhuyingIV);
    }];
    
    self.distanceLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.distanceLable.textAlignment = NSTextAlignmentRight;
    self.distanceLable.textColor = [MyController colorWithHexString:@"9f9f9f"];
    [self.contentView addSubview:self.distanceLable];
    
    [self.distanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.redPackIV);
        make.top.mas_equalTo(self.zhuyingLable);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zhuyingIV);
        make.right.mas_equalTo(self.distanceLable);
        make.top.mas_equalTo(self.zhuyingIV.mas_bottom).mas_offset(6);
        make.height.mas_offset(0.5);
    }];
    
    self.telLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.telLable.numberOfLines = 1;
    self.telLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView1);
        make.right.mas_equalTo(self.lineView1);
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(4);
    }];
    
    self.addressLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.addressLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.addressLable.textColor = [MyController colorWithHexString:SUBTITLECOLOR];
    [self.contentView addSubview:self.addressLable];
    
    [self.addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable);
        make.right.mas_equalTo(self.telLable);
        make.top.mas_equalTo(self.telLable.mas_bottom).mas_offset(4);
        make.height.mas_offset(12);
    }];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(14);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView2;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(BussinessSearchModel *)model {
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLable.text = model.name;
    
    self.zhuyingLable.text = [NSString stringWithFormat:@"主营业务：%@",model.zhuying];
    
    self.distanceLable.text = model.distance;
    
    self.telLable.text = [NSString stringWithFormat:@"电话：%@",model.tel];
    
    self.addressLable.text = [NSString stringWithFormat:@"地址：%@",model.address];
}


@end
