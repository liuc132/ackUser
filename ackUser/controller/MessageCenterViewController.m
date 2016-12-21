//
//  MessageCenterViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "VerifyIDSegmentView.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@interface MessageCenterViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (strong, nonatomic) VerifyIDSegmentView       *customSegmentView;
@property (strong, nonatomic) UITableView               *messageTableView;


@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNavBar];
    [self customCreateStopTaskView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



#pragma mark -privateMethod

- (void)customCreateStopTaskView
{
    if (_customSegmentView == nil) {
        _customSegmentView = [[VerifyIDSegmentView alloc] init];
        [self.view addSubview:_customSegmentView];
        [_customSegmentView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@41);
        }];
        
        [_customSegmentView.horizonalSeparetedView1 updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@5);
        }];
        
        _customSegmentView.petroleumCardLabel.text = @"站内信息";
        UIImage *stationImage = [UIImage imageNamed:@"icon_message_stationMessage"];
        _customSegmentView.petroleumCardImageView.image = [stationImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
        _customSegmentView.securityQuestionLabel.text = @"备忘录";
        UIImage *notesImage = [UIImage imageNamed:@"icon_message_notes"];
        _customSegmentView.securityQuestionImageView.image = [notesImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
        
        _customSegmentView.horizonalSeparetedView.hidden = YES;
        _customSegmentView.horizonalSeparetedView0.hidden = YES;
        //
        UITapGestureRecognizer *stationTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stationAction:)];
        stationTapGesture.delegate = self;
        stationTapGesture.numberOfTapsRequired = 1;
        stationTapGesture.numberOfTouchesRequired = 1;
        [_customSegmentView.petroleumCardContentView addGestureRecognizer:stationTapGesture];
        
        UITapGestureRecognizer *notesTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notesAction:)];
        notesTapGesture.delegate = self;
        notesTapGesture.numberOfTapsRequired = 1;
        notesTapGesture.numberOfTouchesRequired = 1;
        [_customSegmentView.securityQuestionView addGestureRecognizer:notesTapGesture];
    }
    
    if (_messageTableView == nil) {
        _messageTableView = [UITableView new];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        [self.view addSubview:_messageTableView];
        [_messageTableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_customSegmentView.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.bottom.equalTo(self.view.bottom).offset(-49);
        }];
    }
    
    
    
    
}

- (void)notesAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"备忘录...");
    UIImage *securityImage = [UIImage imageNamed:@"icon_message_notes"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    _customSegmentView.securityQuestionImageView.image = [securityImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    _customSegmentView.securityQuestionLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
//    _customSegmentView.horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    
    UIImage *petroleumCardImage = [UIImage imageNamed:@"icon_message_stationMessage"];
    _customSegmentView.petroleumCardImageView.image = [petroleumCardImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    _customSegmentView.petroleumCardLabel.textColor = [UIColor colorFromHexString:@"#7e8384" alpha:1.0];
//    _customSegmentView.horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
}

- (void)stationAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"站内信息...");
    UIImage *securityImage = [UIImage imageNamed:@"icon_message_notes"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    _customSegmentView.securityQuestionImageView.image = [securityImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    _customSegmentView.securityQuestionLabel.textColor = [UIColor colorFromHexString:@"#7e8384" alpha:1.0];
//    _customSegmentView.horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
    UIImage *petroleumCardImage = [UIImage imageNamed:@"icon_message_stationMessage"];
    _customSegmentView.petroleumCardImageView.image = [petroleumCardImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    _customSegmentView.petroleumCardLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
//    _customSegmentView.horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    
    
}



/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(selfCheckToTaskList)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"申请终止任务" style:UIBarButtonItemStylePlain target:self action:@selector(stopTaskAction)];
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"平台信息";
    
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
- (void)selfCheckToTaskList
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -UITableViewDelegate
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
    }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标记已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"标记已读");
    }];
    rowAction.backgroundColor = [UIColor colorFromHexString:@"#fe2b44" alpha:1.0];
    rowActionSec.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld",indexPath.row);
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%ld",indexPath.section];
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
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
    if ([_messageTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_messageTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_messageTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_messageTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
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
