//
//  DBManager.m
//  E展会
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//
#import "DBManager.h"

#import "FMDatabase.h"
@implementation DBManager{
    FMDatabase*_dataBase;
}
static DBManager *manager = nil;
+ (DBManager *)shareManager{
    
    //单例中也需要避免多个线程同时调用shareManager方法
    @synchronized(self){
        if (manager == nil) {
            manager = [[DBManager alloc] init];
        }
    }
    return manager;
}
#pragma mark - 重写init方法
- (id)init{
    self = [super init];
    if (self) {
        //为数据库文件指定创建的路径
        NSString *dbPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/ezhanhui.db"];
        //初始化FMDataBase对象，并传递数据库的路径
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        //如果创建并打开成功 return yes
        if ([_dataBase open]) {
            
            /***************************************************登录信息表***************************************************************/
            
            NSString* loginInfoData = @"create table if not exists userLoginInfoData (userId varchar(256),userName varchar(256),isPersion varchar(256),phone varchar(256),nickName varchar(256),image varchar(256),address varchar(256),password varchar(256),industry varchar(256),industryName varchar(256), isAuthor  varchar(256))";
            
            //登录信息 执行sql语句成功返回YES
            BOOL isSuccessed =[_dataBase executeUpdate:loginInfoData];
            if (!isSuccessed) {
                //创建表失败,lastErrorMessage 获取到出错的信息
                NSLog(@"登录信息失败error:%@",_dataBase.lastErrorMessage);
            }
            
            /***************************************************登录状态表***************************************************************/
            
            NSString* loginStatusData = @"create table if not exists userLoginStatusData (loginStatus varchar(256))";
            
            //登录状态 执行sql语句成功返回YES
            BOOL isSuccessed1 =[_dataBase executeUpdate:loginStatusData];
            if (!isSuccessed1) {
                //创建表失败,lastErrorMessage 获取到出错的信息
                NSLog(@"登录状态失败error:%@",_dataBase.lastErrorMessage);
            }
        }
    }
    return self;
}

/***************************************************登录信息操作***************************************************************/

#pragma mark - 添加一条登录数据
- (void)insertLoginModel:(LoginDataBaseModel *)model{
    NSLog(@"登录信息数据库插入成功");
    NSString*insertSql = @"insert into userLoginInfoData(userID,userName,isPersion,phone,nickName,image,address,password,industry,industryName,isAuthor) values(?,?,?,?,?,?,?,?,?,?,?)";
    BOOL isSuccessed=[_dataBase executeUpdate:insertSql,model.userId,model.userName,model.isPersion,model.phone,model.nickName,model.image,model.address,model.password,model.industry,model.industryName,model.isAuthor];
    if(!isSuccessed){
        NSLog(@"登录信息插入失败");
        NSLog(@"insertError%@",_dataBase.lastErrorMessage);
    }
}

#pragma mark - 删除登录表
- (void)deleteLoginData{
    BOOL isSucceed2=[_dataBase executeUpdate:@"delete from userLoginInfoData"];
    if (isSucceed2) {
        NSLog(@"登录信息删除成功");
    }else{
        NSLog(@"登录信息删除失败");
    }
    //注 删除操作，返回的BOOL只告诉你符合这个条件的删除了，如果语句错误，则会返回删除失败
}

#pragma mark - 获取登录成功的信息
- (NSMutableArray*)getAllLoginModel{
    NSString *selectSql = @"select * from userLoginInfoData";
    FMResultSet *set =[_dataBase executeQuery:selectSql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        LoginDataBaseModel *model = [[LoginDataBaseModel alloc] init];
        model.userId = [set stringForColumn:@"userId"];
        model.userName = [set stringForColumn:@"userName"];
        model.isPersion = [set stringForColumn:@"isPersion"];
        model.phone = [set stringForColumn:@"phone"];
        model.nickName = [set stringForColumn:@"nickName"];
        model.image = [set stringForColumn:@"image"];
        model.address = [set stringForColumn:@"address"];
        model.password = [set stringForColumn:@"password"];
        model.industry = [set stringForColumn:@"industry"];
        model.industryName = [set stringForColumn:@"industryName"];
        model.isAuthor = [set stringForColumn:@"isAuthor"];

        [array addObject:model];
    }
    return array;
}

//修改头像
-(void)upDataHeadImage:(NSString*)str1 other:(NSString*)str2{
    BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set image=? where image=?",str1,str2];
    if (isSucceed) {
        NSLog(@"头像更新成功");
    }else{
        NSLog(@"头像更新失败");
    }
}

-(void)upNickName:(NSString*)str1 other:(NSString*)str2{
    BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set nickName=? where nickName=?",str1,str2];
    if (isSucceed) {
        NSLog(@"昵称更新成功");
    }else{
        NSLog(@"昵称更新失败");
    }
}

//修改认证状态  更新数据
-(void)upAuthor:(NSString*)str1 other:(NSString*)str2{
     BOOL isSucceed = [_dataBase executeUpdate:@"update userLoginInfoData set isAuthor=? where isAuthor=?",str1,str2];
    if (isSucceed) {
        NSLog(@"认证更新成功");
    }else{
        NSLog(@"认证更新失败");
    }
}
@end
