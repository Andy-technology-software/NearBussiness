//
//  ProductDetailsViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ProductDetailsViewController.h"

#import "ProductDetails0Model.h"

#import "ProductDetails1Model.h"

#import "ProductDetails2Model.h"

#import "ProductDetails0TableViewCell.h"

#import "ProductDetails1TableViewCell.h"

#import "ProductDetails2TableViewCell.h"
@interface ProductDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,ProductDetails0TableViewCellDelegate,ProductDetails2TableViewCellDelegate,MWPhotoBrowserDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;
@property(nonatomic,retain)NSMutableArray* dataSource1;
@property(nonatomic,retain)NSMutableArray* dataSource2;

@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;
@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [[NSMutableArray alloc] init];
    self.dataSource1 = [[NSMutableArray alloc] init];
    self.dataSource2 = [[NSMutableArray alloc] init];

    self.title = @"商品详情";
    [self createTableView];
    
    [self createBottomView];
    
    [self makeData];
}

- (void)createBottomView{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    UIView* shareView = [MyController viewWithFrame:bottomView.frame];
    [bottomView addSubview:shareView];
    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    UIImageView* shareIV = [MyController createImageViewWithFrame:shareView.frame ImageName:@"shijian"];
    [shareView addSubview:shareIV];
    
    [shareIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerX.mas_equalTo(shareView);
    }];
    
    UILabel* shareLable = [MyController createLabelWithFrame:shareView.frame Font:10 Text:@"关注"];
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
        make.left.mas_equalTo(shareView.mas_right);
    }];
    
    
    
    UIView* foView = [MyController viewWithFrame:bottomView.frame];
    [bottomView addSubview:foView];
    
    [foView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    UIImageView* foIV = [MyController createImageViewWithFrame:shareView.frame ImageName:@"shijian"];
    [foView addSubview:foIV];
    
    [foIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.centerX.mas_equalTo(foView);
    }];
    
    UILabel* foLable = [MyController createLabelWithFrame:shareView.frame Font:10 Text:@"在线咨询"];
    [foView addSubview:foLable];
    
    [foLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(foIV.mas_bottom).mas_offset(3);
        make.centerX.mas_equalTo(foView);
    }];
    
    UIButton* zixunBtn = [MyController createButtonWithFrame:foView.frame ImageName:nil Target:self Action:@selector(zixunBtnClick) Title:nil];
    [bottomView addSubview:zixunBtn];
    
    [zixunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    UIView* chatView = [MyController viewWithFrame:bottomView.frame];
    chatView.backgroundColor = [MyController colorWithHexString:DEFTNAVCOLOR];
    [bottomView addSubview:chatView];
    
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(foView.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    
    UIButton* addCarBtn = [MyController createButtonWithFrame:chatView.frame ImageName:nil Target:self Action:@selector(addCarBtnClick) Title:@"加入购物车"];
    [addCarBtn setBackgroundColor:[MyController colorWithHexString:@"ffad16"]];
    [addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addCarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [chatView addSubview:addCarBtn];
    
    [addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(chatView.mas_centerX);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    UIButton* buyBtn = [MyController createButtonWithFrame:chatView.frame ImageName:nil Target:self Action:@selector(buyBtnClick) Title:@"购买"];
    [buyBtn setBackgroundColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [chatView addSubview:buyBtn];
    
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addCarBtn.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
}

#pragma mark - 加入购物车响应
- (void)addCarBtnClick{
    NSLog(@"加入购物车");
}

#pragma mark - 购买响应
- (void)buyBtnClick{
    NSLog(@"购买");
}

- (void)zixunBtnClick{
    SingleChatViewController* vc = [[SingleChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 50) style:UITableViewStylePlain];
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
    if (0 == section) {
        return self.dataSource.count;
    }else if (1 == section){
        return self.dataSource1.count;
    }
    return self.dataSource2.count;
}

#pragma mark - tableView组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        ProductDetails0TableViewCell* cell0 = [[ProductDetails0TableViewCell alloc] init];
        ProductDetails0Model *model = nil;
        cell0.ProductDetails0TableViewCellDelegate = self;
        model = [self.dataSource objectAtIndex:indexPath.row];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }else if (1 == indexPath.section) {
        ProductDetails1TableViewCell* cell0 = [[ProductDetails1TableViewCell alloc] init];
        ProductDetails1Model *model = nil;
        model = [self.dataSource1 objectAtIndex:indexPath.row];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }
    static NSString *cellIdentifier = @"ProductDetails2TableViewCell";
    ProductDetails2TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[ProductDetails2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell0.ProductDetails2TableViewCellDelegate = self;
    ProductDetails2Model *model = nil;
    model = [self.dataSource2 objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        ProductDetails0Model* model = self.dataSource[indexPath.row];
        return [ProductDetails0TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            ProductDetails0TableViewCell *cell = (ProductDetails0TableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section) {
        ProductDetails1Model* model = self.dataSource1[indexPath.row];
        return [ProductDetails1TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            ProductDetails1TableViewCell *cell = (ProductDetails1TableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }
    ProductDetails2Model* model = self.dataSource2[indexPath.row];
    return [ProductDetails2TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        ProductDetails2TableViewCell *cell = (ProductDetails2TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

#pragma mark - tableView头标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (2 == section) {
        UIView* tView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40)];
        tView.backgroundColor = [UIColor whiteColor];
        
        UILabel* titL = [MyController createLabelWithFrame:CGRectMake(10, 0, [MyController getScreenWidth] - 20, 40) Font:16 Text:@"商品详情:"];
        [tView addSubview:titL];
        
        return tView;
    }
    return nil;
}

#pragma mark - tableView头标题高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (2 == section) {
        return 40;
    }
    return 0;
}

- (void)makeData{
    ProductDetails0Model* model = [[ProductDetails0Model alloc] init];
    model._picArr = [[NSMutableArray alloc] initWithObjects:@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG",@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG",@"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG", nil];
    model._title = @"陈伟霆03年以歌手身份入行";
    model._price = @"998.0";
    [self.dataSource addObject:model];
    
    ProductDetails1Model* model1 = [[ProductDetails1Model alloc] init];
    model1._specification = @"1m * 3m";
    model1._introduction = @"陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆";
    [self.dataSource1 addObject:model1];
    
    for (int i = 0; i < 10; i++) {
        ProductDetails2Model* model2 = [[ProductDetails2Model alloc] init];
        model2._image = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model2._des = @"陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆03年以歌手身份入行陈伟霆陈伟霆";
        [self.dataSource2 addObject:model2];
    }
    [_tableView reloadData];
}

#pragma mark - 选中广告图
- (void)didselectADPic:(NSInteger)index{
    self.photos = [[NSMutableArray alloc] init];
    ProductDetails0Model* model0 = [self.dataSource lastObject];
    for (NSString* pic in model0._picArr) {
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pic]]];
    }

    [_photoBrowser setCurrentPhotoIndex:index];
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}
#pragma mark - 选中产品图
- (void)didselectProPic:(NSInteger)index{
    self.photos = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataSource2.count; i++) {
        ProductDetails2Model* model2 = self.dataSource2[i];
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:model2._image]]];
    }
    
    [_photoBrowser setCurrentPhotoIndex:index];
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}
#pragma mark - 选中分享
- (void)didselectShare{
    NSLog(@"分享");
    CLAnimationView *animationView = [[CLAnimationView alloc]initWithTitleArray:@[@"微信好友",@"朋友圈",@"QQ好友"] picarray:@[@"shijian",@"shijian",@"shijian"]];
    [animationView selectedWithIndex:^(NSInteger index) {
        NSLog(@"你选择的index ＝＝ %ld",(long)index);
        if (1 == index) {
            
        }else if (2 == index){
            
        }else if (3 == index){
            
        }
    }];
    [animationView CLBtnBlock:^(UIButton *btn) {
        NSLog(@"你点了选择/取消按钮");
    }];
    [animationView show];
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
