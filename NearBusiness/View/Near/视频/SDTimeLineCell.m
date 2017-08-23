//
//  SDTimeLineCell.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "SDTimeLineCell.h"

#import "SDTimeLineCellModel.h"

#import "SDWeiXinPhotoContainerView.h"
CGFloat maxContentLabelHeight = 0; // 根据具体font而定
@implementation SDTimeLineCell{
    UIView* _topLineView;
    UIView* _bottomLineView;
    UIImageView *_redPackImageView;
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIImageView *_videoImageView;
    UIButton *_videoButton;
    UIImageView *_timeImageView;
    UILabel *_timeLabel;
    UIButton *_moreButton;
    UILabel *_commentLabel;
    UIImageView *_commentImageView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    self.contentView.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:@"SDTimeLineCell" object:nil];
    
    _topLineView = [UIView new];
    _topLineView.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    _iconView = [UIImageView new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = [MyController colorWithHexString:TITLECOLOR];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [MyController colorWithHexString:@"797979"];
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    _redPackImageView = [UIImageView new];
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _commentImageView = [UIImageView new];
    _commentImageView.image = [UIImage imageNamed:@"shijian"];
    
    _commentLabel = [UILabel new];
    _commentLabel.font = [UIFont systemFontOfSize:12];
    _commentLabel.textColor = [MyController colorWithHexString:@"888888"];
    
    _videoImageView = [UIImageView new];
    
    _videoButton = [MyController createButtonWithFrame:self.contentView.frame ImageName:@"视频" Target:self Action:@selector(_videoButtonClick) Title:nil];
    
    _timeImageView = [UIImageView new];
    _timeImageView.image = [UIImage imageNamed:@"shijian"];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [MyController colorWithHexString:@"888888"];

    _bottomLineView = [UIView new];
    _bottomLineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    
    NSArray *views = @[_topLineView, _iconView, _nameLable, _redPackImageView, _contentLabel, _moreButton, _videoImageView, _videoButton, _timeImageView, _timeLabel, _commentLabel, _commentImageView, _bottomLineView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    _topLineView.sd_layout
    .leftSpaceToView(contentView,0)
    .rightSpaceToView(contentView,0)
    .topSpaceToView(contentView, 0)
    .heightIs(5);
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, 10)
    .topSpaceToView(_topLineView, 10)
    .widthIs(60)
    .heightIs(60);
    //将图层的边框设置为圆脚
    _iconView.layer.cornerRadius = 30;
    _iconView.layer.masksToBounds = YES;
    [_iconView setContentMode:UIViewContentModeScaleAspectFill];
    _iconView.clipsToBounds = YES;
    
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, 15)
    .topEqualToView(_iconView)
    .rightSpaceToView(contentView, 30);
    _nameLable.numberOfLines = 0;
    
    _redPackImageView.sd_layout
    .rightSpaceToView(contentView, 10)
    .topEqualToView(_nameLable)
    .widthIs(15)
    .heightIs(15);
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, 10)
    .rightSpaceToView(contentView, 10)
    .autoHeightRatio(0);
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    
    _videoImageView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_moreButton, 10)
    .widthIs(100)
    .heightIs(100);
    
    _videoButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_moreButton, 10)
    .widthIs(100)
    .heightIs(100);
    
    _timeImageView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_videoImageView, 10)
    .heightIs(15)
    .widthIs(15);
    
    
    _timeLabel.sd_layout
    .leftSpaceToView(_timeImageView, 3)
    .topEqualToView(_timeImageView)
    .heightIs(15);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _commentLabel.sd_layout
    .rightSpaceToView(contentView, 10)
    .topSpaceToView(_videoImageView, 10)
    .heightIs(15);
    [_commentLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _commentImageView.sd_layout
    .rightSpaceToView(_commentLabel, 3)
    .topEqualToView(_timeImageView)
    .heightIs(15)
    .widthIs(15);
    
    _bottomLineView.sd_layout
    .leftSpaceToView(contentView,0)
    .rightSpaceToView(contentView,0)
    .topSpaceToView(_commentImageView, 15)
    .heightIs(0.5);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(SDTimeLineCellModel *)model{
//    _model = model;

    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLable.text = model.name;
    _contentLabel.text = model.msgContent;
    
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:model.videoImg] placeholderImage:[UIImage imageNamed:@"icon0.jpg"]];
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    
    UIView *bottomView;
    
    bottomView = _bottomLineView;
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
    
    _timeLabel.text = @"1分钟前";
    
    _redPackImageView.image = [UIImage imageNamed:@"shijian"];
    
    _commentLabel.text = @"2";
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
//    if (_operationMenu.isShowing) {
//        _operationMenu.show = NO;
//    }
}

#pragma mark - private actions

- (void)moreButtonClicked{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}

- (void)operationButtonClicked{
//    _operationMenu.show = !_operationMenu.isShowing;
}

- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification{
    UIButton *btn = [notification object];
    
//    if (btn != _operationButton && _operationMenu.isShowing) {
//        _operationMenu.show = NO;
//    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
//    if (_operationMenu.isShowing) {
//        _operationMenu.show = NO;
//    }
}

- (void)postOperationButtonClickedNotification
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:kSDTimeLineCellOperationButtonClickedNotification object:_operationButton];
}

- (void)_videoButtonClick{
    NSLog(@"放视频");
}


@end

