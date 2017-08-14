
//
//  Index1TableViewCell.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "Index1TableViewCell.h"

#import "Index1Model.h"
@interface Index1TableViewCell(){
//    UIPageControl * pageCtl;
}
@property (nonatomic, strong) UIScrollView* sc;
@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;

@end
@implementation Index1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.sc = [[UIScrollView alloc] init];
    self.sc.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sc];
    
    [self.sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(8);
        make.height.mas_offset([MyController getScreenWidth] / 2);
        make.width.mas_offset([MyController getScreenWidth]);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView0];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.sc.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineView0.mas_bottom);
        make.height.mas_offset(10);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(Index1Model *)model{
    //一页一页的翻页
    self.sc.pagingEnabled = YES;
    //额外空间
    self.sc.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //锁定
    self.sc.directionalLockEnabled = YES;
    //偏移量
    self.sc.contentOffset = CGPointMake(0, 0);
    //反弹效果
    self.sc.bounces = NO;
    //水平方向保持反弹
    self.sc.alwaysBounceHorizontal = YES;
    self.sc.alwaysBounceVertical = NO;
    //开启滑动
    self.sc.scrollEnabled = YES;
    //显示水平状态条
    self.sc.showsHorizontalScrollIndicator = NO;
    //显示垂直
    self.sc.showsVerticalScrollIndicator = NO;
    self.sc.delegate = self;
    //向上取整
    long int pagNum = ceilf((float)model.hangyeIdArr.count / 8);
    self.sc.contentSize=CGSizeMake([MyController getScreenWidth] * pagNum, [MyController getScreenWidth] / 2);
    self.sc.tag=345;
    self.sc.pagingEnabled=YES;
    float viewWidth = [MyController getScreenWidth] / 4;
    int imageWidth = 40;
    for (int i = 0; i < pagNum; i++) {
        UIView* bgView = [MyController viewWithFrame:CGRectMake([MyController getScreenWidth] * i, 0, [MyController getScreenWidth], ([MyController getScreenWidth]) / 2)];
        if (i < pagNum - 1) {
            for (int k = 0; k < 8; k++) {
                NSLog(@"cell=====%@",model.hangyeNameArr[i * 8 + k]);
                UIImageView* _imageV = [MyController createImageViewWithFrame:CGRectMake(viewWidth * (k % 4) + (viewWidth - imageWidth) / 2, 5 + (k / 4) * viewWidth, imageWidth, imageWidth) ImageName:nil];
                [_imageV sd_setImageWithURL:[NSURL URLWithString:model.hangyeImgArr[i * 8 + k]] placeholderImage:[UIImage imageNamed:@""]];
                [bgView addSubview:_imageV];
                
                UILabel* titleLable = [MyController createLabelWithFrame:CGRectMake(viewWidth * (k % 4), CGRectGetMaxY(_imageV.frame), viewWidth, 20) Font:12 Text:model.hangyeNameArr[i * 8 + k]];
                titleLable.textAlignment = NSTextAlignmentCenter;
                [bgView addSubview:titleLable];
                
                UIButton* seleBtn = [MyController createButtonWithFrame:CGRectMake(viewWidth * (k % 4), viewWidth * (k / 4), viewWidth, viewWidth) ImageName:nil Target:self Action:@selector(seleBtnClick:) Title:nil];
                seleBtn.tag = 100 + i * 8 + k;
                [bgView addSubview:seleBtn];
            }
        }else{
            for (int k = 0; k < model.hangyeImgArr.count % 8; k++) {
                NSLog(@"cell=====%@",model.hangyeNameArr[i * 8 + k]);
                UIImageView* _imageV = [MyController createImageViewWithFrame:CGRectMake(viewWidth * (k % 4) + (viewWidth - imageWidth) / 2, 5 + (k / 4) * viewWidth, imageWidth, imageWidth) ImageName:nil];
                [_imageV sd_setImageWithURL:[NSURL URLWithString:model.hangyeImgArr[i * 8 + k]] placeholderImage:[UIImage imageNamed:@""]];
                [bgView addSubview:_imageV];
                
                UILabel* titleLable = [MyController createLabelWithFrame:CGRectMake(viewWidth * (k % 4), CGRectGetMaxY(_imageV.frame), viewWidth, 20) Font:12 Text:model.hangyeNameArr[i * 8 + k]];
                titleLable.textAlignment = NSTextAlignmentCenter;
                [bgView addSubview:titleLable];
                
                UIButton* seleBtn = [MyController createButtonWithFrame:CGRectMake(viewWidth * (k % 4), viewWidth * (k / 4), viewWidth, viewWidth) ImageName:nil Target:self Action:@selector(seleBtnClick:) Title:nil];
                seleBtn.tag = 100 + i * 8 + k;
                [bgView addSubview:seleBtn];
            }
        }
        
        
        [self.sc addSubview:bgView];
    }
}

#pragma  mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView.subviews objectAtIndex:scrollView.contentOffset.x / [MyController getScreenWidth]];
}
#pragma  mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //通过换算来计算是哪一页图片，然后将计算后的数字，赋给页码指示器
//    pageCtl.currentPage = self.sc.contentOffset.x / [MyController getScreenWidth];
//    if ([MyController isIOS7]) {
//        [pageCtl tintColorDidChange];
//    }
}
#pragma  mark - 按钮响应
- (void)seleBtnClick:(UIButton*)btn{
    [self.Index1TableViewCellDelegate sendBanckSeleCalssIndex:btn.tag];
}
@end
