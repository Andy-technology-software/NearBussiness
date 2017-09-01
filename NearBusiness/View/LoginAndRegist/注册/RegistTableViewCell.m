//
//  RegistTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "RegistTableViewCell.h"

#import "RegistModel.h"
@interface RegistTableViewCell()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField* rTf;

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation RegistTableViewCell

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
        make.width.mas_offset(65);
        make.height.mas_offset(20);
    }];
    
    self.rTf = [MyController createTextFieldWithFrame:self.contentView.frame placeholder:nil passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.rTf.delegate = self;
    [self.contentView addSubview:self.rTf];
    
    [self.rTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(self.titleLable.mas_right);
        make.top.mas_equalTo(self.titleLable);
        make.height.mas_equalTo(self.titleLable);
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.RegistTableViewCellDelegate sendbackRegistText:textField.text indexRow:self.indexRow];
}

- (void)configCellWithModel:(RegistModel *)model{
    self.titleLable.text = model._lableText;
    self.rTf.placeholder = model._placeText;
    self.rTf.text = model._tfText;
}

@end
