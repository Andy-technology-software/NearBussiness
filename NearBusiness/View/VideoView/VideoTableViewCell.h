//
//  VideoTableViewCell.h
//  AndyNewFram
//
//  Created by lingnet on 2017/4/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@interface VideoTableViewCell : UITableViewCell
- (void)configCellWithModel:(VideoModel *)model;

@end
