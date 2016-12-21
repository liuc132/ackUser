//
//  TaskSelfCheckViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskSelfCheckViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "SelfCheckView.h"
#import "Masonry.h"

@interface TaskSelfCheckViewController ()

@property (strong, nonatomic) SelfCheckView         *taskSelfCheckView;

@end

@implementation TaskSelfCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNavBar];
    [self customCreateWillHandleView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    
}



#pragma mark -privateMethod

- (void)customCreateWillHandleView
{
    if (_taskSelfCheckView == nil) {
        _taskSelfCheckView = [[SelfCheckView alloc] init];
        [self.view addSubview:_taskSelfCheckView];
        [_taskSelfCheckView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    
    
    
    
}



/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(selfCheckToTaskList)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"申请中止任务" style:UIBarButtonItemStylePlain target:self action:@selector(stopTaskAction)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"自主检验";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)selfCheckToTaskList
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -memoryWarning
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
