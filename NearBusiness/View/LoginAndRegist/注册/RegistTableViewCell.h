//
//  RegistTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegistModel;
@protocol RegistTableViewCellDelegate <NSObject>

- (void)sendbackRegistText:(NSString*)text indexRow:(NSInteger)indexRow;

@end
@interface RegistTableViewCell : UITableViewCell
- (void)configCellWithModel:(RegistModel *)model;
@property(nonatomic,assign)NSInteger indexRow;

@property(nonatomic,weak)id<RegistTableViewCellDelegate>RegistTableViewCellDelegate;
@end
