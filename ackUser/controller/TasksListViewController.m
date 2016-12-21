//
//  TasksListViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TasksListViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "TasksListView.h"
#import "HTTPRequest.h"
#import "GetTaskListsModel.h"
#import "Masonry.h"


@interface TasksListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView       *taskListTableView;
@property (strong, nonatomic) UIImageView       *navigationImageView;

@property (strong, nonatomic) HTTPRequest       *taskListsSessionManager;
@property (strong, nonatomic) NSMutableArray    *AdvTasksInfoArray;


@end

@implementation TasksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self findNavigationBarDownLine];
    [self customTasksListView];
    
    [self networkInitialization];
    [self dataInitialization];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _taskListsSessionManager = [HTTPRequest sharedManager];
}

- (void)dataInitialization
{
    __weak typeof(self) weakSelf = self;
    _AdvTasksInfoArray = [[NSMutableArray alloc] init];
    [_taskListsSessionManager getHomeAdvTaskListsWithParameter:nil success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == TokenExpired) {
            
        }
        else if ([finish[@"code"] integerValue] == RequestSuccess)
        {
            [strongSelf filterCarsListWithResult:finish[@""]];
        }
        
    } failure:^(NSError *reqError) {
        
    }];
}

- (void)filterCarsListWithResult:(NSArray *)results
{
    //清除所有旧的广告任务信息数据
    [_AdvTasksInfoArray removeAllObjects];
    
    for (NSDictionary *eachCar in results) {
        
        
        //添加广告任务信息到数组中
        [_AdvTasksInfoArray addObject:eachCar];
    }
    
    [_taskListTableView reloadData];
    
}

- (void)customTasksListView
{
    _taskListTableView = [UITableView new];
    _taskListTableView.delegate = self;
    _taskListTableView.dataSource = self;
    [self.view addSubview:_taskListTableView];
    [_taskListTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(taskListBackToTaskList)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"任务领取";
    
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
- (void)taskListBackToTaskList
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getTaskAction:(UIButton *)sender
{
    NSLog(@"立即领取任务....");
    [self performSegueWithIdentifier:@"taskListToTaskDetail" sender:nil];
    
    
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.Row:%ld",indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        TasksListView *tasksView = [[TasksListView alloc] init];
        [tableCell addSubview:tasksView];
        [tasksView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        if (indexPath.row <= 1) {
            /*
            tasksView.taskAckCoinView.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
            tasksView.taskDeadTimeView.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
            tasksView.taskPeriodLabel.textColor = [UIColor colorFromHexString:@"#1a1a1a" alpha:1.0];
            tasksView.taskRemainedQuotasLabel.textColor = [UIColor colorFromHexString:@"#1a1a1a" alpha:1.0];
            tasksView.taskRemainedQuotasLabel.text = @"0";
            UIImage *taskADImage = [UIImage imageNamed:@"icon_home_LatestAD"];
            tasksView.taskADImageView.image = [taskADImage imageWithColor:[UIColor colorFromHexString:@"#cdcdcd" alpha:1.0]];
            [tasksView.taskGetButton setImage:[UIImage imageNamed:@"icon_taskList_getCompleted"] forState:UIControlStateNormal];
            */
            [tasksView.taskGetButton addTarget:self action:@selector(getTaskAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        else
        {
            tasksView.taskAckCoinView.backgroundColor = [UIColor colorFromHexString:@"#7d8281" alpha:1.0];
            tasksView.taskDeadTimeView.backgroundColor = [UIColor colorFromHexString:@"#7d8281" alpha:1.0];
            [tasksView.taskDeadTimeView updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@70);
            }];
            
            tasksView.taskPeriodLabel.textColor = [UIColor colorFromHexString:@"#1a1a1a" alpha:1.0];
            tasksView.taskRemainedQuotasLabel.textColor = [UIColor colorFromHexString:@"#1a1a1a" alpha:1.0];
            tasksView.taskRemainedQuotasLabel.text = @"0";
//            UIImage *taskADImage = [UIImage imageNamed:@"icon_home_LatestAD"];
//            tasksView.taskADImageView.image = [taskADImage imageWithColor:[UIColor colorFromHexString:@"#cdcdcd" alpha:1.0]];
            tasksView.taskDeadTimeLabel.text = @"招募结束";
            [tasksView.taskGetButton setImage:[UIImage imageNamed:@"icon_taskList_getCompleted"] forState:UIControlStateNormal];
            tasksView.taskNewIconImageView.hidden = YES;
        }
        
    }
    
    tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setTableFooterView:[[UIView alloc]init]];
    //
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([_taskListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_taskListTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_taskListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_taskListTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma mark memoryWarning
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
