//
//  LoginTableViewCell.h
//  NearBusiness
//
//  Created by 徐仁强 on 2017/8/20.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginAndRegistModel;
@protocol LoginTableViewCellDelegate <NSObject>
- (void)login;
- (void)regist;
- (void)forgetPW;
@end
@interface LoginTableViewCell : UITableViewCell
- (void)configCellWithModel:(LoginAndRegistModel *)model;
@property(nonatomic,weak)id<LoginTableViewCellDelegate>LoginTableViewCellDelegate;
@end
