//
//  RDVFirstViewController.m
//  AndyNewFram
//
//  Created by lingnet on 2017/4/7.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RDVFirstViewController.h"

#import "VideoModel.h"

#import "VideoTableViewCell.h"

#import "MyXJYChartViewController.h"

#import "EChartViewController.h"

#import "GoodsListViewController.h"
@interface RDVFirstViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;

@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* videos;
@end

@implementation RDVFirstViewController

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    self.videos = [[NSMutableArray alloc] init];
    MWPhoto *video = [MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=79027038,1838220333&fm=80&w=179&h=119&img.JPEG"]];
    video.videoURL = [[NSURL alloc] initWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    [self.videos addObject:video];
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"小工具";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    NSArray* titiA = [[NSArray alloc] initWithObjects:@"视频播放",@"XJYChart",@"EChart",@"商城列表 + 下拉菜单 + 支付", nil];
    for (int i = 0; i < titiA.count; i++) {
        VideoModel* model = [[VideoModel alloc] init];
        model.name = titiA[i];
        [self.dataSourceArr addObject:model];
    }
    [self createTableView];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
//    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        [_photoBrowser setCurrentPhotoIndex:0];
        UIViewController *rootController = [self.keyWindow rootViewController];
        [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
    }else if (1 == indexPath.row){
        MyXJYChartViewController* vc = [[MyXJYChartViewController alloc] init];
        vc.title = @"XJYChart";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (2 == indexPath.row){
        EChartViewController* vc = [[EChartViewController alloc] init];
        vc.title = @"EChart";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (3 == indexPath.row){
        GoodsListViewController* vc = [[GoodsListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"VideoTableViewCell";
    VideoTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    VideoModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [VideoTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        VideoTableViewCell *cell = (VideoTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey : stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                 };
    }];
}

#pragma mark - getter 创建一个显示图片的window
- (UIWindow *)keyWindow{
    if(_keyWindow == nil){
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return _keyWindow;
}
#pragma mark - 初始化MWPhotoBrowser
- (MWPhotoBrowser *)photoBrowser{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;//分享按钮
        _photoBrowser.displayNavArrows = YES;//底部是否分页切换导航，默认否
        _photoBrowser.displaySelectionButtons = NO; ////是否显示选择按钮在图片上,默认否
        _photoBrowser.alwaysShowControls = NO;//控制条件控件是否显示,默认否
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;//自动适用大小,默认是
        _photoBrowser.enableGrid = NO; //是否允许用网格查看所有图片,默认是
        _photoBrowser.startOnGrid = NO;//是否第一张,默认否
        _photoBrowser.autoPlayOnAppear = YES;//视频自动播放
    }
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.videos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.videos.count){
        return [self.videos objectAtIndex:index];
    }
    return nil;
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
