//
//  BuyCarModel.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/30.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyCarModel : NSObject
@property(nonatomic,copy)NSString* _img;
@property(nonatomic,copy)NSString* _title;
@property(nonatomic,copy)NSString* _des;
@property(nonatomic,copy)NSString* _price;
@property(nonatomic,copy)NSString* _num;
@property(nonatomic,assign)BOOL _isSelect;

@end
