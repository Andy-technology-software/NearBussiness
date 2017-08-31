//
//  MineViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/7/4.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "MineViewController.h"

#import "MineIndex0Model.h"

#import "MineIndex0TableViewCell.h"

#import "MyOrderViewController.h"

#import "BuyCarViewController.h"

#import "FundManagementViewController.h"

#import "SeetingCenterViewController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MineIndex0TableViewCellDelegate,ImagePickerSheetViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
    self.dataSource = [[NSMutableArray alloc] init];
    [self createTableView];
    [self makeData];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f4faf6"];
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

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MineIndex0TableViewCell";
    MineIndex0TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[MineIndex0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell0.MineIndex0TableViewCellDelegate = self;
    MineIndex0Model *model = nil;
    model = [self.dataSource objectAtIndex:indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineIndex0Model* model = self.dataSource[indexPath.row];
    return [MineIndex0TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        MineIndex0TableViewCell *cell = (MineIndex0TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (void)makeData{
    MineIndex0Model* model0 = [[MineIndex0Model alloc] init];
    model0._name = @"皮卡丘";
    model0._img = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1102144067,3060480730&fm=173&s=10B95296B8427B4568038ABB0300E00B&w=502&h=320&img.JPEG";
    model0._tel = @"商号：8888";
    [self.dataSource addObject:model0];
    
    [_tableView reloadData];
}

- (void)didselectHeadImg{
    NSLog(@"选头像");
    ImagePickerSheetViewController *imagePicker = [[ImagePickerSheetViewController alloc] init];
    imagePicker.maximumNumberOfSelection = 1;
    imagePicker.delegate = self;
    //使用内置相册回调使用内置相册回调
    imagePicker.photoLabrary = ^(LFImagePickerController *lf_imagePicker) {
        lf_imagePicker.allowTakePicture = NO;
        lf_imagePicker.allowPickingVideo = NO;
        lf_imagePicker.doneBtnTitleStr = @"发送";
    };
    
    //发送图片block，回调回两组数组，一组压缩图片数组，一组原图数组
    imagePicker.imagePickerSheetVCSendImageBlock = ^(NSArray *thumbnailImages, NSArray *originalImages) {
        NSData *data = UIImageJPEGRepresentation([originalImages lastObject], 1.0f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [HUD loading];
//        [self changeHeadImage:encodedImageStr];
    };
    
    //拍照发送，回调回图片
    imagePicker.imagePickerSheetVCPhotoSendImageBlock = ^(UIImage *image) {
        NSData *_data = UIImageJPEGRepresentation(image, 0.01);
        NSString* encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        [HUD loading];
//        [self changeHeadImage:encodedImageStr];
    };
    
    [imagePicker showImagePickerInController:self animated:YES];
}

- (void)sendBackBottonIndex:(NSInteger)itemIndex{
    NSLog(@"底部---%ld",itemIndex);
    if (0 == itemIndex) {
        FundManagementViewController* vc = [[FundManagementViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (2 == itemIndex){
        SeetingCenterViewController* vc = [[SeetingCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sendBackTopIndex:(NSInteger)itemIndex{
    NSLog(@"顶部---%ld",itemIndex);
    if(2 == itemIndex){
        MyOrderViewController* vc = [[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didselectBuycar{
    NSLog(@"购物车");
    BuyCarViewController* vc = [[BuyCarViewController alloc] init];
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
