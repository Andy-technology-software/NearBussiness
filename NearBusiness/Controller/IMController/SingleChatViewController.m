//
//  SingleChatViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SingleChatViewController.h"

#import "SelfInfoViewController.h"
@interface SingleChatViewController ()<EaseMessageViewControllerDelegate>

@end

@implementation SingleChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LoginDataBaseModel* model = [[[DBManager shareManager] getAllLoginModel] lastObject];
    
    //这个地方是给父类传值  父类定义了一个扩展字典ext_dic
    self.ext_dic = [[NSMutableDictionary alloc] init];
    self.ext_dic[@"self_nick_name"] = model.nickName;
    self.ext_dic[@"self_head_image"] = model.image;
    self.ext_dic[@"other_nick_name"] = @"好友";
    self.ext_dic[@"other_head_image"] = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492145775242&di=92bd02916e550a93ae9e7deca4c8d64c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F472309f790529822eba0ada1d3ca7bcb0b46d4c5.jpg";
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    NSLog(@"点击了头像--%@",messageModel.message.ext);
    
    SelfInfoViewController* vc = [[SelfInfoViewController alloc] init];
    vc.title = messageModel.nickname;
    [self.navigationController pushViewController:vc animated:YES];
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