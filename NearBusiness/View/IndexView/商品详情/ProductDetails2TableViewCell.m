//
//  ProductDetails2TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ProductDetails2TableViewCell.h"

#import "ProductDetails2Model.h"
@interface ProductDetails2TableViewCell()
@property (nonatomic, strong) UILabel* desLable;

@property (nonatomic, strong) UIImageView* proIV;

@property (nonatomic, strong) UIButton* imageBtn;
@end
@implementation ProductDetails2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.proIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.proIV];
    
    [self.proIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.height.mas_offset([MyController getScreenWidth] / 2);
    }];
    
    self.imageBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(imageBtnClick) Title:nil];
    [self.contentView addSubview:self.imageBtn];
    
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.height.mas_offset([MyController getScreenWidth] / 2);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.numberOfLines = 0;
    self.desLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.desLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.proIV);
        make.right.mas_equalTo(self.proIV);
        make.top.mas_equalTo(self.proIV.mas_bottom).mas_offset(15);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.desLable;
    self.hyb_bottomOffsetToCell = 15;
}
- (void)configCellWithModel:(ProductDetails2Model *)model {
    [self.proIV sd_setImageWithURL:[NSURL URLWithString:model._image] placeholderImage:[UIImage imageNamed:@""]];
    
    self.desLable.text = model._des;
}

- (void)imageBtnClick{
    [self.ProductDetails2TableViewCellDelegate didselectProPic:self.cellIndex];
}

@end
