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
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postOrderListWithUserid:(NSString*)userId pageIndex:(NSString*)pageIndex pageSize:(NSString*)pageSize complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getOrderList];
    NSDictionary* param = @{@"id":userId,@"pageIndex":pageIndex,@"pageSize":pageSize};
    
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
