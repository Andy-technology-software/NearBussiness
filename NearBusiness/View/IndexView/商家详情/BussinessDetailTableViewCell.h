//
//  BussinessDetailTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexModel;
@protocol BussinessDetailTableViewCellDelegate <NSObject>
- (void)didselectADPic:(NSInteger)index;
@end
@interface BussinessDetailTableViewCell : UITableViewCell
@property(nonatomic,weak)id<BussinessDetailTableViewCellDelegate>BussinessDetailTableViewCellDelegate;
@property(nonatomic,strong) NSMutableArray* picArr;
- (void)configCellWithModel:(IndexModel *)model;
@end
