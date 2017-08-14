
//
//  BussinessRecommendationTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BussinessRecommendationTableViewCell.h"

#import "BussinessRecommendationModel.h"
@interface BussinessRecommendationTableViewCell(){
    //    UIPageControl * pageCtl;
}
@property (nonatomic, strong) UIImageView* leftIV;
@property (nonatomic, strong) UIImageView* redPackIV;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* distanceLable;

@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;

@end
@implementation BussinessRecommendationTableViewCell

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
        make.top.mas_equalTo(15);
        make.height.mas_offset(60);
        make.width.mas_offset(80);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIV.mas_right).mas_offset(6);
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
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.numberOfLines = 2;
    self.desLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(self.redPackIV);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(6);
    }];
    
    self.distanceLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.distanceLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.distanceLable];
    
    [self.distanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.desLable);
        make.top.mas_equalTo(self.desLable.mas_bottom).mas_offset(5);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.leftIV.mas_bottom).mas_offset(20);
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
- (void)configCellWithModel:(BussinessRecommendationModel *)model {
    [self.leftIV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLable.text = model.name;
    
    self.desLable.text = model.des;
    
    self.distanceLable.text = model.distance;
}


@end
