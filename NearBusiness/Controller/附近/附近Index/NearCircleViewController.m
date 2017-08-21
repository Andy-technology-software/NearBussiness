//
//  NearCircleViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/7/4.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "NearCircleViewController.h"

#import "NearViewController.h"
@interface NearCircleViewController ()<YBPopupMenuDelegate>
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation NearCircleViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNav];
    
    [self configureUI];
    
    self.navigationController.navigationBar.barTintColor = [MyController colorWithHexString:@"ee4737"];
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
    [rightButton setImage:[UIImage imageNamed:@"shijian"]forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"shijian"]forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(searchBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem= rightItem;
    
    
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,27,27)];
    [rightButton1 setImage:[UIImage imageNamed:@"shijian"]forState:UIControlStateNormal];
    [rightButton1 setImage:[UIImage imageNamed:@"shijian"]forState:UIControlStateHighlighted];
    
    [rightButton1 addTarget:self action:@selector(sendBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    rightItem1.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem= rightItem1;
    
}
- (void)searchBtnClick{
    
}

- (void)sendBtnClick:(UIButton*)sender{
    
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 delegate:self];
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    NSLog(@"点击了 %@ 选项",TITLES[index]);
    if (1 == index) {
        
    }
    
}

- (void)configureUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NearViewController *nearVC = [[NearViewController alloc] init];
    [self addChildViewController:nearVC];
    [self.view addSubview:nearVC.view];
    //    enterpriseVC.view.hidden = YES;
    
    NearViewController *nearVC1 = [[NearViewController alloc] init];
    [self addChildViewController:nearVC1];
    [self.view addSubview:nearVC1.view];
    nearVC1.view.hidden = YES;
}
- (void)configureNav
{
    self.segment = ({
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"附近商家",@"附近人"]];
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
