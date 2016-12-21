//
//  CreditScoreViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/3.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CreditScoreViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UINavigationBar+Awesome.h"
#import "CreditLevelView.h"
#import "CreditMoreView.h"
#import "Masonry.h"

@interface CreditScoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIImageView               *navigationImageView;

@property (strong, nonatomic) CreditLevelView           *creditLevelView;
@property (strong, nonatomic) UITableView               *creditPartTableView;
@property (strong, nonatomic) CreditMoreView            *creditDetailMoreView;


@end

@implementation CreditScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customAckCoinAccountView];
    [self findNavigationBarDownLine];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self settingNavBar];
    
    self.navigationImageView.hidden = YES;
    [self.view setNeedsDisplay];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    
}

#pragma mark -privateMethod

- (void)customAckCoinAccountView
{
    if (_creditLevelView == nil) {
        _creditLevelView = [[CreditLevelView alloc] init];
        [self.view addSubview:_creditLevelView];
        [_creditLevelView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@240);
        }];
    }
    
    UIView *horizonalSeparetedView = [UIView new];
    horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self.view addSubview:horizonalSeparetedView];
    [horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_creditLevelView.bottom);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@5);
    }];
    
    if (_creditPartTableView == nil) {
        _creditPartTableView = [UITableView new];
        _creditPartTableView.delegate = self;
        _creditPartTableView.dataSource = self;
        [self.view addSubview:_creditPartTableView];
        [_creditPartTableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horizonalSeparetedView.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.bottom.equalTo(self.view.bottom);
        }];
        
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(creditViewBackToPersonalCenter)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"信用等级";
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)creditViewBackToPersonalCenter
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld",indexPath.row);
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }
    else
    {
        return 80.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%ld",indexPath.row];
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.row == 0) {
            _creditDetailMoreView = [[CreditMoreView alloc] init];
            [tableCell addSubview:_creditDetailMoreView];
            [_creditDetailMoreView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
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
        [cell setSeparatorInset:UIEdgeInsetsMake(0,10,0,10)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,10,0,10)];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([_creditPartTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_creditPartTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_creditPartTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_creditPartTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
