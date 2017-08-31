//
//  LocationMapViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/8/15.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "LocationMapViewController.h"

#import "LocationMapModel.h"

#import "LocationMapTableViewCell.h"
@interface LocationMapViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;

@property(nonatomic,strong)UIView* bgHeaderView;
@property(nonatomic,strong)UIView* whiteBgView;

@property(nonatomic,strong)UITextField* sTextfield;

@property(nonatomic,strong)AMapLocationManager* locationManager;
@property(nonatomic,strong)AMapSearchAPI* search;

@property(nonatomic,assign)CGFloat latitu;
@property(nonatomic,assign)CGFloat longit;

@property(nonatomic,copy)NSString* keyword;
@property(nonatomic,copy)NSString* jingdu;
@property(nonatomic,copy)NSString* weidu;

@end

@implementation LocationMapViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"位置";
    
    [self createTableView];
    
    [self makeLocat];
    
    [self makeRightNavBtn];
}

#pragma mark - 创建导航右按钮
- (void)makeRightNavBtn{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,27)];
    [rightButton1 setTitle:@"确定" forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightButton1 addTarget:self action:@selector(editBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    self.navigationItem.rightBarButtonItem= rightItem1;
}

#pragma mark - 编辑按钮响应
- (void)editBtnClick{
    NSLog(@"确定");
    for (int i = 0; i < self.dataSourceArr.count; i++) {
        LocationMapModel* model = self.dataSourceArr[i];
        if (model.isSelect) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.LocationMapViewControllerDelegate sendBackSelectAddName:model.name jingdu:model.jingdu weidu:model.weidu];
            break;
        }
        if (i == self.dataSourceArr.count - 1) {
            [HUD warning:@"请选择位置"];
        }
    }
}

/**
 定位一次
 */
- (void)makeLocat{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.latitu = location.coordinate.latitude;
    self.longit = location.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    [self makeSearch:@""];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
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
    for (int i = 0 ; i < self.dataSourceArr.count; i++) {
        LocationMapModel* model = self.dataSourceArr[i];
        if (i == indexPath.row) {
            model.isSelect = YES;
        }else{
            model.isSelect = NO;
        }
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"LocationMapTableViewCell";
    LocationMapTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[LocationMapTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    LocationMapModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationMapModel* model = self.dataSourceArr[indexPath.row];
    return [LocationMapTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        LocationMapTableViewCell *cell = (LocationMapTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.bgHeaderView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenWidth] * 25 / 64)];
    self.bgHeaderView.backgroundColor = [MyController colorWithHexString:DEFAULTBGCOLOR];
    
    self.sTextfield = [MyController createTextFieldWithFrame:self.view.frame placeholder:@"搜索城市名或地区" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.sTextfield.text = self.keyword;
    self.sTextfield.backgroundColor = [MyController colorWithHexString:@"eff0f2"];
    self.sTextfield.delegate = self;
    self.sTextfield.returnKeyType = UIReturnKeySearch;
    [self.bgHeaderView addSubview:self.sTextfield];
    //将图层的边框设置为圆脚
    self.sTextfield.layer.cornerRadius = 12;
    self.sTextfield.layer.masksToBounds = YES;
    [self.sTextfield setContentMode:UIViewContentModeScaleAspectFill];
    self.sTextfield.clipsToBounds = YES;
    self.sTextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.sTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    [self.sTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_offset(30);
    }];
    
    self.whiteBgView = [MyController viewWithFrame:self.view.frame];
    self.whiteBgView.backgroundColor = [UIColor whiteColor];
    [self.bgHeaderView addSubview:self.whiteBgView];
    
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.sTextfield.mas_bottom).mas_offset(15);
        make.bottom.mas_equalTo(self.bgHeaderView.mas_bottom);
    }];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    [_mapView setZoomLevel:15.1 animated:YES];
    [self.whiteBgView addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.whiteBgView.mas_bottom);
    }];
    
    return self.bgHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [MyController getScreenWidth] * 25 / 32;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"搜索：%@",textField.text);
    self.keyword = textField.text;
    [textField resignFirstResponder];
    [self makeSearch:textField.text];
    return YES;
    
}
/**
 开始周边检索
 
 @param searchText 检索关键字
 */
- (void)makeSearch:(NSString*)searchText{
    [AMapServices sharedServices].apiKey = MAPKEY;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:self.latitu longitude:self.longit];
    request.keywords            = searchText;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.radius = 1000;
    [self.search AMapPOIAroundSearch:request];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0){
        [HUD error:@"您搜索的信息可能不在范围内"];
        [self.dataSourceArr removeAllObjects];
        [_tableView reloadData];
        return;
    }
    NSLog(@"%@",response.pois);
    self.dataSourceArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < response.pois.count; i++) {
        NSLog(@"%@----%@\n",response.pois[i].name,response.pois[i].address);
        LocationMapModel* model = [[LocationMapModel alloc] init];
        model.name = response.pois[i].name;
//        model.rname = response.pois[i].address;
        model.jingdu = [NSString stringWithFormat:@"%f",response.pois[i].location.longitude];
        model.weidu = [NSString stringWithFormat:@"%f",response.pois[i].location.latitude];
        [self.dataSourceArr addObject:model];
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
