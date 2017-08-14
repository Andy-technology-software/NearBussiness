//
//  GoodsListModel.h
//  ZKApp
//
//  Created by lingnet on 2017/1/19.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListModel : NSObject
@property(nonatomic,copy)NSString* headImageStr;
@property(nonatomic,copy)NSString* titleNameStr;
@property(nonatomic,copy)NSString* addressStr;
@property(nonatomic,copy)NSString* timeStr;
@property(nonatomic,copy)NSString* jifenStr;
@property(nonatomic,copy)NSString* shichangjiaStr;
@property(nonatomic,copy)NSString* idStr;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
