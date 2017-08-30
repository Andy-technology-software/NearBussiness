//
//  CLView.m
//  E展汇
//
//  Created by lingnet on 16/1/22.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import "CLView.h"

@implementation CLView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sheetBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 15, 0, 30, 30)];
//        self.sheetBtn.backgroundColor = [UIColor redColor];
        self.sheetBtn.clipsToBounds = YES;
        self.sheetBtn.layer.cornerRadius = 15;
//        [self.sheetBtn setCenter:CGPointMake(self.frame.size.width / 2, 80)];
        
        self.sheetLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sheetBtn.frame) + 2, [MyController getScreenWidth]/3, 16)];
        [self addSubview:self.sheetLab];
        self.sheetLab.textAlignment = NSTextAlignmentCenter;
        [self.sheetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.sheetLab setTextAlignment:NSTextAlignmentCenter];
        self.sheetLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.sheetBtn];
        
    }
    return self;
}


- (void)btnClick:(UIButton *)btn
{
    self.block(self.sheetBtn.tag);
}

- (void)selectedIndex:(RRBlock)block
{
    self.block = block;
}




@end
