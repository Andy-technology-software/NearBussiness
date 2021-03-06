//
//  CLAnimationView.h
//  E展汇
//
//  Created by lingnet on 16/1/22.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import <UIKit/UIKit.h>

//选择位置
typedef void (^CLBlock)(NSInteger index);

//选择按钮
typedef void(^CLBtnBlock)(UIButton *btn);


@interface CLAnimationView : UIView


@property (nonatomic,copy) CLBlock block;

@property (nonatomic,copy) CLBtnBlock btnBlock;
/**
 *  初始化动画视图
 *
 *  @param titlearray title数组
 ＊ @param picarray    图标数组
 */


- (id)initWithTitleArray:(NSArray *)titlearray  picarray:(NSArray *)picarray;


/*
 *  视图展示
 */
- (void)show;

/*
 * 选中的index
 */

- (void)selectedWithIndex:(CLBlock)block;

/*
 *  按钮block
 */

- (void)CLBtnBlock:(CLBtnBlock)block;

@end
