//
//  FundManagementViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/31.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "FundManagementViewController.h"

#import "FundManagementCashViewController.h"

#import "FundManagementRedPackViewController.h"

#import "FundManagementCardViewController.h"
@interface FundManagementViewController ()<UIScrollViewDelegate>{
    FundManagementCashViewController* fundManagementCashViewController;
    FundManagementRedPackViewController* fundManagementRedPackViewController;
    FundManagementCardViewController* fundManagementCardViewController;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation FundManagementViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资金管理";
    
    [self MakeHMSView];
    
    [self makeScrollView];
}

#pragma mark - 创建滑动切换效果
- (void)MakeHMSView{
    // 创建四个按钮的地方  现在让他可以滑动
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], [MyController getScreenWidth], 40)];
    self.segmentedControl.sectionTitles = @[@"现金", @"红包", @"购物卡"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [MyController colorWithHexString:@"393939"],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [MyController colorWithHexString:@"393939"]};
    self.segmentedControl.selectionIndicatorColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorHeight = 3;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake([MyController getScreenWidth] * index, 0, [MyController getScreenWidth], [MyController getScreenHeight] - 40 - [MyController isIOS7]) animated:YES];
    }];
    [self.view addSubview:self.segmentedControl];
    
    UIView* linV1 = [MyController viewWithFrame:CGRectMake(0, [MyController isIOS7] + 40 - 0.5, [MyController getScreenWidth], 0.5)];
    linV1.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.view addSubview:linV1];
    
    for (int i = 1; i < 3; i++) {
        UIView* linV = [MyController viewWithFrame:CGRectMake([MyController getScreenWidth] / 3 * i, [MyController isIOS7], 0.5, 40)];
        linV.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
        [self.view addSubview:linV];
    }
}

#pragma mark - 创建第二个section上的UI
- (void)makeScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 40 , [MyController getScreenWidth],  [MyController getScreenHeight] - [MyController isIOS7] - 40)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake([MyController getScreenWidth] * 3,  [MyController getScreenHeight] - [MyController isIOS7] - 40);
    
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, [MyController getScreenWidth],  [MyController getScreenHeight] - [MyController isIOS7] - 40) animated:NO];
    [self.view addSubview:self.scrollView];
    
    [self createSliderView];
}

#pragma mark - 创建滑动跟下拉菜单
- (void)createSliderView{
    fundManagementCashViewController = [[FundManagementCashViewController alloc] init];
    fundManagementCashViewController.view.frame = CGRectMake([MyController getScreenWidth] * 0, 0, [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 40);
    [self addChildViewController:fundManagementCashViewController];
    [self.scrollView addSubview:fundManagementCashViewController.view];
    
    fundManagementRedPackViewController = [[FundManagementRedPackViewController alloc] init];
    fundManagementRedPackViewController.view.frame = CGRectMake([MyController getScreenWidth] * 1, 0, [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 40);
    [self addChildViewController:fundManagementRedPackViewController];
    [self.scrollView addSubview:fundManagementRedPackViewController.view];
    
    fundManagementCardViewController = [[FundManagementCardViewController alloc] init];
    fundManagementCardViewController.view.frame = CGRectMake([MyController getScreenWidth] * 2, 0, [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 40);
    [self addChildViewController:fundManagementCardViewController];
    [self.scrollView addSubview:fundManagementCardViewController.view];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
        NSLog(@"-----%ld",page);
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
