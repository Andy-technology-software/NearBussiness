//
//  LocationMapViewController.h
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BaseViewController.h"

@protocol LocationMapViewControllerDelegate <NSObject>

- (void)sendBackSelectAddName:(NSString*)addName jingdu:(NSString*)jingdu weidu:(NSString*)weidu;
@end

@interface LocationMapViewController : BaseViewController
@property(nonatomic,weak)id<LocationMapViewControllerDelegate>LocationMapViewControllerDelegate;

@end
