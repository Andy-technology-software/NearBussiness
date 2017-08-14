//
//  VideoTableViewCell.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "VideoTableViewCell.h"

#import "VideoModel.h"

@interface VideoTableViewCell()
@property(nonatomic,strong)UILabel* nameLable;
@property(nonatomic,strong)UIView* lineView;
@end
@implementation VideoTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textColor = [MyController colorWithHexString:@"5f5f5f"];
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(60);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.nameLable.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(VideoModel *)model {
    self.nameLable.text = model.name;
}

@end
