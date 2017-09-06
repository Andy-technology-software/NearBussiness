//
//  requestService.h
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XRQRequestClient.h"
@interface requestService : NSObject


/**
 登录
 
 @param userId 手机号/用户账号
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postOrderListWithUserid:(NSString*)userId pageIndex:(NSString*)pageIndex pageSize:(NSString*)pageSize complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;




/**
 获取首页的轮播图
 
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)getIndexBannersListsWithComplate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;


/**
 获取附近公交站站点信息
 
 @param longitude 经度
 @param latitude 纬度
 @param range 范围
 @param signKey 签名
 @param timeStamp 获取时间
 @param complate 请求完成
 @param random 不知道什么参数  随机数？
 @param failure 请求失败
 */
+(void)Query_NearbyStatInfoWithLongitude:(NSString*)longitude Latitude:(NSString*)latitude Range:(NSString*)range Random:(NSString*)random SignKey:(NSString*)signKey TimeStamp:(NSString*)timeStamp complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;


/**
 获取行业分类
 
 @param userid 自己id
 @param pnum 页数
 @param num 数量
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postClassTypeWithUserId:(NSString*)userid Pnum:(NSString*)pnum Num:(NSString*)num complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;
@end
