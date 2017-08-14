//
//  AppDelegate.h
//  NearBusiness
//
//  Created by lingnet on 2017/6/9.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;
- (void)setRootVC;
- (void)setLoginRoot;
@end

