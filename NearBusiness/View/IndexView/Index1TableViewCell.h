//
//  Index1TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Index1Model;
@protocol Index1TableViewCellDelegate <NSObject>
- (void)sendBanckSeleCalssIndex:(NSInteger)classIndex;
@end
@interface Index1TableViewCell : UITableViewCell
- (void)configCellWithModel:(Index1Model *)model;
@property(nonatomic,weak)id<Index1TableViewCellDelegate>Index1TableViewCellDelegate;
@end
