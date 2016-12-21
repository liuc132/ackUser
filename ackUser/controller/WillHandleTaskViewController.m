//
//  WillHandleTaskViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/1.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "WillHandleTaskViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "WillHandleTaskView.h"
#import "RemoveAccountView.h"
#import "Masonry.h"

@interface WillHandleTaskViewController ()
{
    RemoveAccountView *cancelTaskNoteView;
}

@property (strong, nonatomic) WillHandleTaskView        *willHandleView;

@end

@implementation WillHandleTaskViewController

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
    if (_willHandleView == nil) {
        _willHandleView = [[WillHandleTaskView alloc] init];
        [self.view addSubview:_willHandleView];
        [_willHandleView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    
    if (cancelTaskNoteView == nil) {
        cancelTaskNoteView = [[RemoveAccountView alloc] init];
        [cancelTaskNoteView dismissRemoveAccountViewAction];
        [self.view addSubview:cancelTaskNoteView];
        [cancelTaskNoteView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        cancelTaskNoteView.noteTitleLabel.text = @"取消任务";
        cancelTaskNoteView.noteSubTitleLabel.text = @"连续取消任务将影响您以后领取任务的成功率，确定取消吗？";
        [cancelTaskNoteView.removeAccountCancelButton setTitle:@"是" forState:UIControlStateNormal];
        [cancelTaskNoteView.removeAccountCancelButton addTarget:self action:@selector(confirmCancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelTaskNoteView.removeAccountConfirmButton setTitle:@"否" forState:UIControlStateNormal];
        [cancelTaskNoteView.removeAccountConfirmButton addTarget:self action:@selector(cancelNoteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)confirmCancelAction:(UIButton *)sender
{
    [cancelTaskNoteView dismissRemoveAccountViewAction];
    [self taskDetailToTaskList];
    
}

- (void)cancelNoteAction:(UIButton *)sender
{
    [cancelTaskNoteView dismissRemoveAccountViewAction];
    
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(taskDetailToTaskList)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消任务" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTaskAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"任务详情(待执行)";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
        
}

/**
 左侧导航按钮对应的action
 */
- (void)taskDetailToTaskList
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelTaskAction
{
    NSLog(@"取消任务...");
    [cancelTaskNoteView showRemoveAccountView];
    
    
    
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
