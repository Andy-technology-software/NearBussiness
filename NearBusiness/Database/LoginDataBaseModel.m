//
//  DBManager.h
//  E展会
//
//  Created by 徐仁强 on 15/8/28.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import "LoginDataBaseModel.h"
/*
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
@property(nonatomic,copy) NSString* isAuthor;*/
@implementation LoginDataBaseModel
+(void)load{
    [LoginDataBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"userId":@"userid",@"userName":@"username",@"nickName":@"nickname",@"image":@"img"};
    }];
}
-(void)setAuthentInfo5:(NSString *)authentInfo5{
    _authentInfo5 = authentInfo5;
    [[NSUserDefaults standardUserDefaults] setObject:[MyController returnStr:_authentInfo5] forKey:@"authentInfo5"];
}
@end
