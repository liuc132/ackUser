//
//  ViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/8.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomePageViewController.h"
#import "ackUserPCH.pch"
#import "SimpleInformationCheck.h"
#import "GPSLocationInformation.h"
#import "HomeLeftBarView.h"
#import "UINavigationBar+Awesome.h"
#import "UIImage+ChangeImageColor.h"
#import "HeaderView.h"
#import "HomeFunctionView.h"
#import "HomeLatestTasksView.h"
#import "HomeLatestNews.h"
#import "HomeMyApplication.h"
#import "HomeLocationSelectView.h"
#import "LLTabBar.h"
#import "HTTPRequest.h"
#import "Masonry.h"


#define HEADER_HEIGHT 200.0f
#define HEADER_INIT_FRAME CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)
#define CELL_HEIGHT 45.0f

@interface HomePageViewController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, HeaderViewDelegate>

@property (strong, nonatomic) GPSLocationInformation        *gpsLocation;
@property (strong, nonatomic) UIImageView                   *navigationImageView;
@property (strong, nonatomic) UITableView                   *homeTableView;
@property (strong, nonatomic) HeaderView                    *headView;
@property (strong, nonatomic) HomeLocationSelectView        *homeLocationView;


@property (strong, nonatomic) HTTPRequest                   *homePageSession;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    __weak typeof(self) weakSelf = self;
    
    _gpsLocation = [GPSLocationInformation sharedManager];
    
    [self findNavigationBarDownLine];
    [self customCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden=NO;
    
    self.navigationImageView.hidden = YES;
    
    [self.view setNeedsDisplay];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    
}

#pragma mark -privateMethod
- (void)signInDataInitialization
{
    
    
    
}

- (void)settingDataInitialization
{
    
    
    
}

- (void)settingNetwork
{
    _homePageSession = [HTTPRequest sharedManager];
    
    
}

- (void)customCreateView
{
    if (_homeTableView == nil) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.allowsSelection = NO;
        [self.view addSubview:_homeTableView];
        [_homeTableView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 49, 0));
        }];
        
        _headView = [[HeaderView alloc] initWithFrame:HEADER_INIT_FRAME];
        _headView.delegate = self;
        [_homeTableView setTableHeaderView:_headView];
    }
    //设置此属性是为了避免因为navigationcontroller与自定义的tableview添加的顺序问题而造成的视图来回切换时出现的tableview顶部出现空白（高度为64，navigationbar+statusbar）的bug
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (_homeLocationView == nil) {
        _homeLocationView = [[HomeLocationSelectView alloc] init];
        [_homeLocationView dismissHomeLocationSelectView];
        [self.navigationController.view addSubview:_homeLocationView];
        [_homeLocationView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    
}


- (void)dynamicCodeSignAction:(UIButton *)sender
{
    NSLog(@"动态验证码登录...");
    
    
    
    
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
    HomeLeftBarView *leftBarView = [[HomeLeftBarView alloc] init];
    leftBarView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *leftBarGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarAction)];
    leftBarGesture.delegate = self;
    leftBarGesture.numberOfTapsRequired = 1;
    leftBarGesture.numberOfTouchesRequired = 1;
    [leftBarView addGestureRecognizer:leftBarGesture];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIImage *rightBarImage = [UIImage imageNamed:@"icon_home_messege_RightBar"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[rightBarImage imageWithColor:[UIColor whiteColor]] style:UIBarButtonItemStyleDone target:self action:@selector(messageAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    
}

/**
 左侧导航按钮对应的action
 */
- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)messageAction
{
    NSLog(@"消息...");
    [self performSegueWithIdentifier:@"homePageToMessageCenter" sender:nil];
    
    
}

- (void)leftBarAction
{
    NSLog(@"位置...");
    [_homeLocationView showHomeLocationSelectView];
    
    
}

- (void)filterResultDataWithDictionary:(NSDictionary *)result
{
    
    
}

- (void)getTaskAction:(UIButton *)sener
{
    NSLog(@"任务领取");
    
    [self performSegueWithIdentifier:@"homeToTasksList" sender:nil];
    self.tabBarController.tabBar.hidden=YES;
    
}


#pragma mark -UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 161.0;
            
            break;
        case 1:
            return 241.0;
            
            break;
        case 2:
            return 267.0;
            
            break;
        case 3:
            return 110.0;
            
            break;
            
        default:
            break;
    }
    return 161.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%ld",indexPath.section];
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!tableCell) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.section == 0) {
            HomeFunctionView *homeFuncView = [[HomeFunctionView alloc] init];
            [tableCell addSubview:homeFuncView];
            [homeFuncView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            [homeFuncView.getTaskButton addTarget:self action:@selector(getTaskAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        if (indexPath.section == 1) {
            HomeLatestTasksView *latestTasksView = [[HomeLatestTasksView alloc] init];
            [tableCell addSubview:latestTasksView];
            [latestTasksView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
        }
        
        if(indexPath.section == 2)
        {
            HomeLatestNews *latestNewsView = [[HomeLatestNews alloc] init];
            [tableCell addSubview:latestNewsView];
            [latestNewsView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }
        
        if(indexPath.section == 3)
        {
            HomeMyApplication *myAppView = [[HomeMyApplication alloc] init];
            [tableCell addSubview:myAppView];
            [myAppView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
        }
        
        
    }
//    tableCell.backgroundColor = [UIColor redColor];
    
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
    if ([_homeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_homeTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_homeTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_homeTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma mark - Header View Delegate Method
- (void)toggleHeaderViewFrame
{
    
    
    /*[UIView animateWithDuration:0.8
                     animations:^{
                         
                         _headView.isExpanded = !_headView.isExpanded;
                         [_headView updateFrame:_headView.isExpanded ? [self.view frame] : HEADER_INIT_FRAME];
                         
                     } completion:^(BOOL finished){
                         
                         [_homeTableView setScrollEnabled:!_headView.isExpanded];
                         
                     }];
    */
}

#pragma mark -UIScrollViewDelegate
#pragma mark - ScrollView Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float delta = 0.0f;
    CGRect rect = HEADER_INIT_FRAME;
    
    // Only allow the header to stretch if pulled down
    if (_homeTableView.contentOffset.y < 0.0f)
    {
        // Scroll down
        delta = fabs(MIN(0.0f, _homeTableView.contentOffset.y));
    }
    
    rect.origin.y -= delta;
    rect.size.height += delta;
    
    [_headView updateFrame:rect];
    
}








#pragma mark -memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
