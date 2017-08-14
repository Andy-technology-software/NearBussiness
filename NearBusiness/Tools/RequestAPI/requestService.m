//
//  requestService.m
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "requestService.h"

@implementation requestService

/**
 登录
 
 @param userId 手机号/用户名
 @param password 密码
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUserid:(NSString*)userId password:(NSString*)password complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",LOGINURL];
    NSDictionary* param = @{@"userId":userId,@"password":password};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 上传坐标
 
 @param userId userid
 @param lat 纬度
 @param lng 经度
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postPositionUpLoadWithUserid:(NSString*)userId lat:(NSString*)lat lng:(NSString*)lng complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",positionUpload];
    NSDictionary* param = @{@"userId":userId,@"lat":lat,@"lng":lng};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 获取轨迹
 
 @param userId userid
 @param date 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetTrailWithUserid:(NSString*)userId date:(NSString*)date complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getTrail];
    NSDictionary* param = @{@"userId":userId,@"date":date};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 通讯录列表
 
 @param departmentId 部门id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetStaffWithDepartmentId:(NSString*)departmentId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getStaff];
    NSDictionary* param = @{@"departmentId":departmentId,@"userId":@""};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 员工列表
 
 @param userId 自己id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSubordinateWithUserId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getSubordinate];
    NSDictionary* param = @{@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];

}



/**
 签到信息
 
 @param userId 自己id
 @param time 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSigninInfoWithUserId:(NSString*)userId time:(NSString*)time complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getSigninInfo];
    NSDictionary* param = @{@"userId":userId,@"time":time};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 签到
 
 @param userId 自己id
 @param type 考勤类型(1:wifi;2:定位;)
 @param lat 纬度
 @param lng 经度
 @param registerType 签到班次
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postSigninWithUserId:(NSString*)userId type:(NSString*)type lat:(NSString*)lat lng:(NSString*)lng registerType:(NSString*)registerType address:(NSString*)address complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",signin];
    NSDictionary* param = @{@"userId":userId,@"type":type,@"lat":lat,@"lng":lng,@"registerType":registerType,@"address":address};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}









/**
 获取首页的轮播图
 
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)getIndexBannersListsWithComplate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString *path = @"http://os.ehuizhan.com.cn/app/index!exhibitionIndex.action";
    [XRQRequestClient postWithOldURLString:path params:nil WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 获取行业分类
 
 @param userid 自己id
 @param pnum 页数
 @param num 数量
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postClassTypeWithUserId:(NSString*)userid Pnum:(NSString*)pnum Num:(NSString*)num complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = @"http://os.ehuizhan.com.cn/app/exhibition!industryTypes.action";
    NSDictionary* param = @{@"userid":userid,@"pnum":pnum,@"num":num};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



@end
