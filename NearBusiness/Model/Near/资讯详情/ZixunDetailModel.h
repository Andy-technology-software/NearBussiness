//
//  ZixunDetailModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZixunDetailModel : NSObject
@property(nonatomic,copy)NSString* _headImg;
@property(nonatomic,copy)NSString* _name;
@property(nonatomic,copy)NSString* _des;
@property(nonatomic,copy)NSString* _time;
@property(nonatomic,copy)NSString* _replyContent;
@property(nonatomic,assign)BOOL isLast;

@end
