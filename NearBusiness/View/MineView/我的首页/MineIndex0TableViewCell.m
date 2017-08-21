//
//  MineIndex0TableViewCell.m
//  ZKApp
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "MineIndex0TableViewCell.h"

#import "MineIndex0Model.h"

@interface MineIndex0TableViewCell()
@property (nonatomic,strong) UILabel* nameLable;
@property (nonatomic,strong) UILabel* telLable;

@property (nonatomic,strong) UIImageView* headIV;
@property (nonatomic,strong) UIImageView* bgHeadIV;
@property (nonatomic,strong) UIImageView* VIPIV;

@property (nonatomic,strong) UIButton* headBtn;

@property (nonatomic,strong) UIView* btnView;
@property (nonatomic,strong) UIView* bottomView;

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;
@property (nonatomic, strong) UIView* lineView3;
@property (nonatomic, strong) UIView* lineView4;
@property (nonatomic, strong) UIView* lineView5;

@property (nonatomic, strong) UIButton* buyCarBtn;
@property (nonatomic, strong) UIButton* buyCarBtn1;
@end
@implementation MineIndex0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:@"f55d62"];
    
    self.bgHeadIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    [self.contentView addSubview:self.bgHeadIV];
    
    [self.bgHeadIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    self.headIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:nil];
    //将图层的边框设置为圆脚
    self.headIV.layer.cornerRadius = 40;
    self.headIV.layer.masksToBounds = YES;
    [self.headIV setContentMode:UIViewContentModeScaleAspectFill];
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
    
    self.headBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(headBtnClick) Title:nil];
    //    self.shareBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.headBtn];
    
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headIV);
        make.centerX.mas_equalTo(self.headIV);
        make.width.mas_equalTo(self.headIV);
        make.height.mas_equalTo(self.headIV);
    }];
    
    self.buyCarBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:@"shijian" Target:self Action:@selector(buyCarBtnClick) Title:nil];
    [self.contentView addSubview:self.buyCarBtn];
    
    [self.buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headIV);
        make.right.mas_equalTo(-10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    self.buyCarBtn1 = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(buyCarBtnClick) Title:nil];
    [self.contentView addSubview:self.buyCarBtn1];
    
    [self.buyCarBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headIV).mas_offset(-10);
        make.right.mas_equalTo(0);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:nil];
    self.nameLable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headIV.mas_bottom).mas_offset(12);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    
    self.VIPIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.VIPIV];
    
    [self.VIPIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLable);
        make.left.mas_equalTo(self.nameLable.mas_right).mas_offset(4);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    
    self.telLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:nil];
    self.telLable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.telLable];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(8);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.telLable.mas_bottom).mas_offset(20);
        make.height.mas_offset(8);
    }];
    
    
    self.btnView = [MyController viewWithFrame:self.contentView.frame];
    self.btnView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.btnView];
    
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_offset(190/2);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.btnView.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView1.mas_bottom);
        make.height.mas_offset(5);
    }];
    
    self.bottomView = [MyController viewWithFrame:self.contentView.frame];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView2.mas_bottom);
        make.height.mas_offset([MyController getScreenWidth]*3/8);
    }];
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.bottomView addSubview:self.lineView3];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView4 = [[UIView alloc] init];
    self.lineView4.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.bottomView addSubview:self.lineView4];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.width.mas_offset(0.5);
    }];
    
    self.lineView5 = [[UIView alloc] init];
    self.lineView5.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView5];
    
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bottomView.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView5;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(MineIndex0Model *)model {
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model._img] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLable.text = model._name;
    self.telLable.text = model._tel;
//    [self.bgHeadIV setImage:[MyController blurryImage:self.headIV.image withBlurLevel:0.5]];
    
    float viewWidth = [MyController getScreenWidth] / 4;
    NSArray* tA = [[NSArray alloc] initWithObjects:@"我的店铺",@"我的发布",@"我的订单",@"我的收藏", nil];
    for (int i = 0; i < 4; i++) {
        UIView* _imageView = [MyController viewWithFrame:CGRectMake(viewWidth*i, 0, viewWidth, 85)];
        [self.btnView addSubview:_imageView];
        
        UIImageView* _imageV = [MyController createImageViewWithFrame:CGRectMake((viewWidth - 45)/2, 10, 45, 45) ImageName:@"shijian"];
        [_imageView addSubview:_imageV];
        
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(_imageV.frame) + 4, viewWidth, 20) Font:12 Text:tA[i]];
        titLable.textAlignment = NSTextAlignmentCenter;
        [_imageView addSubview:titLable];
        
        UIButton* clickB = [MyController createButtonWithFrame:_imageView.frame ImageName:nil Target:self Action:@selector(clickBClick:) Title:nil];
        clickB.tag = 100 + i;
        [self.btnView addSubview:clickB];
    }
    
    float bviewWidth = [MyController getScreenWidth] / 2;
    float bviewHeight = [MyController getScreenWidth]*3/8/2;
    NSArray* tB = [[NSArray alloc] initWithObjects:@"资金管理",@"通讯录",@"设置中心",@"联系我们", nil];
    
    for (int i = 0; i < 4; i++) {
        UIView* bView = [MyController viewWithFrame:CGRectMake((i % 2) * bviewWidth, (i / 2) * bviewHeight, bviewWidth, bviewHeight)];
        [self.bottomView addSubview:bView];
        
        UILabel* tiL = [MyController createLabelWithFrame:bView.frame Font:14 Text:@"资金管理"];
        [bView addSubview:tiL];
        
        [tiL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bView.mas_centerY);
            make.centerX.mas_equalTo(bView.mas_centerX).mas_offset(12);
        }];
        
        UIImageView* tIV = [MyController createImageViewWithFrame:bView.frame ImageName:@"shijian"];
        [bView addSubview:tIV];
        
        [tIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bView.mas_centerY);
            make.right.mas_equalTo(tiL.mas_left).mas_offset(-5);
        }];
        
        UIButton* bBtn = [MyController createButtonWithFrame:bView.frame ImageName:nil Target:self Action:@selector(bBtnClick:) Title:nil];
        bBtn.tag = 900 + i;
        [self.bottomView addSubview:bBtn];
    }
}

- (void)clickBClick:(UIButton*)btn{
    [self.MineIndex0TableViewCellDelegate sendBackTopIndex:btn.tag - 100];
}

- (void)bBtnClick:(UIButton*)btn{
    [self.MineIndex0TableViewCellDelegate sendBackBottonIndex:btn.tag - 900];
}

- (void)headBtnClick{
    [self.MineIndex0TableViewCellDelegate didselectHeadImg];
}

- (void)buyCarBtnClick{
    [self.MineIndex0TableViewCellDelegate didselectBuycar];
}
@end
