//
//  ZiXunTableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/21.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ZiXunTableViewCell.h"

#import "ZiXunModel.h"

#import "SDWeiXinPhotoContainerView.h"
@interface ZiXunTableViewCell()
@property (nonatomic, strong) UIImageView* headIV;
@property (nonatomic, strong) UIImageView* timeIV;
@property (nonatomic, strong) UIImageView* commentIV;
@property (nonatomic, strong) UIImageView* redPackIV;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* desLable;
@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UILabel* commentLable;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) SDWeiXinPhotoContainerView* picContainerView;
@end
@implementation ZiXunTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(5);
    }];
    
    self.headIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    //将图层的边框设置为圆脚
    self.headIV.layer.cornerRadius = 30;
    self.headIV.layer.masksToBounds = YES;
    [self.headIV setContentMode:UIViewContentModeScaleAspectFill];
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(10);
        make.height.mas_offset(60);
        make.width.mas_offset(60);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:nil];
//    self.nameLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLable.numberOfLines = 0;
    self.nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headIV.mas_right).mas_offset(12);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.headIV);
    }];
    
    self.redPackIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
//    self.redPackIV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.redPackIV];
    
    [self.redPackIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.nameLable);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.desLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.desLable.numberOfLines = 0;
    self.desLable.textColor = [MyController colorWithHexString:@"797979"];
    [self.contentView addSubview:self.desLable];
    
    [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(self.redPackIV);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(10);
    }];
    
     self.picContainerView = [[SDWeiXinPhotoContainerView alloc] initWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.picContainerView];
    
    [self.picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.desLable);
        make.right.mas_equalTo(self.desLable);
        make.top.mas_equalTo(self.desLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(100);
    }];
    
    self.timeIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.timeIV];
    
    [self.timeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.picContainerView);
        make.top.mas_equalTo(self.picContainerView.mas_bottom).mas_offset(10);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.timeLable.textColor = [MyController colorWithHexString:@"888888"];
    [self.contentView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeIV.mas_right).mas_offset(3);
        make.top.mas_equalTo(self.timeIV);
    }];
    
    self.commentLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.commentLable.textColor = [MyController colorWithHexString:@"888888"];
    [self.contentView addSubview:self.commentLable];
    
    [self.commentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.timeLable);
    }];
    
    self.commentIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.commentIV];
    
    [self.commentIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.commentLable.mas_left).mas_offset(-3);
        make.top.mas_equalTo(self.commentLable);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.commentLable.mas_bottom).mas_offset(15);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(ZiXunModel *)model {
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model._headImg] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLable.text = model._name;
    
    self.desLable.text = model._des;
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    
    self.picContainerView.picPathStringsArray = [[NSArray alloc] initWithObjects:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4277297124,5903202&fm=173&s=57F27ADA10000D5B8737221D0300C0DE&w=543&h=247&img.JPEG",@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3004953567,2595473912&fm=173&s=F9004F9E1FA26290D4FC587F0300D0F1&w=598&h=378&img.JPEG",@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3472407373,2955588891&fm=173&s=E0535F94450366E41AC001C50300F0F2&w=500&h=411&img.JPEG", nil];//model._imageArr;
    
    self.timeLable.text = model._time;
    
    self.commentLable.text = model._comment;
    
    if (model._isRed) {
        self.redPackIV.image = [UIImage imageNamed:@"shijian"];
    }else{
        self.redPackIV.image = [UIImage imageNamed:@""];
    }
}


@end
