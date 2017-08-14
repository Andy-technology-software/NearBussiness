//
//  MyXJYChartViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/28.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "MyXJYChartViewController.h"

@interface MyXJYChartViewController ()

@end

@implementation MyXJYChartViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
