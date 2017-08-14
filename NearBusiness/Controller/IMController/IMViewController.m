//
//  IMViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "IMViewController.h"

#import "SingleChatViewController.h"

#import "ChatListIMViewController.h"

#import "AddressBookIMViewController.h"
@interface IMViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, assign) BOOL isInitUI; // 是否已经初始化完成UI
@property (nonatomic, strong) UIPopoverController *activityPopoverController;

@end

@implementation IMViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNav];
    
    [self configureUI];
    
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


/**
 分享
 */
- (void)backBtnClick1{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"徐仁强工作周报" ofType:@"xlsx"];
    NSURL *URL = [NSURL fileURLWithPath:filePath];
    TTOpenInAppActivity *openInAppActivity = [[TTOpenInAppActivity alloc] initWithView:self.view andRect:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight])];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:@[openInAppActivity]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        // Store reference to superview (UIActionSheet) to allow dismissal
        openInAppActivity.superViewController = activityViewController;
        // Show UIActivityViewController
        [self presentViewController:activityViewController animated:YES completion:NULL];
    } else {
        // Create pop up
        self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        // Store reference to superview (UIPopoverController) to allow dismissal
        openInAppActivity.superViewController = self.activityPopoverController;
        // Show UIActivityViewController in popup
        [self.activityPopoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - 返回响应
- (void)backBtnClick{
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否真滴要登出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是的", nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        NSLog(@"登出");
        [[DBManager shareManager] deleteLoginData];
        [JPUSHService setAlias:@"" callbackSelector:@selector(callBack) object:nil];
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"聊天退出成功");
        }
        
        [(AppDelegate *)[UIApplication sharedApplication].delegate setLoginRoot];
    }
}

- (void)startLiveB{
    SingleChatViewController* vc = [[SingleChatViewController alloc] initWithConversationChatter:@"111111" conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureNav {
    self.segment = ({
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"好友"]];
        segment.frame = CGRectMake(0, 0, 130, 28);
        segment.selectedSegmentIndex = 0;
        segment.tintColor = [UIColor blackColor];
        segment.layer.masksToBounds = YES;
        segment.layer.cornerRadius = 13;
        segment.layer.borderWidth = 1;
        segment.layer.borderColor = [UIColor blackColor].CGColor;
        NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//        attrDict[NSForegroundColorAttributeName] = @"#eeeeee";
        [segment setTitleTextAttributes:attrDict forState:UIControlStateNormal];
        [segment setContentOffset:CGSizeMake(1, 0) forSegmentAtIndex:0];
        [segment setContentOffset:CGSizeMake(-1, 0) forSegmentAtIndex:1];
        [segment addTarget:self action:@selector(segmentAction:)
          forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = segment;
        segment;
    });
    
}

- (void)segmentAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.childViewControllers[0].view.hidden = NO;
        self.childViewControllers[1].view.hidden = YES;
    }else {
        self.childViewControllers[0].view.hidden = YES;
        self.childViewControllers[1].view.hidden = NO;
    }
}

- (void)configureUI
{
    self.isInitUI = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ChatListIMViewController *enterpriseVC = [[ChatListIMViewController alloc] init];
    [self addChildViewController:enterpriseVC];
    [self.view addSubview:enterpriseVC.view];
    
    AddressBookIMViewController *liveVC = [[AddressBookIMViewController alloc] init];
    [self addChildViewController:liveVC];
    [self.view addSubview:liveVC.view];
    liveVC.view.hidden = YES;
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
