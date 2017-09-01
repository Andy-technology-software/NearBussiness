
//
//  BussinessDetailViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "BussinessDetailViewController.h"

#import "JieShaoViewController.h"

#import "ShangPinViewController.h"
@interface BussinessDetailViewController ()
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation BussinessDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNav];
    
    [self configureUI];
    
    self.navigationController.navigationBar.barTintColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    //导航透明度
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1;
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTBGCOLOR];
    [self createLeftNvc];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)createLeftNvc{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,27,27)];
    [rightButton setImage:[UIImage imageNamed:@"fh"]forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"fh"]forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)configureUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    JieShaoViewController *jsVC = [[JieShaoViewController alloc] init];
    [self addChildViewController:jsVC];
    [self.view addSubview:jsVC.view];
    //    enterpriseVC.view.hidden = YES;
    
    ShangPinViewController *spVC = [[ShangPinViewController alloc] init];
    [self addChildViewController:spVC];
    [self.view addSubview:spVC.view];
    spVC.view.hidden = YES;
}
- (void)configureNav
{
    self.segment = ({
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"商家介绍",@"商品"]];
        segment.frame = CGRectMake(0, 0, 176, 30);
        segment.selectedSegmentIndex = 0;
        segment.tintColor = [MyController colorWithHexString:@"ffffff"];
        segment.layer.masksToBounds = YES;
        segment.layer.cornerRadius = 15;
        segment.layer.borderWidth = 1;
        segment.layer.borderColor = [MyController colorWithHexString:@"ffffff"].CGColor;
        NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        //        attrDict[NSForegroundColorAttributeName] = CGColorGetAlpha(<#CGColorRef  _Nullable color#>);
        [segment setTitleTextAttributes:attrDict forState:UIControlStateNormal];
        [segment setContentOffset:CGSizeMake(1, 0) forSegmentAtIndex:0];
        [segment setContentOffset:CGSizeMake(-1, 0) forSegmentAtIndex:1];
        [segment addTarget:self action:@selector(segmentAction:)
          forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = segment;
        segment;
    });
    
}

- (void)segmentAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.childViewControllers[0].view.hidden = NO;
        self.childViewControllers[1].view.hidden = YES;
    }else {
        self.childViewControllers[0].view.hidden = YES;
        self.childViewControllers[1].view.hidden = NO;
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
