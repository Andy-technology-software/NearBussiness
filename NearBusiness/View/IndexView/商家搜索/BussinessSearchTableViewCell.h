//
//  BussinessSearchTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BussinessSearchModel;

@interface BussinessSearchTableViewCell : UITableViewCell
- (void)configCellWithModel:(BussinessSearchModel *)model;

@end
