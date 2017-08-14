//
//  JieShaoViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/14.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "JieShaoViewController.h"

#import "IndexModel.h"

#import "BussinessDetailTableViewCell.h"

#import "BussinessDetail1Model.h"

#import "BussinessDetail1TableViewCell.h"
@interface JieShaoViewController ()<UITableViewDataSource,UITableViewDelegate,BussinessDetailTableViewCellDelegate,MWPhotoBrowserDelegate,BussinessDetail1TableViewCellDelegate>{
    UITableView* _tableView;
}
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;

@property(nonatomic,retain)NSMutableArray* picturesArr;
@property(nonatomic,retain)NSMutableArray* picturesArr1;

@property(nonatomic,retain)NSMutableArray* dataSource;
@end

@implementation JieShaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.picturesArr = [[NSMutableArray alloc] init];
    self.picturesArr1 = [[NSMutableArray alloc] init];
    self.photos = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    
    [self createTableView];
    
    [self getIndexBannder];
    
    [self createBottomView];
    
    [self makeData];
}

- (void)createBottomView{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50)];
    [self.view addSubview:bottomView];
    
    
    UIView* shareView = [MyController viewWithFrame:bottomView.frame];
    [bottomView addSubview:shareView];
    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    UIImageView* shareIV = [MyController createImageViewWithFrame:shareView.frame ImageName:@"shijian"];
    [shareView addSubview:shareIV];
    
    [shareIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerX.mas_equalTo(shareView);
    }];
    
    UILabel* shareLable = [MyController createLabelWithFrame:shareView.frame Font:10 Text:@"分享"];
    [shareView addSubview:shareLable];
    
    [shareLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shareIV.mas_bottom).mas_offset(3);
        make.centerX.mas_equalTo(shareView);
    }];
    
    UIView* lineView = [MyController viewWithFrame:bottomView.frame];
    lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [bottomView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_offset(0.5);
        make.height.mas_offset(50);
        make.left.mas_equalTo(shareView.mas_left);
    }];
    
    
    
    UIView* foView = [MyController viewWithFrame:bottomView.frame];
    [bottomView addSubview:foView];
    
    [foView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lineView.mas_left);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    UIImageView* foIV = [MyController createImageViewWithFrame:shareView.frame ImageName:@"shijian"];
    [foView addSubview:foIV];
    
    [foIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerX.mas_equalTo(foView);
    }];
    
    UILabel* foLable = [MyController createLabelWithFrame:shareView.frame Font:10 Text:@"关注"];
    [foView addSubview:foLable];
    
    [foLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(foIV.mas_bottom).mas_offset(3);
        make.centerX.mas_equalTo(foView);
    }];
    
    
    
    UIView* chatView = [MyController viewWithFrame:bottomView.frame];
    chatView.backgroundColor = [MyController colorWithHexString:@"ee4737"];
    [bottomView addSubview:chatView];
    
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(foView.mas_left);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    
    UIImageView* chatIV = [MyController createImageViewWithFrame:chatView.frame ImageName:@"shijian"];
    [chatView addSubview:chatIV];
    
    [chatIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(chatView);
        make.right.mas_equalTo(chatView.mas_centerX).mas_offset(-20);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];

    UILabel* chatLable = [MyController createLabelWithFrame:shareView.frame Font:14 Text:@"在线咨询"];
    chatLable.textColor = [UIColor whiteColor];
    [chatView addSubview:chatLable];
    
    [chatLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.left.mas_equalTo(chatIV.mas_right).mas_offset(10);
    }];
}

#pragma mark - 创建数据
- (void)makeData{
    BussinessDetail1Model* model = [[BussinessDetail1Model alloc] init];
    model.jieshao = @"利群是利群集团股份有限公司的简称，利群集团股份有限公司是一家有着70多年历史，跨地区、多业态、综合性的股份制商业企业集团。经营范围涉及商业连锁、商业物流、酒店连锁、药品批发物流、进出口贸易、房地产等领域。 利群集团的前身——“德源泰百货店”始建于1933年，1956年由“德源泰百货”、“永信绸布”、“大光明眼镜”、“福兴祥文具”和“福兴昌玻璃”五家店铺公私合营为国营利群百货商店；1994年11月，由集团自行承建的集购物、娱乐、餐饮、住宿于一体的3.8万平米的利群商厦竣工营业，标志着利群集团“重新创业”的开始。";
    model.add = @"香江路888号";
    model.tel = @"18888888888";
    [self.dataSource addObject:model];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - 请求-获取广告图
- (void)getIndexBannder {
    [requestService getIndexBannersListsWithComplate:^(id responseObject) {
        NSDictionary* sourceDic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
        self.picturesArr = [IndexModel mj_objectArrayWithKeyValuesArray:sourceDic[@"ad"]];
        for (IndexModel* M in self.picturesArr) {
            NSLog(@"----%@",M.img);
            [self.picturesArr1 addObject:M.img];
            [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", M.img]]]];
        }
        //        [_tableView reloadData];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        [HUD warning:@"请求出错"];
    }];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
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

#pragma mark - tableView组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        BussinessDetailTableViewCell* cell0 = [[BussinessDetailTableViewCell alloc] init];
        cell0.BussinessDetailTableViewCellDelegate = self;
        cell0.picArr = [[NSMutableArray alloc] initWithArray:self.picturesArr1];
        IndexModel* model = nil;
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
        
    }
    BussinessDetail1TableViewCell* cell0 = [[BussinessDetail1TableViewCell alloc] init];
    BussinessDetail1Model* model = nil;
    cell0.BussinessDetail1TableViewCellDelegate = self;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return [MyController getScreenWidth] / 2;
    }
    
    BussinessDetail1Model* model = self.dataSource[indexPath.row];
    return [BussinessDetail1TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        BussinessDetail1TableViewCell *cell = (BussinessDetail1TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - 打电话代理
- (void)didselectTel{
    BussinessDetail1Model* model = [self.dataSource lastObject];
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString* str = [NSString stringWithFormat:@"tel:%@",model.tel];
    NSURL *telURL =[NSURL URLWithString:str];
    // 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
#pragma mark - 查看图片代理
- (void)didselectADPic:(NSInteger)index{
    [_photoBrowser setCurrentPhotoIndex:index];
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
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
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
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
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count){
        return [self.photos objectAtIndex:index];
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
