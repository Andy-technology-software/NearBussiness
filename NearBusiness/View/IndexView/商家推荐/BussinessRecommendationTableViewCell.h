//
//  BussinessRecommendationTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BussinessRecommendationModel;
@interface BussinessRecommendationTableViewCell : UITableViewCell
- (void)configCellWithModel:(BussinessRecommendationModel *)model;

@end
