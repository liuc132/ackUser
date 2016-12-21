//
//  VerifyIDOilCardViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "VerifyIDOilCardViewController.h"
#import "ackUserPCH.pch"
#import "UIImage+ChangeImageColor.h"
#import "UIColor+HexColor.h"
#import "VerifyidSegmentView.h"
#import "PetroleumCardVerityView.h"
#import "Masonry.h"

@interface VerifyIDOilCardViewController ()<UIGestureRecognizerDelegate>
{
    VerifyIDSegmentView         *verifyIDSegmentView;
    PetroleumCardVerityView     *petroleumCardVerifyView;
}

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) UIView            *horizonalSeparetedView;
@property (strong, nonatomic) UILabel           *ackCoinTotalLabel;
@property (strong, nonatomic) UIImageView       *ackCoinTotalImageView;
@property (strong, nonatomic) UIImageView       *userAccountLeftImageView;
@property (strong, nonatomic) UILabel           *userAccountLeftLabel;
@property (strong, nonatomic) UIView            *horizonalSeparetedView0;
@property (strong, nonatomic) UILabel           *moneyNoteLabel;

@end

@implementation VerifyIDOilCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customChargeOilCardView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)customChargeOilCardView
{
    if (verifyIDSegmentView == nil) {
        verifyIDSegmentView = [[VerifyIDSegmentView alloc] init];
        [self.view addSubview:verifyIDSegmentView];
        [verifyIDSegmentView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@32);
        }];
        
        //
        UITapGestureRecognizer *petroleumCardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(petroleumCardNumberAction:)];
        petroleumCardTapGesture.delegate = self;
        petroleumCardTapGesture.numberOfTapsRequired = 1;
        petroleumCardTapGesture.numberOfTouchesRequired = 1;
        [verifyIDSegmentView.petroleumCardContentView addGestureRecognizer:petroleumCardTapGesture];
        
        UITapGestureRecognizer *securityQuestionTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(securityQuestionAction:)];
        securityQuestionTapGesture.delegate = self;
        securityQuestionTapGesture.numberOfTapsRequired = 1;
        securityQuestionTapGesture.numberOfTouchesRequired = 1;
        [verifyIDSegmentView.securityQuestionView addGestureRecognizer:securityQuestionTapGesture];
        
        
        
    }
    
    if (petroleumCardVerifyView == nil) {
        petroleumCardVerifyView = [[PetroleumCardVerityView alloc] init];
        [self.view addSubview:petroleumCardVerifyView];
        [petroleumCardVerifyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(verifyIDSegmentView.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.bottom.equalTo(self.view.bottom);
        }];
        
    }
    
    
    
    /*
    UIView *ackCoinContentView = [UIView new];
    UITapGestureRecognizer *ackCoinTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ackCoinAction:)];
    ackCoinTapGesture.delegate = self;
    ackCoinTapGesture.numberOfTapsRequired = 1;
    ackCoinTapGesture.numberOfTouchesRequired = 1;
    [ackCoinContentView addGestureRecognizer:ackCoinTapGesture];
    ackCoinContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ackCoinContentView];
    [ackCoinContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.width.equalTo(@(SCREEN_WIDTH/2 - 1));
        make.height.equalTo(@30);
    }];
    
    _ackCoinTotalImageView = [UIImageView new];
    _ackCoinTotalImageView.image = [UIImage imageNamed:@"personalCenter_ackCoin"];
    _ackCoinTotalImageView.contentMode = UIViewContentModeScaleAspectFill;
    [ackCoinContentView addSubview:_ackCoinTotalImageView];
    [_ackCoinTotalImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ackCoinContentView.left).offset(25);
        make.top.equalTo(ackCoinContentView.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _ackCoinTotalLabel = [UILabel new];
    _ackCoinTotalLabel.font = [UIFont systemFontOfSize:15];
    _ackCoinTotalLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    _ackCoinTotalLabel.textAlignment = NSTextAlignmentCenter;
    _ackCoinTotalLabel.text = @"油卡卡号";
    [ackCoinContentView addSubview:_ackCoinTotalLabel];
    [_ackCoinTotalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ackCoinTotalImageView.right).offset(4);
        make.top.equalTo(ackCoinContentView.top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    UIView *betweenCoinAndAccountLeftView = [UIView new];
    betweenCoinAndAccountLeftView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:betweenCoinAndAccountLeftView];
    [betweenCoinAndAccountLeftView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.view.top).offset(5);
        make.width.equalTo(@1);
        make.height.equalTo(@30);
    }];
    
    UIView *ackCashContentView = [UIView new];
    UITapGestureRecognizer *ackCashTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ackCashAction:)];
    ackCashTapGesture.delegate = self;
    ackCashTapGesture.numberOfTapsRequired = 1;
    ackCashTapGesture.numberOfTouchesRequired = 1;
    [ackCashContentView addGestureRecognizer:ackCashTapGesture];
    ackCashContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ackCashContentView];
    [ackCashContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.right.equalTo(self.view.right);
        make.width.equalTo(@(SCREEN_WIDTH/2 - 1));
        make.height.equalTo(@50);
    }];
    
    _userAccountLeftImageView = [UIImageView new];
    _userAccountLeftImageView.image = [UIImage imageNamed:@"personalCenter_accountLeft"];
    _userAccountLeftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [ackCashContentView addSubview:_userAccountLeftImageView];
    [_userAccountLeftImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(betweenCoinAndAccountLeftView.left).offset(20);
        make.top.equalTo(ackCashContentView.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _userAccountLeftLabel = [UILabel new];
    _userAccountLeftLabel.font = [UIFont systemFontOfSize:15];
    _userAccountLeftLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    _userAccountLeftLabel.textAlignment = NSTextAlignmentCenter;
    _userAccountLeftLabel.text = @"现金";
    [ackCashContentView addSubview:_userAccountLeftLabel];
    [_userAccountLeftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userAccountLeftImageView.right).offset(4);
        make.top.equalTo(ackCashContentView.top).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    _horizonalSeparetedView = [UIView new];
    _horizonalSeparetedView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_horizonalSeparetedView];
    [_horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-80));
        make.top.equalTo(ackCoinContentView.bottom).offset(5);
        make.width.equalTo(@150);
        make.height.equalTo(@1);
    }];
    
    UIImage *ackCoinImage = [UIImage imageNamed:@"personalCenter_ackCoin"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    _ackCoinTotalImageView.image = [ackCoinImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    _ackCoinTotalLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    _horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
    UIImage *ackCashImage = [UIImage imageNamed:@"personalCenter_accountLeft"];
    _userAccountLeftImageView.image = [ackCashImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    
    _horizonalSeparetedView0 = [UIView new];
    _horizonalSeparetedView0.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_horizonalSeparetedView0];
    [_horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(80));
        make.top.equalTo(ackCoinContentView.bottom).offset(5);
        make.width.equalTo(@150);
        make.height.equalTo(@1);
    }];
    
    _moneyNoteLabel = [UILabel new];
    _moneyNoteLabel.textAlignment = NSTextAlignmentLeft;
    _moneyNoteLabel.font = [UIFont systemFontOfSize:15];
    NSString *ackCoinDifferenceString = @"金额:";
    _moneyNoteLabel.text = ackCoinDifferenceString;
    _moneyNoteLabel.textColor = [UIColor colorFromHexString:@"#7e8384" alpha:1.0];
    [self.view addSubview:_moneyNoteLabel];
    [_moneyNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(_horizonalSeparetedView0.bottom).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UITextField *exchangeAckCoinTextField = [UITextField new];
//    selectYearMonthTextField.delegate = self;
    exchangeAckCoinTextField.userInteractionEnabled = YES;
    exchangeAckCoinTextField.textAlignment = NSTextAlignmentRight;
    exchangeAckCoinTextField.placeholder = @"余额为30000爱车币";
    exchangeAckCoinTextField.keyboardType = UIKeyboardTypeNumberPad;
    [exchangeAckCoinTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    exchangeAckCoinTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:exchangeAckCoinTextField];
    [exchangeAckCoinTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moneyNoteLabel.right).offset(30);
        make.height.equalTo(@20);
        make.top.equalTo(_horizonalSeparetedView0.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(_moneyNoteLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *ackCoinDifferenceLabel = [UILabel new];
    ackCoinDifferenceLabel.numberOfLines = 0;
    ackCoinDifferenceLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinDifferenceLabel.font = [UIFont systemFontOfSize:13];
    ackCoinDifferenceLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    ackCoinDifferenceLabel.text = @"1爱车币=0.01元";
    [self.view addSubview:ackCoinDifferenceLabel];
    [ackCoinDifferenceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(horizonalSeparetedView2.bottom).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    UILabel *ackCoinNoteLabel = [UILabel new];
    ackCoinNoteLabel.numberOfLines = 0;
    ackCoinNoteLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinNoteLabel.font = [UIFont systemFontOfSize:15];
    ackCoinNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    NSString *ackCoinNoteString = @"使用爱车币充值油卡必须为5000的倍数";
    ackCoinNoteLabel.text = ackCoinNoteString;
    [self.view addSubview:ackCoinNoteLabel];
    [ackCoinNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(ackCoinDifferenceLabel.bottom).equalTo(@5);
        make.width.equalTo(@270);
        make.height.equalTo(@20);
    }];
    
    UIButton *getCheckCodeButton = [UIButton new];
    [getCheckCodeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    getCheckCodeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [getCheckCodeButton setTitle:@"确认充值" forState:UIControlStateNormal];
    [getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCheckCodeButton addTarget:self action:@selector(confirmChargeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCheckCodeButton];
    [getCheckCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(ackCoinNoteLabel.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    */
    
}

- (void)securityQuestionAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"密保...");
    UIImage *securityImage = [UIImage imageNamed:@"icon_securityQuestion"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    verifyIDSegmentView.securityQuestionImageView.image = [securityImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    verifyIDSegmentView.securityQuestionLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    verifyIDSegmentView.horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    
    UIImage *petroleumCardImage = [UIImage imageNamed:@"icon_petroleumCard"];
    verifyIDSegmentView.petroleumCardImageView.image = [petroleumCardImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    verifyIDSegmentView.petroleumCardLabel.textColor = [UIColor colorFromHexString:@"#7e8384" alpha:1.0];
    verifyIDSegmentView.horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
}

- (void)petroleumCardNumberAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"油卡...");
    UIImage *securityImage = [UIImage imageNamed:@"icon_securityQuestion"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    verifyIDSegmentView.securityQuestionImageView.image = [securityImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    verifyIDSegmentView.securityQuestionLabel.textColor = [UIColor colorFromHexString:@"#7e8384" alpha:1.0];
    verifyIDSegmentView.horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
    UIImage *petroleumCardImage = [UIImage imageNamed:@"icon_petroleumCard"];
    verifyIDSegmentView.petroleumCardImageView.image = [petroleumCardImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    verifyIDSegmentView.petroleumCardLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    verifyIDSegmentView.horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    
    
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(forgetBackToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"身份验证";
    
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
