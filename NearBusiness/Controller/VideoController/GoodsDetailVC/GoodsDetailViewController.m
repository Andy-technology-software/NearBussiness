//
//  GoodsDetailViewController.m
//  ZKApp
//
//  Created by lingnet on 2017/1/20.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "GoodsDetailViewController.h"

#import "PayViewController.h"
@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详情";
    
    [self makeBottomView];
}

- (void)makeBottomView{
    UIView* _view = [MyController viewWithFrame:CGRectMake(0, 100, [MyController getScreenWidth], 40)];
    _view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_view];
    
    UIButton* _button = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(buttonClick) Title:@"购买"];
    [_view addSubview:_button];
}

- (void)buttonClick{
    PayViewController* vc = [[PayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
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
