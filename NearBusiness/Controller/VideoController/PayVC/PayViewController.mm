//
//  PayViewController.m
//  ZKApp
//
//  Created by lingnet on 2017/1/20.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付";
    
    [self makePayView];
}

- (void)makePayView{
    NSArray* titleArr = [[NSArray alloc] initWithObjects:@"支付宝",@"微信",@"银联", nil];
    for (int i = 0; i < 3; i++) {
        UIButton* payButton = [MyController createButtonWithFrame:CGRectMake(10, 200 + 80 * i, [MyController getScreenWidth] - 20, 40) ImageName:nil Target:self Action:@selector(payButton:) Title:titleArr[i]];
        [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payButton setBackgroundColor:[UIColor greenColor]];
        payButton.tag = 100 + i;
        [self.view addSubview:payButton];
    }
}

- (void)payButton:(UIButton*)btn{
    if (100 == btn.tag) {
        NSLog(@"支付宝");
        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:@"1212121221221" productName:@"会员1个月" productDescription:@"加入有更多权限" amount:@"0.01" notifyURL:kNotifyURL itBPay:@"30m"];
    }else if (101 == btn.tag){
        NSLog(@"微信");
        [MXWechatPayHandler jumpToWxPay];
    }else if (102 == btn.tag){
        NSLog(@"银联");
        [[UPPaymentControl defaultControl] startPay:@"111111111121111111111" fromScheme:@"ZKApp" mode:@"01" viewController:self];

        /*
        //当获得的tn不为空时，调用支付接口
        if (tn != nil && tn.length > 0)
        {
            [[UPPaymentControl defaultControl]
             startPay:tn
             fromScheme:@"UPPayDemo"
             mode:self.tnMode
             viewController:self]; 
        }
         */
    }
}

#pragma mark UPPayPluginResult--银联支付成功后回调
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:@"%@", result];//支付结果
    if ([msg isEqualToString:@"success"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"支付成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if ([msg isEqualToString:@"fail"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"支付失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if([msg isEqualToString:@"cancel"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"支付已取消" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
