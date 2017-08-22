//
//  InfoTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/22.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZiXunModel;

@interface InfoTableViewCell : UITableViewCell

- (void)configCellWithModel:(ZiXunModel *)model;
@end
