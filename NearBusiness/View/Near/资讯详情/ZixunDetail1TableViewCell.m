//
//  ZixunDetail1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ZixunDetail1TableViewCell.h"

#import "ZixunDetailModel.h"
@interface ZixunDetail1TableViewCell()

@property (nonatomic, strong) UILabel* comLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* comBgView;
@end

@implementation ZixunDetail1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}

- (void)makeUI{
    self.comBgView = [MyController viewWithFrame:self.contentView.frame];
    self.comBgView.backgroundColor = [MyController colorWithHexString:@"f4f4f4"];
    //将图层的边框设置为圆脚
//    self.comBgView.layer.cornerRadius = 6;
//    self.comBgView.layer.masksToBounds = YES;
//    [self.comBgView setContentMode:UIViewContentModeScaleAspectFill];
//    self.comBgView.clipsToBounds = YES;
    [self.contentView addSubview:self.comBgView];
    
    [self.comBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(69);
        make.right.mas_equalTo(-10);
    }];
    
    self.comLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.comLable.textColor = [MyController colorWithHexString:@"b2b2b2"];
    self.comLable.numberOfLines = 0;
    [self.comBgView addSubview:self.comLable];
    
    [self.comLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
    }];
    
    self.lineView = [MyController viewWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.comBgView.mas_bottom).mas_offset(0);
        make.height.mas_offset(0.0);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(ZixunDetailModel *)model{
    
    self.comLable.text = model._replyContent;
    
    [self.comBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(69);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.comLable.mas_bottom).mas_offset(9);
    }];
    
    if (model.isLast) {
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.comBgView.mas_bottom).mas_offset(15);
            make.height.mas_offset(0.5);
        }];
        self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    }else{
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.comBgView.mas_bottom);
            make.height.mas_offset(0);
        }];
        self.lineView.backgroundColor = [UIColor clearColor];
    }
}

@end
