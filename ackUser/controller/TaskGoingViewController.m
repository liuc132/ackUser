//
//  TaskGoingViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskGoingViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "TaskGoingView.h"
#import "RemoveAccountView.h"
#import "Masonry.h"

@interface TaskGoingViewController ()

@property (strong, nonatomic) TaskGoingView         *taskGoingView;
@property (strong, nonatomic) RemoveAccountView     *stopTaskNoteView;

@end

@implementation TaskGoingViewController

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
    if (_taskGoingView == nil) {
        _taskGoingView = [[TaskGoingView alloc] init];
        [self.view addSubview:_taskGoingView];
        [_taskGoingView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [_taskGoingView.taskGoingSelfCheckButton addTarget:self action:@selector(selfCheckTaskAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (_stopTaskNoteView == nil) {
        _stopTaskNoteView = [[RemoveAccountView alloc] init];
        [_stopTaskNoteView dismissRemoveAccountViewAction];
        [self.navigationController.view addSubview:_stopTaskNoteView];
        [_stopTaskNoteView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _stopTaskNoteView.noteTitleLabel.text = @"申请中止任务";
        _stopTaskNoteView.noteSubTitleLabel.text = @"直接关闭任务,本任务不会再发放爱车币到您的帐户,并且回影响您的信用积分,确定关闭吗";
        _stopTaskNoteView.noteSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        _stopTaskNoteView.noteSubTitleLabel.textColor = [UIColor colorFromHexString:@"#727272" alpha:1.0];
        [_stopTaskNoteView.removeAccountCancelButton setTitle:@"确定" forState:UIControlStateNormal];
        [_stopTaskNoteView.removeAccountCancelButton addTarget:self action:@selector(confirmStoppingTaskAction:) forControlEvents:UIControlEventTouchUpInside];
        [_stopTaskNoteView.removeAccountConfirmButton setTitle:@"取消" forState:UIControlStateNormal];
        [_stopTaskNoteView.removeAccountConfirmButton addTarget:self action:@selector(cancelStoppingTaskAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

- (void)confirmStoppingTaskAction:(UIButton *)sender
{
    NSLog(@"确认停止任务...");
    [_stopTaskNoteView dismissRemoveAccountViewAction];
    [self performSegueWithIdentifier:@"taskGoingTostopTaskVC" sender:nil];
    
}

- (void)cancelStoppingTaskAction:(UIButton *)sender
{
    NSLog(@"取消停止任务...");
    [_stopTaskNoteView dismissRemoveAccountViewAction];
    
}


- (void)selfCheckTaskAction:(UIButton *)sender
{
    NSLog(@"去自检...");
    [self performSegueWithIdentifier:@"taskGoingToSelfCheckVC" sender:nil];
    
}


/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(taskGoingToTaskList)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"申请中止任务" style:UIBarButtonItemStylePlain target:self action:@selector(stopTaskAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"任务详情(执行中)";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)taskGoingToTaskList
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)stopTaskAction
{
    NSLog(@"终止任务...");
    [_stopTaskNoteView showRemoveAccountView];
    
    
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
