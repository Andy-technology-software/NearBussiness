//
//  OrderDaiTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderYi1Model;
@protocol OrderDaiTableViewCellDelegate <NSObject>
- (void)didselectPay:(NSInteger)sectionIndex;
- (void)didselectCancel:(NSInteger)sectionIndex;
@end

@interface OrderDaiTableViewCell : UITableViewCell
- (void)configCellWithModel:(OrderYi1Model *)model;
@property(nonatomic,weak)id<OrderDaiTableViewCellDelegate>OrderDaiTableViewCellDelegate;
@property(nonatomic,assign)NSInteger sectionIndex;
@end
