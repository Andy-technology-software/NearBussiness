//
//  ChatListIMViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChatListIMViewController.h"

#import "SingleChatViewController.h"
@interface ChatListIMViewController ()<EaseConversationListViewControllerDelegate,EaseConversationListViewControllerDataSource>

@end

@implementation ChatListIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.showRefreshHeader = YES;
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
    
    [self refreshAndSortView];
}

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel{
    NSLog(@"点击了");
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:conversationModel.conversation.conversationId conversationType:conversationModel.conversation.type];
    viewController.title = conversationModel.title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)messagesDidReceive:(NSArray *)aMessages{
    NSLog(@"收到了消息");
    [self refreshAndSortView];
}

- (void)conversationListDidUpdate:(NSArray *)aConversationList{
    NSLog(@"会话列表发生了变化");
    [self tableViewDidTriggerHeaderRefresh];
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
