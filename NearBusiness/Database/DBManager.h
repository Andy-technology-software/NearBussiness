//
//  DBManager.h
//  E展会
//
//  Created by 徐仁强 on 15/8/28.
//  Copyright (c) 2015年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDataBaseModel.h"

@interface DBManager : NSObject

+(DBManager*)shareManager;

//添加一条登录成功数据
-(void)insertLoginModel:(LoginDataBaseModel *)model;
//获取登录成功数据
-(NSMutableArray*)getAllLoginModel;
//删除登录成功数据
- (void)deleteLoginData;
//修改头像  更新数据
-(void)upDataHeadImage:(NSString*)str1 other:(NSString*)str2;
//修改昵称  更新数据
-(void)upNickName:(NSString*)str1 other:(NSString*)str2;
//修改认证状态  更新数据
-(void)upAuthor:(NSString*)str1 other:(NSString*)str2;
@end
