//
//  MineIndex0TableViewCell.h
//  ZKApp
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineIndex0Model;
@protocol MineIndex0TableViewCellDelegate <NSObject>
- (void)didselectHeadImg;
- (void)didselectBuycar;
- (void)sendBackBottonIndex:(NSInteger)itemIndex;
- (void)sendBackTopIndex:(NSInteger)itemIndex;
@end
@interface MineIndex0TableViewCell : UITableViewCell
- (void)configCellWithModel:(MineIndex0Model *)model;
@property(nonatomic,weak)id<MineIndex0TableViewCellDelegate>MineIndex0TableViewCellDelegate;

@end
