//
//  CLView.h
//  E展汇
//
//  Created by lingnet on 16/1/22.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^RRBlock)(NSInteger index);


@interface CLView : UIView


/*
 *  为actionsheet上小视图
 *  按照 高度120（90（按钮60*60）+30）来设计
 */



@property (nonatomic,strong) UIButton *sheetBtn;

@property (nonatomic,strong) UILabel *sheetLab;


@property (nonatomic,copy) RRBlock block;


- (void)selectedIndex:(RRBlock)block;

@end
