//
//  OrderYi2TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderYiModel;
@protocol OrderYi2TableViewCellDelegate <NSObject>

- (void)sendBackShop:(NSInteger)sectionItem;

@end
@interface OrderYi2TableViewCell : UITableViewCell
- (void)configCellWithModel:(OrderYiModel *)model;
@property(nonatomic,assign)NSInteger sectionItem;
@property(nonatomic,weak)id<OrderYi2TableViewCellDelegate>OrderYi2TableViewCellDelegate;

@end
