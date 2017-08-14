//
//  AddressBookIMViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "AddressBookIMViewController.h"

#import "SingleChatViewController.h"
@interface AddressBookIMViewController ()<EMUserListViewControllerDataSource>

@end

@implementation AddressBookIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<IUserModel> model = nil;
    
    model = [self.dataArray objectAtIndex:indexPath.row];
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
    viewController.title = model.nickname;
    [self.navigationController pushViewController:viewController animated:YES];
}

//联系人列表扩展样例
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                           modelForBuddy:(NSString *)buddy
{
    //用户可以根据自己的用户体系，根据buddy设置用户昵称和头像
    id<IUserModel> model = nil;
    model = [[EaseUserModel alloc] initWithBuddy:buddy];
    model.avatarURLPath = @"";//头像网络地址
    model.nickname = @"昵称";//用户昵称
    return model;
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
