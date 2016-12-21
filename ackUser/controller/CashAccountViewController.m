//
//  CashAccountViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CashAccountViewController.h"
#import "ackUserPCH.pch"
#import "BankCardTableViewCell.h"
#import "UIColor+HexColor.h"
#import "UIButton+DottedBorder.h"
#import "Masonry.h"

@interface CashAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) UITableView       *bankCardsTableView;

@property (assign, nonatomic) NSInteger         tableCount;


@end

@implementation CashAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataInitialization];
    
    [self customAckCashAccountView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}



#pragma mark -privateMethod

- (void)dataInitialization
{
    _tableCount = 3;
}

- (void)customAckCashAccountView
{
    UIImageView *ackCashAccountImageView = [UIImageView new];
    ackCashAccountImageView.contentMode = UIViewContentModeScaleAspectFill;
    ackCashAccountImageView.image = [UIImage imageNamed:@"icon_cashAccount_headBack"];
    [self.view addSubview:ackCashAccountImageView];
    [ackCashAccountImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@100);
    }];
    
    UILabel *ackCashLeftLabel = [UILabel new];
    ackCashLeftLabel.numberOfLines = 0;
    ackCashLeftLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *ackCoinLeftString = @"¥1235,50     可用余额";
    ackCashLeftLabel.text = ackCoinLeftString;
    NSMutableAttributedString *ackCoinLeftAttrStr = [[NSMutableAttributedString alloc] initWithString:ackCoinLeftString];
    //setting font
    [ackCoinLeftAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(8, 9)];
    [ackCoinLeftAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    [ackCoinLeftAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(5, 3)];
    [ackCoinLeftAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(0, 8)];
    [ackCoinLeftAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0] range:NSMakeRange(8, 9)];
    ackCashLeftLabel.attributedText = ackCoinLeftAttrStr;
    [self.view addSubview:ackCashLeftLabel];
    [ackCashLeftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.view.top).equalTo(@60);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    _bankCardsTableView = [UITableView new];
    _bankCardsTableView.delegate = self;
    _bankCardsTableView.dataSource = self;
    [self.view addSubview:_bankCardsTableView];
    [_bankCardsTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ackCashAccountImageView.bottom).offset(80);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom).offset(-50);
    }];
    
    UIButton *getCashRightNowButton = [UIButton new];
    [getCashRightNowButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    getCashRightNowButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [getCashRightNowButton setTitle:@"马上提现" forState:UIControlStateNormal];
    [getCashRightNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCashRightNowButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCashRightNowButton addTarget:self action:@selector(getCashRightNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCashRightNowButton];
    [getCashRightNowButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(_bankCardsTableView.bottom).offset(5);
        make.height.equalTo(@40);
    }];
    
    
}

- (void)getCashRightNow:(UIButton *)sender
{
    NSLog(@"马上提现...");
//    [self performSegueWithIdentifier:@"ackCoinAccountToExchangePassword" sender:nil];
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(forgetBackToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"现金账户";
    
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
- (void)forgetBackToSignVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ViewExchangeDetail
{
    NSLog(@"查看交易明细...");
//    [self performSegueWithIdentifier:@"ackCoinAccountToExchangeDetail" sender:nil];
    
}




#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == (_tableCount - 1)) {
        return 44.0;
    }
    else
    {
        return 90.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.row == (_tableCount - 1)) {
            UIButton *addBankCardButton = [UIButton new];
            [addBankCardButton setImage:[UIImage imageNamed:@"cashAccount_addBank_normal"] forState:UIControlStateNormal];
            [addBankCardButton setTitle:@"添加银行卡" forState:UIControlStateNormal];
            [addBankCardButton setTitleColor:[UIColor colorFromHexString:@"#ff9f23" alpha:1.0] forState:UIControlStateNormal];
            
            CGSize titleSize = addBankCardButton.titleLabel.bounds.size;
            CGSize imageSize = addBankCardButton.imageView.bounds.size;
            addBankCardButton.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width, 0, -(titleSize.width - 10));
            addBankCardButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width);
            [tableCell addSubview:addBankCardButton];
            [addBankCardButton makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tableCell.top).offset(2);
                make.left.equalTo(tableCell.left).offset(2);
                make.right.equalTo(tableCell.right).offset(-2);
                make.bottom.equalTo(tableCell.bottom).offset(-2);
            }];
            
        }
        else
        {
            BankCardTableViewCell *bankCardCell = [[BankCardTableViewCell alloc] init];
            [tableCell addSubview:bankCardCell];
            [bankCardCell makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tableCell.top);
                make.left.equalTo(tableCell.left);
                make.right.equalTo(tableCell.right);
                make.bottom.equalTo(tableCell.bottom);
            }];
            tableCell.backgroundColor = [UIColor colorFromHexString:@"#427eeb" alpha:1.0];
            
        }
        
    }
    
    
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
    if ([_bankCardsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_bankCardsTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_bankCardsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_bankCardsTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
