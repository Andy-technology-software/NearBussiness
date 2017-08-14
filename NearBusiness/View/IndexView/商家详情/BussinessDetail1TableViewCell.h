//
//  BussinessDetail1TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BussinessDetail1Model;
@protocol BussinessDetail1TableViewCellDelegate <NSObject>
- (void)didselectTel;
@end
@interface BussinessDetail1TableViewCell : UITableViewCell
- (void)configCellWithModel:(BussinessDetail1Model *)model;
@property(nonatomic,weak)id<BussinessDetail1TableViewCellDelegate>BussinessDetail1TableViewCellDelegate;

@end
