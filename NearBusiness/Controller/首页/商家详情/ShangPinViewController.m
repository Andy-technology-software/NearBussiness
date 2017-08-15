
//
//  ShangPinViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ShangPinViewController.h"

#import "ShangPinModel.h"

#import "ShangPinTableViewCell.h"

#import "ProductDetailsViewController.h"
@interface ShangPinViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation ShangPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self makeData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor clearColor];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailsViewController* vc = [[ProductDetailsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ShangPinTableViewCell";
    ShangPinTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[ShangPinTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ShangPinModel *model = nil;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShangPinModel* model = self.dataSource[indexPath.row];
    return [ShangPinTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        ShangPinTableViewCell *cell = (ShangPinTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        ShangPinModel* model = [[ShangPinModel alloc] init];
        model._image = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model._title = @"陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行陈伟霆03年以歌手身份入行";
        model._des = @"美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健";
        model._price = @"998.0";
        [self.dataSource addObject:model];
    }
    [_tableView reloadData];
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
