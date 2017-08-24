//
//  OrderYi1TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/23.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderYi1Model;
@protocol OrderYi1TableViewCellDelegate <NSObject>
- (void)didselectCom:(NSInteger)sectionIndex;
@end
@interface OrderYi1TableViewCell : UITableViewCell
- (void)configCellWithModel:(OrderYi1Model *)model;
@property(nonatomic,weak)id<OrderYi1TableViewCellDelegate>OrderYi1TableViewCellDelegate;
@property(nonatomic,assign)NSInteger sectionIndex;
@end
