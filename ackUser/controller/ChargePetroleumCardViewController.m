//
//  ChargePetroleumCardViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/30.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ChargePetroleumCardViewController.h"
#import "ackUserPCH.pch"
#import "ChargePetroleumCardView.h"
#import "ExchangePasswordViewController.h"
#import "HTTPRequest.h"
#import "Masonry.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ChargePetroleumCardViewController ()

@property (strong, nonatomic) ChargePetroleumCardView       *chargePetroleumView;

@property (strong, nonatomic) HTTPRequest                   *ackCoinCheckSessionManager;


@end

@implementation ChargePetroleumCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitilization];
//    [self customCreatePetroleumView];
    [self dataInitialization];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitilization
{
    _ackCoinCheckSessionManager = [HTTPRequest sharedManager];
    
}

- (void)dataInitialization
{
    __weak typeof(self) weakSelf = self;
    
    [SVProgressHUD show];
    [_ackCoinCheckSessionManager getAckCoinAccountSuccess:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSLog(@"请重新登录");
            NSDictionary *resultDictionary = finish[@"data"];
            
            [strongSelf customCreatePetroleumViewWithScore:resultDictionary[@"score"]];
            [SVProgressHUD dismiss];
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            [SVProgressHUD showInfoWithStatus:finish[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
        }
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
    }];
}

- (void)customCreatePetroleumViewWithScore:(NSString *)score
{
    if (_chargePetroleumView == nil) {
        _chargePetroleumView = [[ChargePetroleumCardView alloc] init];
        [self.view addSubview:_chargePetroleumView];
        [_chargePetroleumView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [_chargePetroleumView.confrimChargeButton addTarget:self action:@selector(chargePetroleumAction:) forControlEvents:UIControlEventTouchUpInside];
        _chargePetroleumView.coinCountTextField.placeholder = [NSString stringWithFormat:@"余额为%@爱车币",score];
    }
    
}

- (void)chargePetroleumAction:(UIButton *)sender
{
    NSLog(@"进入充值...");
    __weak typeof(self) weakSelf = self;
    [self.view endEditing:YES];
    NSString *ackCoinChargeCount = [NSString stringWithFormat:@"%@",_chargePetroleumView.coinCountTextField.text];
    NSInteger chargeCount = [ackCoinChargeCount integerValue];
    if ((chargeCount >= 5000) && (chargeCount%5000 == 0)) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"personalCenter" bundle:[NSBundle mainBundle]];
        ExchangePasswordViewController *exchangePasswordVC = [storyBoard instantiateViewControllerWithIdentifier:@"ExchangePasswordViewController"];
        exchangePasswordVC.chargeCountString = ackCoinChargeCount;
        exchangePasswordVC.chargeAckCoinType = OilCardChargeType;
        [self.navigationController showViewController:exchangePasswordVC sender:nil];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"使用爱车币充值油卡必须为5000的倍数!"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    
    
    
//    [self performSegueWithIdentifier:@"chargePetroleumToVerifyIDVC" sender:nil];
    
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
    
    self.navigationItem.title = @"油卡充值";
    
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
