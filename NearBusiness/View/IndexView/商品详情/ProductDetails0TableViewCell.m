//
//  ProductDetails0TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ProductDetails0TableViewCell.h"

#import "ProductDetails0Model.h"

@interface ProductDetails0TableViewCell()<CycleScrollViewDelegate>

@property (nonatomic,strong) CycleScrollView *cycleScrollView;
@property (nonatomic,strong) UILabel* titleLable;
@property (nonatomic,strong) UILabel* priceLable;
@property (nonatomic,strong) UILabel* shareLable;

@property (nonatomic,strong) UIImageView* shareIV;

@property (nonatomic,strong) UIButton* shareBtn;

@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;
@end
@implementation ProductDetails0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenWidth] * 15 / 32) imageURLStringsGroup:nil]; // 模拟网络延时情景
    [self.contentView addSubview:self.cycleScrollView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset([MyController getScreenWidth] * 15 / 32);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:nil];
    self.titleLable.numberOfLines = 0;
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    [self.contentView addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-55);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).mas_offset(13);
    }];
    
    self.shareLable = [MyController createLabelWithFrame:self.contentView.frame Font:12 Text:@"分享"];
    self.shareLable.textColor = [MyController colorWithHexString:@"b2b2b2"];
    self.shareLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.shareLable];
    
    [self.shareLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.titleLable);
    }];
    
    self.shareIV = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"shijian"];
    [self.contentView addSubview:self.shareIV];
    
    [self.shareIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shareLable.mas_left);
        make.top.mas_equalTo(self.shareLable);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    
    self.shareBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(shareBtnClick) Title:nil];
//    self.shareBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.shareBtn];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareIV.mas_left);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.bottom.mas_equalTo(self.shareLable.mas_bottom).mas_offset(10);
    }];
    
    self.priceLable = [MyController createLabelWithFrame:self.contentView.frame Font:16 Text:nil];
    self.priceLable.textColor = [MyController colorWithHexString:@"f05e50"];
    [self.contentView addSubview:self.priceLable];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(10);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.priceLable.mas_bottom).mas_offset(15);
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
- (void)configCellWithModel:(ProductDetails0Model *)model {
    NSLog(@"穿过来的数组-----%@",model._picArr);
    if (model._picArr.count) {
        self.cycleScrollView.pageControlAliment = CycleScrollViewPageContolAlimentCenter;
        self.cycleScrollView.pageControlStyle = CycleScrollViewPageContolStyleClassic;
        self.cycleScrollView.delegate = self;
        //        self.cycleScrollView.dotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
        //        self.cycleScrollView.indicatorDotColor = [UIColor whiteColor];
        self.cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
        self.cycleScrollView.autoScrollTimeInterval = 4.0;
        //        self.cycleScrollView.hidesForSinglePage = YES;
        self.cycleScrollView.imageURLStringsGroup = model._picArr;
        if (1 == model._picArr.count) {
            self.cycleScrollView.autoScroll = NO;
        }
    }
    
    self.titleLable.text = model._title;
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",model._price];
}
#pragma mark - 轮滚点击代理
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.ProductDetails0TableViewCellDelegate didselectADPic:index];
}

- (void)shareBtnClick{
    [self.ProductDetails0TableViewCellDelegate didselectShare];
}
@end
