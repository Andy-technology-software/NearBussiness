//
//  GoodsListCell.h
//  ZKApp
//
//  Created by lingnet on 2017/1/19.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListModel;
@interface GoodsListCell : UITableViewCell
- (void)configCellWithModel:(GoodsListModel *)model;

@end
