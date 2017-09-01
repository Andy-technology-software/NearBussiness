//
//  Regist1TableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistModel;
@protocol Regist1TableViewCellDelegate <NSObject>

- (void)sendbackRegist1Text:(NSString*)text indexRow:(NSInteger)indexRow;
- (void)sendbackRegistCode;

@end
@interface Regist1TableViewCell : UITableViewCell
- (void)configCellWithModel:(RegistModel *)model;
@property(nonatomic,assign)NSInteger indexRow;

@property(nonatomic,weak)id<Regist1TableViewCellDelegate>Regist1TableViewCellDelegate;
@end
