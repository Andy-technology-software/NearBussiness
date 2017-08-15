//
//  ProductDetails2TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetails2Model;
@protocol ProductDetails2TableViewCellDelegate <NSObject>
- (void)didselectProPic:(NSInteger)index;
@end
@interface ProductDetails2TableViewCell : UITableViewCell
- (void)configCellWithModel:(ProductDetails2Model *)model;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,weak)id<ProductDetails2TableViewCellDelegate>ProductDetails2TableViewCellDelegate;

@end
