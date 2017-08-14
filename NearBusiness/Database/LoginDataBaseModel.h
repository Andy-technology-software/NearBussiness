//
//  DBManager.h
//  E展会
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDataBaseModel : NSObject
//用户id
@property(nonatomic,copy) NSString* userId;
//用户电话
@property(nonatomic,copy) NSString* userName;
//用户性质
@property(nonatomic,copy) NSString* isPersion;
//用户电话
@property(nonatomic,copy) NSString* phone;
//用户昵称
@property(nonatomic,copy) NSString* nickName;
//用户头像
@property(nonatomic,copy) NSString* image;
//用户地址
@property(nonatomic,copy) NSString* address;
//用户密码
@property(nonatomic,copy) NSString* password;
//行业id
@property(nonatomic,copy) NSString* industry;
//行业name
@property(nonatomic,copy) NSString* industryName;
//是否认证
@property(nonatomic,copy) NSString* isAuthor;
//昵称
@property(nonatomic,copy) NSString* name;
// 性别
@property (nonatomic,copy) NSString *sex;
//是否可以直播 1.为直播用户 0.不能直播
@property (nonatomic,copy) NSString *authentInfo5;

@end
