//
//  RDVSecondViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/7.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RDVSecondViewController.h"

@interface RDVSecondViewController ()<BlurEffectMenuDelegate>

@end

@implementation RDVSecondViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播";
    
    UIButton* startLiveB = [MyController createButtonWithFrame:CGRectMake(20, 60, [MyController getScreenWidth] - 40, 60) ImageName:nil Target:self Action:@selector(startLiveB) Title:@"开始直播"];
    [startLiveB setBackgroundColor:[UIColor redColor]];
    [startLiveB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:startLiveB];
    
    [self createLeftNvc];
}

#pragma mark - 创建返回
- (void)createLeftNvc{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"LogOff"]forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton1 setImage:[UIImage imageNamed:@"share"]forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [rightButton1 addTarget:self action:@selector(backBtnClick1)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    rightItem1.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem= rightItem1;
}

- (void)backBtnClick{
    [self btnClicked];
}

- (void)backBtnClick1{
    
}

#pragma mark - Event
- (void)btnClicked{
    BlurEffectMenuItem *addMattersItem=[[BlurEffectMenuItem alloc]init];
    [addMattersItem setTitle:@"添加事项"];
    [addMattersItem setIcon:[UIImage imageNamed:@"addMatters"]];
    
    BlurEffectMenuItem *addSchedulesItem=[[BlurEffectMenuItem alloc]init];
    [addSchedulesItem setTitle:@"添加日程"];
    [addSchedulesItem setIcon:[UIImage imageNamed:@"addSchedule"]];
    
    BlurEffectMenuItem *setupChatItem=[[BlurEffectMenuItem alloc]init];
    [setupChatItem setTitle:@"发起会话"];
    [setupChatItem setIcon:[UIImage imageNamed:@"setupChat"]];
    
    BlurEffectMenuItem *searchContactsItem=[[BlurEffectMenuItem alloc]init];
    [searchContactsItem setTitle:@"查找联系人"];
    [searchContactsItem setIcon:[UIImage imageNamed:@"searchContacts"]];
    
    BlurEffectMenu *menu=[[BlurEffectMenu alloc]initWithMenus:@[addMattersItem,addSchedulesItem,setupChatItem,searchContactsItem]];
    [menu setDelegate:self];
    menu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [menu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:menu animated:YES completion:nil];
}

#pragma mark - BlurEffectMenu Delegate
- (void)blurEffectMenuDidTapOnBackground:(BlurEffectMenu *)menu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)blurEffectMenu:(BlurEffectMenu *)menu didTapOnItem:(BlurEffectMenuItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"item.title:%@",item.title);
    
}

- (void)startLiveB{

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
