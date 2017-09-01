//
//  ZixunDetailViewController.m
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import "ZixunDetailViewController.h"

#import "ZiXunTableViewCell.h"

#import "SDTimeLineCellModel.h"

#import "ZixunDetailModel.h"

#import "ZixunDetailTableViewCell.h"

#import "ZixunDetail1TableViewCell.h"
@interface ZixunDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ZiXunTableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZixunDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详情";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f4f6fa"];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomView];
}

#pragma mark - 创建底部按钮
- (void)makeBottomView{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton* payBtn = [MyController createButtonWithFrame:CGRectMake([MyController getScreenWidth] - 95, 0, 95, 50) ImageName:nil Target:self Action:@selector(outBtnClick) Title:@"评论"];
    [payBtn setBackgroundColor:[MyController colorWithHexString:DEFTNAVCOLOR]];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:payBtn];
    
    UITextView* TV= [[UITextView alloc] initWithFrame:CGRectMake(10, 0, [MyController getScreenWidth] - 105, 50)];
    TV.placeholder = @"输入评论内容";
    [bottomView addSubview:TV];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [bottomView addSubview:lineV];
}

- (void)outBtnClick{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
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
    if (0 == section) {
        return self.dataArray.count;
    }
    NSArray* temA = self.dataSource[section - 1];
    return temA.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count + 1;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        ZiXunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZiXunTableViewCell"];
        cell.indexPath = indexPath;
        __weak typeof(self) weakSelf = self;
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            SDTimeLineCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        cell.delegate = self;
        
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        ///////////////////////////////////////////////////////////////////////
        
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
    if (0 == indexPath.row) {
        static NSString *cellIdentifier = @"ZixunDetailTableViewCell";
        ZixunDetailTableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell0) {
            cell0 = [[ZixunDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        ZixunDetailModel *model = nil;
        model = self.dataSource[indexPath.section - 1][indexPath.row];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell0 configCellWithModel:model];
        return cell0;
    }
    
    static NSString *cellIdentifier = @"ZixunDetail1TableViewCell";
    ZixunDetail1TableViewCell* cell0 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell0) {
        cell0 = [[ZixunDetail1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ZixunDetailModel *model = nil;
    model = self.dataSource[indexPath.section - 1][indexPath.row];
    cell0.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell0 configCellWithModel:model];
    return cell0;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
        id model = self.dataArray[indexPath.row];
        return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ZiXunTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }
    
    if (0 == indexPath.row) {
        ZixunDetailModel* model = self.dataSource[indexPath.section - 1][indexPath.row];
        return [ZixunDetailTableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
            ZixunDetailTableViewCell *cell = (ZixunDetailTableViewCell *)sourceCell;
            // 配置数据
            [cell configCellWithModel:model];
        }];
    }
    ZixunDetailModel* model = self.dataSource[indexPath.section - 1][indexPath.row];
    return [ZixunDetail1TableViewCell hyb_heightForTableView:_tableView config:^(UITableViewCell *sourceCell) {
        ZixunDetail1TableViewCell *cell = (ZixunDetail1TableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (CGFloat)cellContentViewWith{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


- (void)makeData{
    self.dataSource = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:1]];
    
    for (int i = 0; i < 3; i++) {
        NSMutableArray* _aa = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            ZixunDetailModel* model = [[ZixunDetailModel alloc] init];
            model._headImg = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1834568237,2092219970&fm=173&s=37BEA72A5A4554C0461BB2EF0300702D&w=218&h=146&img.JPG";
            model._name = @"大大卷";
            model._des = @"又一个夏天接近尾声，这意味";
            model._time = @"12:22";
            model._replyContent = @"皮卡丘：又一个夏天接近尾声，这意味着，料子偏厚的无袖裙子该开始穿了，不然又要闲置一年；润唇膏和护手霜差不多要开始涂，不然分分钟干死；趁着现在天气好应该抽空去拍几张像样的照片，留着相亲的时候拿出来用。";
            if (2 == i) {
                model.isLast = YES;
            }
            [_aa addObject:model];
        }
        
        [self.dataSource addObject:_aa];
    }
    [_tableView reloadData];
}

- (NSArray *)creatModelsWithCount:(NSInteger)count{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        SDTimeLineCellModel *model = [SDTimeLineCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            SDTimeLineCellLikeItemModel *model = [SDTimeLineCellLikeItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeItemsArray = [tempLikes copy];
        
        
        
        [resArr addObject:model];
    }
    return [resArr copy];
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
