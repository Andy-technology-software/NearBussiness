//
//  BussinessRecommendationModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/11.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BussinessRecommendationModel : NSObject
@property(nonatomic,copy) NSString* idStr;
@property(nonatomic,copy) NSString* img;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* des;
@property(nonatomic,assign) BOOL isRedPack;
@property(nonatomic,copy) NSString* distance;

@end
