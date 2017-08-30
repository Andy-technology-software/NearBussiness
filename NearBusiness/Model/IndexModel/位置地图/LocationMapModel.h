//
//  LocationMapModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/30.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationMapModel : NSObject
@property(nonatomic,copy)NSString* name;
//@property(nonatomic,copy)NSString* rname;
@property(nonatomic,copy)NSString* jingdu;
@property(nonatomic,copy)NSString* weidu;
@property (nonatomic, assign) BOOL isSelect;

@end
