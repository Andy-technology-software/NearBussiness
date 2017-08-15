//
//  ProductDetails0TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetails0Model;
@protocol ProductDetails0TableViewCellDelegate <NSObject>
- (void)didselectADPic:(NSInteger)index;
- (void)didselectShare;
@end
@interface ProductDetails0TableViewCell : UITableViewCell
- (void)configCellWithModel:(ProductDetails0Model *)model;
@property(nonatomic,weak)id<ProductDetails0TableViewCellDelegate>ProductDetails0TableViewCellDelegate;

@end
