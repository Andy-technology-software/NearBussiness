//
//  InfoViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/18.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "InfoViewController.h"

#import "ZiXunModel.h"

#import "ZiXunTableViewCell.h"
@interface InfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self makeData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40 - 49) style:UITableViewStylePlain];
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
//    ProductDetailsViewController* vc = [[ProductDetailsViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ZiXunTableViewCell";
    ZiXunTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[ZiXunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ZiXunModel *model = nil;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZiXunModel* model = self.dataSource[indexPath.row];
    return [ZiXunTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        ZiXunTableViewCell *cell = (ZiXunTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        ZiXunModel* model = [[ZiXunModel alloc] init];
        model._headImg = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model._name = @"陈伟霆03年以歌手身份入行陈";
        model._des = @"美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健、美甲、大保健";
        model._imageArr = [[NSMutableArray alloc] initWithObjects:@"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=841788587,434442241&fm=173&s=F7A09B09342B790D73888DC10300A0B4&w=218&h=146&img.JPEG",@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1108770861,611962082&fm=173&s=32931DCD404213515EA1613E0300D051&w=218&h=146&img.JPG",@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=711436137,425390484&fm=173&s=F9E68B5440D14DC242AC3C610300B070&w=218&h=146&img.JPG", nil];
        model._isRed = YES;
        model._time = @"上周";
        model._comment = @"2";
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
