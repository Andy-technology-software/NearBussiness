//
//  OrderDaishouTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderYi1Model;
@protocol OrderDaishouTableViewCellDelegate <NSObject>
- (void)didselectCheckWL:(NSInteger)sectionIndex;
- (void)didselectMakesure:(NSInteger)sectionIndex;
@end

@interface OrderDaishouTableViewCell : UITableViewCell
- (void)configCellWithModel:(OrderYi1Model *)model;
@property(nonatomic,weak)id<OrderDaishouTableViewCellDelegate>OrderDaishouTableViewCellDelegate;
@property(nonatomic,assign)NSInteger sectionIndex;
@end
