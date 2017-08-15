//
//  ProductDetails1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ProductDetails1TableViewCell.h"

#import "ProductDetails1Model.h"
@interface ProductDetails1TableViewCell()
@property (nonatomic, strong) UILabel* guigeLable;
@property (nonatomic, strong) UILabel* jianjieLable;

@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIButton* telBtn;
@end
@implementation ProductDetails1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.guigeLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.guigeLable.numberOfLines = 0;
    self.guigeLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.guigeLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.guigeLable];
    
    [self.guigeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
    }];
    
    self.jianjieLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
    self.jianjieLable.numberOfLines = 0;
    self.jianjieLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.jianjieLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.jianjieLable];
    
    [self.jianjieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.guigeLable);
        make.right.mas_equalTo(self.guigeLable);
        make.top.mas_equalTo(self.guigeLable.mas_bottom).mas_offset(15);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.jianjieLable.mas_bottom).mas_offset(15);
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
- (void)configCellWithModel:(ProductDetails1Model *)model {
    self.guigeLable.text = [NSString stringWithFormat:@"规格：%@",model._specification];
    [MyController fuwenbenLabel:self.guigeLable FontNumber:[UIFont systemFontOfSize:12] AndRange:NSMakeRange(3, self.guigeLable.text.length - 3) AndColor:[MyController colorWithHexString:TITLECOLOR]];
    
    self.jianjieLable.text = [NSString stringWithFormat:@"简介：%@",model._introduction];
    [MyController fuwenbenLabel:self.jianjieLable FontNumber:[UIFont systemFontOfSize:12] AndRange:NSMakeRange(3, self.jianjieLable.text.length - 3) AndColor:[MyController colorWithHexString:TITLECOLOR]];
}


@end
