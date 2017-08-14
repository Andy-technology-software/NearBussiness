//
//  BussinessSearchModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BussinessSearchModel : NSObject
@property(nonatomic,copy) NSString* idStr;
@property(nonatomic,copy) NSString* img;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* zhuying;
@property(nonatomic,assign) BOOL isRedPack;
@property(nonatomic,copy) NSString* distance;
@property(nonatomic,copy) NSString* tel;
@property(nonatomic,copy) NSString* address;
@end
