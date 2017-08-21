//
//  ZiXunModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/21.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZiXunModel : NSObject
@property(nonatomic,copy)NSString* _headImg;
@property(nonatomic,copy)NSString* _name;
@property(nonatomic,copy)NSString* _des;
@property(nonatomic,copy)NSString* _time;
@property(nonatomic,copy)NSString* _comment;
@property(nonatomic,assign)BOOL _isRed;
@property (nonatomic, strong) NSArray *picNamesArray;

@end
