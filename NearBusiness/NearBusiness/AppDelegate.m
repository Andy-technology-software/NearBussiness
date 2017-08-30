//
//  AppDelegate.m
//  NearBusiness
//
//  Created by lingnet on 2017/6/9.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "AppDelegate.h"

#import "IMViewController.h"

#import "HomeViewController.h"

#import "NearCircleViewController.h"

#import "BussnessCircleViewController.h"

#import "FriendCircleViewController.h"

#import "MineViewController.h"

#import "LoginViewController.h"

#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()<EMClientDelegate,UIAlertViewDelegate,EMChatManagerDelegate,JPUSHRegisterDelegate>
//EMChatManagerDelegate收消息代理

@property(nonatomic,assign)BOOL isImageMessage;
@property(nonatomic,assign)BOOL isTextMessage;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self customizeInterface];
    
    /**************************************************************友盟分享*********************************************************************************************/
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    /**************************************************************注册微信支付*********************************************************************************************/
    
//    [WXApi registerApp:MXWechatAPPID withDescription:@"微信支付"];
    
    /**************************************************************本地推送*********************************************************************************************/
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"获取用户是否同意开启通知成功!");
        }
    }];
    
    /**************************************************************极光推送*********************************************************************************************/
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //添加初始化JPush代码
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    //NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    
    
    [JPUSHService setupWithOption:launchOptions appKey:@"9bfdbb767738ea6c4c4b8e18"
                          channel:@"appstore"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    /***************************************************************************环信*****************************************************************************/
    EMOptions *options = [EMOptions optionsWithAppkey:@"e-exhibition#eexhibition"];
    options.apnsCertName = @"andyDev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //添加回调监听代理:
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    NSArray* dataArr = [[DBManager shareManager] getAllLoginModel];
    if (dataArr.count) {
        LoginDataBaseModel* model = [dataArr lastObject];
        NSLog(@"设备唯一标识：%@",[XRQGetOnlyUUID getUUID]);
        NSLog(@"当前设备ip：%@",[XRQGetIP deviceIPAdress]);
        
        //设置推送别名
        [JPUSHService setAlias:model.userName callbackSelector:@selector(callBack) object:nil];
        
        EMError *error = [[EMClient sharedClient] loginWithUsername:model.userName password:model.userName];
        if (!error){
            [[EMClient sharedClient].options setIsAutoLogin:YES];
        }
        
        //登录环信
        [[EMClient sharedClient] loginWithUsername:model.userName
                                          password:model.userName
                                        completion:^(NSString *aUsername, EMError *aError) {
                                            if (!aError) {
                                                NSLog(@"登陆成功");
                                            } else {
                                                NSLog(@"登陆失败");
                                            }
                                        }];
        
        //环信自动登录
        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
        if (!isAutoLogin) {
            EMError *error = [[EMClient sharedClient] loginWithUsername:model.userName password:model.userName];
        }
        [self setupViewControllers];
        [self.window setRootViewController:self.viewController];
    }else{
        [self setLoginRoot];
    }
    
    //iOS8以上 注册APNS 代码注册离线推送。
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    //集成 EaseUI
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:@"e-exhibition#eexhibition"
                                         apnsCertName:@"andyDev"
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}


- (void)setRootVC{
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = nil;
        self.viewController = nil;
        [self setupViewControllers];
        [self.window setRootViewController:self.viewController];
        [self.window makeKeyAndVisible];
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
    }];
}

- (void)setLoginRoot{
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Methods

- (void)setupViewControllers {
    HomeViewController *homevc = [[HomeViewController alloc] init];
    UIViewController *homevcNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:homevc];
    
    NearCircleViewController *nearvc = [[NearCircleViewController alloc] init];
    UIViewController *nearNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:nearvc];
    
    BussnessCircleViewController *bussinessvcViewController = [[BussnessCircleViewController alloc] init];
    UIViewController *bussinessvcNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:bussinessvcViewController];
    
    FriendCircleViewController *friendvc = [[FriendCircleViewController alloc] init];
    UIViewController *friendNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:friendvc];
    
    MineViewController *minevc = [[MineViewController alloc] init];
    UIViewController *mineNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:minevc];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[homevcNavigationController,nearNavigationController, bussinessvcNavigationController,friendNavigationController,mineNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"凌信", @"销售",@"客户",@"客户",@"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-选中",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

/*!
 *  自动登录返回结果
 *
 *  @param error 错误信息
 */
- (void)autoLoginDidCompleteWithError:(EMError *)error{
    NSLog(@"自动登录返回结果");
}

/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    NSLog(@"重连");
}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)userAccountDidLoginFromOtherDevice{
    NSLog(@"当前登录账号在其它设备登录时会接收到该回调");
    [[DBManager shareManager] deleteLoginData];
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号在其他设备登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self setLoginRoot];
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer{
    NSLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}

// 收到消息的回调，带有附件类型的消息可以用 SDK 提供的下载附件方法下载（后面会讲到）
- (void)messagesDidReceive:(NSArray *)aMessages {
    self.isImageMessage = NO;
    self.isTextMessage = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        for (EMMessage *message in aMessages) {
            EMMessageBody *msgBody = message.body;
            switch (msgBody.type) {
                case EMMessageBodyTypeText:
                {
                    // 收到的文字消息
                    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                    NSString *txt = textBody.text;
                    NSLog(@"收到的文字是 txt -- %@",txt);
                    //                    [self addLocalNotification:[NSString stringWithFormat:@"%@:%@",message.ext[@"other_nick_name"],txt]];
                    self.isTextMessage = YES;
                    [self addLocalNotification:message];
                }
                    break;
                case EMMessageBodyTypeImage:
                {
                    // 得到一个图片消息body
                    EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                    NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                    NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"大图的secret -- %@"    ,body.secretKey);
                    NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                    NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                    
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                    NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                    NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                    NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                    NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
                    self.isImageMessage = YES;
                    [self addLocalNotification:message];
                }
                    break;
                case EMMessageBodyTypeLocation:
                {
                    EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                    NSLog(@"纬度-- %f",body.latitude);
                    NSLog(@"经度-- %f",body.longitude);
                    NSLog(@"地址-- %@",body.address);
                }
                    break;
                case EMMessageBodyTypeVoice:
                {
                    // 音频sdk会自动下载
                    EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                    NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                    NSLog(@"音频的secret -- %@"        ,body.secretKey);
                    NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                    NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
                }
                    break;
                case EMMessageBodyTypeVideo:
                {
                    EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                    
                    NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"视频的secret -- %@"        ,body.secretKey);
                    NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
                    NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
                    NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                    
                    // 缩略图sdk会自动下载
                    NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                    NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                    NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                    NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
                }
                    break;
                case EMMessageBodyTypeFile:
                {
                    EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                    NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                    NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                    NSLog(@"文件的secret -- %@"        ,body.secretKey);
                    NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                    NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}
- (void)addLocalNotification:(EMMessage*) mess{
    EMMessageBody *msgBody = mess.body;
    //第二步：新建通知内容对象
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    if (self.isTextMessage) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
        NSString *txt = textBody.text;
        
        //    content.title = @"好友消息";
        content.subtitle = mess.ext[@"other_nick_name"];
        content.body = txt;
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
    }else if (self.isImageMessage) {
        content.subtitle = mess.ext[@"other_nick_name"];
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
        //EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
        //NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"https://ss1.bdstatic.com/5eN1bjq8AAUYm2zgoY3K/r/www/cache/holiday/habo/res/doodle/8.png" ofType:@"png"];
        UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"iamgeAttachment" URL:[NSURL URLWithString:@"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=184129082,1921100116&fm=80&w=179&h=119&img.JPEG "] options:nil error:nil];
        content.attachments = @[imageAttachment];//虽然是数组，但是添加多个只能显示第一个
    }
    
    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    //第四步：创建UNNotificationRequest通知请求对象
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    
    //第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    }];
}

/*****************************************************极光推送*******************************************************************/
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //点击通知在这响应
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        //在这里边加点击相应操作
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    //    之前是在这里边加的点击响应操作  低版本<10.0
}

/*********************************************************************支付回调****************************************************************************************************/

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK if ([url.host isEqualToString:@"safepay"]) {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    //银联
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        //结果code为成功时，先校验签名，校验成功后做后续处理
        if([code isEqualToString:@"success"]) {
            
            //数据从NSDictionary转换为NSString
            NSDictionary *data;
            NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:0
                                                                 error:nil];
            NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
            
            //判断签名数据是否存在
            if(data == nil){
                //如果没有签名数据，建议商户app后台查询交易结果
                return;
            }
            
            //验签证书同后台验签证书
            //此处的verify，商户需送去商户后台做验签
            if([self verify:sign]) {
                //支付成功且验签成功，展示支付成功提示
                NSLog(@"银联支付成功");
            }
            else {
                //验签失败，交易结果数据被篡改，商户app后台查询交易结果
            }
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }
    }];
    
    //微信支付
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return result;
    
}

- (BOOL)verify:(NSString*)verify{
    return YES;
}

#pragma mark - 微信支付回调

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

#pragma mark - 友盟分享
- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
}


@end
