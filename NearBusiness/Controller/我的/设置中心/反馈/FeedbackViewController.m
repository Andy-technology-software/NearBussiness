//
//  FeedbackViewController.m
//  ZKApp
//
//  Created by lingnet on 2017/8/16.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "FeedbackViewController.h"

#import "SendComTableViewCell.h"
@interface FeedbackViewController ()<UITableViewDataSource,UITableViewDelegate,AdvancedExpandableTableViewDelegate>{
    UITableView* _tableView;
    CGFloat textCellHeight;
}

@property(nonatomic,copy)NSString* _content;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"反馈";
    
    [self createTableView];
    
    [self makeData];
    
    [self makeSendBtn];
}


- (void)makeSendBtn{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtnClick) Title:@"提交"];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sendBtn];
}

- (void)sendBtnClick{
    if (![MyController returnStr:self._content].length) {
        [HUD warning:@"请填写反馈信息"];
        return;
    }
    [HUD loading];
//    [requestService postFeedbackWithId:[MyController getUserid] content:self._content complate:^(id responseObject) {
//        if ([responseObject[@"result"] intValue]) {
//            [HUD success:responseObject[@"data"]];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [HUD hide];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SendComTableViewCell *textCell = [tableView advancedExpandableTextCellWithId:@"SendComTableViewCell"];
    textCell.placeholder = @"请填写您的反馈信息";
    textCell.selectionStyle = UITableViewCellSelectionStyleNone;
    textCell.maxCharacter = 1000;
    textCell.DailyNew0TableViewCellDelegate = self;
    return textCell;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MAX(150, textCellHeight + 20);
}

#pragma mark - 这是事由cell代理
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    textCellHeight = height;
    NSLog(@"高度---%.2f",textCellHeight);
}
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"debug : updatedText\n%@", text);
    self._content = text;
}

- (void)makeData{
    //    [_tableView reloadData];
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
