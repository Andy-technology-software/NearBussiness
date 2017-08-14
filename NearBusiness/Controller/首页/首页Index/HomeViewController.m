//
//  HomeViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/7/4.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "HomeViewController.h"

#import "IndexModel.h"

#import "IndexViewTableViewCell.h"

#import "Index1Model.h"

#import "Index1TableViewCell.h"

#import "BussinessRecommendationModel.h"

#import "BussinessRecommendationTableViewCell.h"

#import "BussinessSearchViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,IndexViewCellDelegate,MWPhotoBrowserDelegate,Index1TableViewCellDelegate>{
    UITableView* _tableView;
}
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;

@property(nonatomic,retain)NSMutableArray* picturesArr;
@property(nonatomic,retain)NSMutableArray* picturesArr1;

@property(nonatomic,retain)NSMutableArray* dataSource1;
@property(nonatomic,retain)NSMutableArray* dataSource2;
@property(nonatomic,retain)NSMutableArray* dataSource3;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.picturesArr = [[NSMutableArray alloc] init];
    self.picturesArr1 = [[NSMutableArray alloc] init];
    self.photos = [[NSMutableArray alloc] init];
    self.dataSource1 = [[NSMutableArray alloc] init];
    self.dataSource2 = [[NSMutableArray alloc] init];
    self.dataSource3 = [[NSMutableArray alloc] init];
    [self createTableView];
    
    [self getIndexBannder];
    
    [self getClassType];
    
    [self makeData];
}

- (void)makeData{
    for (int i = 0; i < 2; i++) {
        BussinessRecommendationModel* model = [[BussinessRecommendationModel alloc] init];
        model.img = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=100547500,2169487315&fm=175&s=A7DB33D743605D175BD9F06A03007071&w=600&h=352&img.JPEG";
        model.name = @"陈伟霆03年以歌手身份入行";
        model.des = @"组过组合，出过专辑，演过电影，获过 “最受欢迎男新人金奖”、 “最有前途新人金奖”，却一直半红不黑，直到2014年在《古剑奇谭》中饰演大师兄陵越迅速蹿红，成功摘掉了万年新人王的帽子";
        model.distance = @"<200M";
        model.isRedPack = YES;
        [self.dataSource2 addObject:model];
        [self.dataSource3 addObject:model];
    }
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSIndexSet *indexSet1=[[NSIndexSet alloc]initWithIndex:3];
    [_tableView reloadSections:indexSet1 withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark - 请求-获取分类
- (void)getClassType {
    Index1Model* index1Model = [[Index1Model alloc] init];
    index1Model.hangyeIdArr = [[NSMutableArray alloc] init];
    index1Model.hangyeImgArr = [[NSMutableArray alloc] init];
    index1Model.hangyeNameArr = [[NSMutableArray alloc] init];

    [requestService postClassTypeWithUserId:@"" Pnum:@"1" Num:@"1000" complate:^(id responseObject) {
        NSString *dataStr = [responseObject objectForKey:@"data"];
        NSLog(@"%@",dataStr);
        NSArray *dataArr  = [MyController arraryWithJsonString:dataStr];
        for (NSDictionary *dic in dataArr) {
            if (![@"不限" isEqualToString:dic[@"name"]] && ![@"会展行业" isEqualToString:dic[@"name"]]) {
                [index1Model.hangyeNameArr addObject:dic[@"name"]];
                [index1Model.hangyeIdArr addObject:dic[@"id"]];
                [index1Model.hangyeImgArr addObject:dic[@"img"]];
            }
        }
        [self.dataSource1 addObject:index1Model];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
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
        return 1;
    }else if (1 == section){
        return self.dataSource1.count;
    }else if (2 == section){
        return self.dataSource2.count;
    }
    return self.dataSource3.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
//        static NSString *cellIdentifier = @"CellIdentifier";
//        IndexViewTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (!cell0) {
//            cell0 = [[IndexViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
        IndexViewTableViewCell* cell0 = [[IndexViewTableViewCell alloc] init];
        cell0.IndexViewCellDelegate = self;
        cell0.picArr = [[NSMutableArray alloc] initWithArray:self.picturesArr1];
        IndexModel* model = nil;
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }else if (1 == indexPath.section) {
//        static NSString *cellIdentifier = @"Index1TableViewCell";
//        Index1TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (!cell0) {
//            cell0 = [[Index1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
        Index1TableViewCell* cell0 = [[Index1TableViewCell alloc] init];
        cell0.Index1TableViewCellDelegate = self;
        Index1Model *model = nil;
        model = [self.dataSource1 objectAtIndex:indexPath.row];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }else if (2 == indexPath.section) {
        static NSString *cellIdentifier = @"BussinessRecommendationTableViewCell";
        BussinessRecommendationTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell0) {
            cell0 = [[BussinessRecommendationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        BussinessRecommendationModel *model = nil;
        model = [self.dataSource2 objectAtIndex:indexPath.row];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }
    
    static NSString *cellIdentifier = @"BussinessRecommendationTableViewCell1";
    BussinessRecommendationTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[BussinessRecommendationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    BussinessRecommendationModel *model = nil;
    model = [self.dataSource3 objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return [MyController getScreenWidth] * 5/8;
    }else if (1 == indexPath.section){
        Index1Model* model = self.dataSource1[indexPath.row];
        return [Index1TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            Index1TableViewCell *cell = (Index1TableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }else if (2 == indexPath.section){
        BussinessRecommendationModel* model = self.dataSource2[indexPath.row];
        return [BussinessRecommendationTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            BussinessRecommendationTableViewCell *cell = (BussinessRecommendationTableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }
    
    BussinessRecommendationModel* model = self.dataSource3[indexPath.row];
    return [BussinessRecommendationTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        BussinessRecommendationTableViewCell *cell = (BussinessRecommendationTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}
#pragma mark - tableView头视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (2 == section || 3 == section) {
        UIView* bgView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UILabel* titleLable = [MyController createLabelWithFrame:bgView.frame Font:14 Text:nil];
        [bgView addSubview:titleLable];
        if (2 == section) {
            titleLable.text = @"商家推荐";
        }else{
            titleLable.text = @"附近商家";
        }
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.height.mas_offset(40);
        }];
        
        UIImageView* rIV = [MyController createImageViewWithFrame:bgView.frame ImageName:@"shezhigengduo"];
        [bgView addSubview:rIV];
        
        [rIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(bgView);
            make.height.mas_offset(15);
            make.width.mas_offset(15);
        }];
        
        UILabel* rtitleLable = [MyController createLabelWithFrame:bgView.frame Font:14 Text:@"更多商家"];
        rtitleLable.textColor = [UIColor lightGrayColor];
        [bgView addSubview:rtitleLable];
        
        [rtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rIV.mas_left).mas_offset(-5);
            make.top.mas_equalTo(0);
            make.height.mas_offset(40);
        }];

        UIView* lineView = [MyController viewWithFrame:bgView.frame];
        lineView.backgroundColor = [MyController colorWithHexString:@"f0f0f0"];
        [bgView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(bgView.mas_bottom).mas_offset(-0.5);
            make.height.mas_offset(0.5);
        }];
        
        UIButton* moreBtn = [MyController createButtonWithFrame:bgView.frame ImageName:nil Target:self Action:@selector(moreBtnClick:) Title:nil];
        moreBtn.tag = 200 + section;
        [bgView addSubview:moreBtn];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_offset(40);
        }];
        
        return bgView;
    }
    return nil;
}

#pragma mark - tableView头标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (2 == section || 3 == section) {
        return 40;
    }
    return 0;
}

#pragma mark - 查看更多按钮响应
- (void)moreBtnClick:(UIButton*)btn {
    if (202 == btn.tag) {
        NSLog(@"推荐商家");
    }else{
        NSLog(@"附近商家");
    }
    BussinessSearchViewController* vc = [[BussinessSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 查看图片代理
- (void)didselectADPic:(NSInteger)index{
    [_photoBrowser setCurrentPhotoIndex:index];
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
}

#pragma mark - 选中分类代理
- (void)sendBanckSeleCalssIndex:(NSInteger)classIndex{
    NSLog(@"选中---%ld",classIndex);
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
