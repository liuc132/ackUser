//
//  MyTaskViewController.m
//  ackUser
//
//  Created by LiuC on 16/11/27.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MyTaskViewController.h"
#import "ackUserPCH.pch"
#import "MyTaskListView.h"
#import "UIColor+HexColor.h"
#import "TaskListsModel.h"
#import "UIImageView+WebCache.h"
#import "HTTPRequest.h"
#import "Masonry.h"


@interface MyTaskViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIImageView           *navigationImageView;

@property (strong, nonatomic) UITableView           *myTasksTableView;

@property (strong, nonatomic) HTTPRequest           *myTasksSession;

@property (strong, nonatomic) NSMutableArray        *allTasksInfoArray;

@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self dataInitialization];
    [self findNavigationBarDownLine];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self settingNavBar];
    
}


#pragma mark - privateMethod

- (void)networkInitialization
{
    _myTasksSession = [HTTPRequest sharedManager];
    
}

- (void)dataInitialization
{
    _allTasksInfoArray = [[NSMutableArray alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [_myTasksSession getMyTasksWithURLWithParameter:nil Success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",finish);
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSArray *carsArray = finish[@"rows"];
            
            [strongSelf filterTasksListWithResult:carsArray];
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            
        }
        
    } failure:^(NSError *reqError) {
        
        
        
    }];
}

- (void)filterTasksListWithResult:(NSArray *)resultArray
{
    //清除所有旧的车辆信息数据
    [_allTasksInfoArray removeAllObjects];
    
    for (NSDictionary *eachCar in resultArray) {
        TaskListsModel *eachCarInfo = [[TaskListsModel alloc] init];
        NSString *brand = eachCar[@"taskId"];
        if ([brand isEqual:[NSNull null]]) {
            eachCarInfo.taskId = @"";
        }
        else
        {
            eachCarInfo.taskId = brand;
        }
        NSString *plate = eachCar[@"plate"];
        if ([plate isEqual:[NSNull null]]) {
            eachCarInfo.plate = @"";
        }
        else
        {
            eachCarInfo.plate = plate;
        }
        NSString *taskStatus = eachCar[@"taskStatus"];
        if ([taskStatus isEqual:[NSNull null]]) {
            eachCarInfo.taskStatus = @"";
        }
        else
        {
            eachCarInfo.taskStatus = taskStatus;
        }
        NSString *taskStatusValue = eachCar[@"taskStatusValue"];
        if ([taskStatusValue isEqual:[NSNull null]]) {
            eachCarInfo.taskStatusValue = @"";
        }
        else
        {
            eachCarInfo.taskStatusValue = taskStatusValue;
        }
        NSString *storeStatus = eachCar[@"storeStatus"];
        if ([storeStatus isEqual:[NSNull null]]) {
            eachCarInfo.storeStatus = @"";
        }
        else
        {
            eachCarInfo.storeStatus = storeStatus;
        }
        NSString *storeValue = eachCar[@"storeValue"];
        if ([storeValue isEqual:[NSNull null]]) {
            eachCarInfo.storeValue = @"";
        }
        else
        {
            eachCarInfo.storeValue = storeValue;
        }
        NSString *taskEndTime = eachCar[@"taskEndTime"];
        if ([taskEndTime isEqual:[NSNull null]]) {
            eachCarInfo.taskEndTime = @"";
        }
        else
        {
            eachCarInfo.taskEndTime = taskEndTime;
        }
        NSString *advName = eachCar[@"advName"];
        if ([advName isEqual:[NSNull null]]) {
            eachCarInfo.advName = @"";
        }
        else
        {
            eachCarInfo.advName = advName;
        }
        NSString *advDesc = eachCar[@"advDesc"];
        if ([advDesc isEqual:[NSNull null]]) {
            eachCarInfo.advDesc = @"";
        }
        else
        {
            eachCarInfo.advDesc = advDesc;
        }
        NSString *advPrice = eachCar[@"advPrice"];
        if ([advPrice isEqual:[NSNull null]]) {
            eachCarInfo.advPrice = @"";
        }
        else
        {
            eachCarInfo.advPrice = advPrice;
        }
        NSString *installTime = eachCar[@"installTime"];
        if ([installTime isEqual:[NSNull null]]) {
            eachCarInfo.installTime = @"";
        }
        else
        {
            eachCarInfo.installTime = installTime;
        }
        NSString *installTimes = eachCar[@"installTimes"];
        if ([installTimes isEqual:[NSNull null]]) {
            eachCarInfo.installTimes = @"";
        }
        else
        {
            eachCarInfo.installTimes = installTimes;
        }
        NSString *checkTime = eachCar[@"checkTime"];
        if ([checkTime isEqual:[NSNull null]]) {
            eachCarInfo.checkTime = @"";
        }
        else
        {
            eachCarInfo.checkTime = checkTime;
        }
        NSString *province = eachCar[@"province"];
        if ([province isEqual:[NSNull null]]) {
            eachCarInfo.province = @"";
        }
        else
        {
            eachCarInfo.province = province;
        }
        NSString *city = eachCar[@"city"];
        if ([city isEqual:[NSNull null]]) {
            eachCarInfo.city = @"";
        }
        else
        {
            eachCarInfo.city = city;
        }
        NSString *area = eachCar[@"area"];
        if ([area isEqual:[NSNull null]]) {
            eachCarInfo.area = @"";
        }
        else
        {
            eachCarInfo.area = area;
        }
        NSString *address = eachCar[@"address"];
        if ([address isEqual:[NSNull null]]) {
            eachCarInfo.address = @"";
        }
        else
        {
            eachCarInfo.address = address;
        }
        NSString *longitude = eachCar[@"longitude"];
        if ([longitude isEqual:[NSNull null]]) {
            eachCarInfo.longitude = @"";
        }
        else
        {
            eachCarInfo.longitude = longitude;
        }
        NSString *latitude = eachCar[@"latitude"];
        if ([latitude isEqual:[NSNull null]]) {
            eachCarInfo.latitude = @"";
        }
        else
        {
            eachCarInfo.latitude = latitude;
        }
        NSString *advImg = eachCar[@"advImg"];
        if ([advImg isEqual:[NSNull null]]) {
            eachCarInfo.advImg = @"";
        }
        else
        {
            eachCarInfo.advImg = advImg;
        }
        
        //添加车辆信息到数组中
        [_allTasksInfoArray addObject:eachCarInfo];
    }
    [self customCreateMyTask];
    
    [_myTasksTableView reloadData];
}

-(void)customCreateMyTask
{
    if (_myTasksTableView == nil) {
        _myTasksTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTasksTableView.delegate = self;
        _myTasksTableView.dataSource = self;
        [self.view addSubview:_myTasksTableView];
        [_myTasksTableView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}


- (void)findNavigationBarDownLine
{
    UIImageView *navigationImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.navigationImageView = navigationImageView;
}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(myCarToPersonalCenterVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.navigationItem.title = @"我的任务";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //NSFontAttributeName
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

/**
 左侧导航按钮对应的action
 */
- (void)myCarToPersonalCenterVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 我的任务状态 (1, "待安装" 2, "安装待审核" 3, "待自检" 4, "自检待审核" 5, "发布中" 6, "安装关闭" 7, "已结束" 8, "逾期关闭" 9, "任务已终止" 10, "终止申请中" 11, "已取消" 12, "申述待审核" 13, "逾期安装")
 待安装           #ffa022  黄色
 安装待审核
 
 待自检           #f9503b  红色
 自检待审核
 
 发布中           #7aaa3d  绿色
 
 安装关闭         #7d8182  灰色
 已结束
 逾期关闭
 任务已终止
 
 终止申请中       #516192  蓝色
 已取消
 */
- (void)statusLabelBackgroundColorWithStatusValue:(NSInteger)status widget:(UILabel *)widget
{
    switch (status) {
        case 1:
        case 2:
            [widget setBackgroundColor:[UIColor colorFromHexString:@"#ffa022" alpha:1.0]];
            break;
        case 3:
        case 4:
            [widget setBackgroundColor:[UIColor colorFromHexString:@"#f9503b" alpha:1.0]];
            break;
        case 5:
            [widget setBackgroundColor:[UIColor colorFromHexString:@"#7aaa3d" alpha:1.0]];
            break;
        case 6:
        case 7:
        case 8:
        case 9:
            [widget setBackgroundColor:[UIColor colorFromHexString:@"#7d8182" alpha:1.0]];
            break;
        case 10:
        case 11:
            [widget setBackgroundColor:[UIColor colorFromHexString:@"#516192" alpha:1.0]];
        default:
            break;
    }
}

/**
 判断是跳转到那个界面我的任务状态 (1, "待安装" 2, "安装待审核" 3, "待自检" 4, "自检待审核" 5, "发布中" 6, "安装关闭" 7, "已结束" 8, "逾期关闭" 9, "任务已终止" 10, "终止申请中" 11, "已取消" 12, "申述待审核" 13, "逾期安装")
 待执行：待安装，安装待审核，
 执行中：待自检，自检待审核，发布中，中止待审核，
 已结束：任务取消，逾期自检，逾期安装，申述待审核，任务中止，任务结束

 @param status status 当前状态值
 */
- (void)jumpToTaskDetailWithStatus:(NSInteger)status
{
    switch (status) {
        case 1:
        case 2:
            
            break;
            
        case 3:
        case 4:
        case 5:
        
            
            break;
            
        case 7:
        case 9:
        case 12:
            
            break;
            
        default:
            break;
    }
}


#pragma mark -UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld",indexPath.section);
    TaskListsModel *currentTaskData= _allTasksInfoArray[indexPath.section];
    
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"mytaskToTaskGoingVC" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"taskListToWillHandle" sender:nil];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allTasksInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.section == 0) {
        return 200.0;
    }
    else
    {
        return 160.0;
    }*/
    return 160.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    else
    {
        return 10.0;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%ld",indexPath.section];
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MyTaskListView *taskListView = [[MyTaskListView alloc] init];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
        [tableCell addSubview:taskListView];
        [taskListView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
        taskListView.myTaskStatusLabel.text = @"待安装";
        taskListView.myTaskSeparetedView.hidden = NO;
        taskListView.myTaskNoticeLabel.hidden = YES;
        taskListView.myTaskCoinLabel.hidden = NO;
//        taskListView.myTaskNoticeLabel.text = @"任务最新公告由于国家最新政策。。。";
        
        /*
        if (indexPath.section == 0) {
            MyTaskListView *taskListView = [[MyTaskListView alloc] init];
            [tableCell addSubview:taskListView];
            [taskListView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
            taskListView.myTaskStatusLabel.text = @"待安装";
            taskListView.myTaskSeparetedView.hidden = NO;
            taskListView.myTaskNoticeLabel.hidden = NO;
            taskListView.myTaskCoinLabel.hidden = YES;
            taskListView.myTaskNoticeLabel.text = @"任务最新公告由于国家最新政策。。。";
            
            
        }
        
        else if (indexPath.section == 1)
        {
            MyTaskListView *taskListView = [[MyTaskListView alloc] init];
            [tableCell addSubview:taskListView];
            [taskListView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#f8513a" alpha:1.0];
            taskListView.myTaskStatusLabel.text = @"待自检";
            taskListView.myTaskSeparetedView.hidden = YES;
            taskListView.myTaskNoticeLabel.hidden = YES;
            
        }
        
        else if (indexPath.section == 2)
        {
            MyTaskListView *taskListView = [[MyTaskListView alloc] init];
            [tableCell addSubview:taskListView];
            [taskListView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#79aa3d" alpha:1.0];
            taskListView.myTaskStatusLabel.text = @"发布中";
            taskListView.myTaskSeparetedView.hidden = YES;
            taskListView.myTaskNoticeLabel.hidden = YES;
            
        }
        
        else if(indexPath.section == 3)
        {
            MyTaskListView *taskListView = [[MyTaskListView alloc] init];
            [tableCell addSubview:taskListView];
            [taskListView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#7c8180" alpha:1.0];
            taskListView.myTaskStatusLabel.text = @"已结束";
            taskListView.myTaskSeparetedView.hidden = YES;
            taskListView.myTaskNoticeLabel.hidden = YES;
            
        }
        
        else if(indexPath.section == 4)
        {
            MyTaskListView *taskListView = [[MyTaskListView alloc] init];
            [tableCell addSubview:taskListView];
            [taskListView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            [taskListView.myTaskStatusLabel updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@105);
            }];
            
            taskListView.myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#516291" alpha:1.0];
            taskListView.myTaskStatusLabel.text = @"中止申请中";
            taskListView.myTaskSeparetedView.hidden = YES;
            taskListView.myTaskNoticeLabel.hidden = YES;
            taskListView.myTaskCoinLabel.hidden = YES;
            taskListView.myTaskTimeLabel.text = @"30000币";
            
        }
        */
        
    }
    
    TaskListsModel *eachTaskData= _allTasksInfoArray[indexPath.section];
    
    NSString *statusString = [NSString stringWithFormat:@"%@",eachTaskData.taskStatusValue];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],};
    CGSize textSize = [statusString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    taskListView.myTaskStatusLabel.text = statusString;
    [taskListView.myTaskStatusLabel updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(textSize.width+30));
    }];
    NSString *taskStatusId = [NSString stringWithFormat:@"%@",eachTaskData.taskStatus];
    [self statusLabelBackgroundColorWithStatusValue:[taskStatusId integerValue] widget:taskListView.myTaskStatusLabel];
    [taskListView.myTaskADImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",eachTaskData.advImg] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"icon_home_LatestAD"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            taskListView.myTaskADImageView.image = image;
        }
    }];
    taskListView.myTaskNameLabel.text = [NSString stringWithFormat:@"%@",eachTaskData.advName];
    taskListView.myTaskPlateNumLabel.text = [NSString stringWithFormat:@"%@",eachTaskData.plate];
    taskListView.myTaskCoinLabel.text = [NSString stringWithFormat:@"%@币",eachTaskData.advPrice];
    taskListView.myTaskTimeLabel.text = [NSString stringWithFormat:@"自检时间:%@",eachTaskData.checkTime];
    taskListView.myTaskAddressOrEndTimeLabel.text = [NSString stringWithFormat:@"结束日期:%@",eachTaskData.taskEndTime];
    
    
    tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return tableCell;
}


#pragma mark  -memoryWarning;
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
