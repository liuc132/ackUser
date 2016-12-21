//
//  ExchangePasswordViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/17.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ExchangePasswordViewController.h"
#import "ackUserPCH.pch"
#import "ACKCoinChargeSuccessNoteView.h"
#import "VerifyIDOilCardViewController.h"
#import "XLPasswordInputView.h"
#import "UIView+XLExtension.h"
#import "UIImage+XLExtension.h"
#import "HTTPRequest.h"
#import "Masonry.h"

#define kPasswordLenght 6

@interface ExchangePasswordViewController ()<UIGestureRecognizerDelegate>
{
    ACKCoinChargeSuccessNoteView *chargeSuccessNoteView;
}

@property (strong, nonatomic) UIImageView           *navigationImageView;
@property (strong, nonatomic) XLPasswordInputView   *passwordInputView;

@property (strong, nonatomic) HTTPRequest           *chargeOilCardSessionManager;

@property (copy, nonatomic) NSString                *exchangePassword;


@end

@implementation ExchangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customExchangePasswordView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}



#pragma mark -privateMethod

- (void)networkInitialization
{
    _chargeOilCardSessionManager = [HTTPRequest sharedManager];
}

- (void)customExchangePasswordView
{
    UILabel *enterPasswordNoteLabel = [UILabel new];
    enterPasswordNoteLabel.textAlignment = NSTextAlignmentCenter;
    [enterPasswordNoteLabel setFont:[UIFont systemFontOfSize:18]];
    enterPasswordNoteLabel.text = @"请输入您的交易密码";
    enterPasswordNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:enterPasswordNoteLabel];
    [enterPasswordNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@40);
        make.width.equalTo(@180);
        make.height.equalTo(@20);
    }];
    
    
    _passwordInputView = [XLPasswordInputView passwordInputViewWithPasswordLength:kPasswordLenght];
    _passwordInputView.userInteractionEnabled = YES;
    _passwordInputView.gridLineColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:206/255.0 alpha:1.0];
    _passwordInputView.gridLineWidth = 1;
    _passwordInputView.dotColor = [UIColor blackColor];
    _passwordInputView.dotWidth = 12;
    CGFloat gridWidth = 60 * xl_autoSizeScaleX;
    _passwordInputView.xl_width = kPasswordLenght * gridWidth;
    _passwordInputView.xl_height = gridWidth;
    _passwordInputView.xl_centerX = XLScreenW * 0.5;
    _passwordInputView.xl_y = 72 * xl_autoSizeScaleY;
    _passwordInputView.passwordBlock = ^(NSString *password){
        if (password.length <= 0 || password == nil) {
            NSLog(@"密码位数已经为0");
        }
        NSLog(@"\n password : %@",password);
    };
    
    [self.view addSubview:_passwordInputView];
    [_passwordInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(enterPasswordNoteLabel.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.height.equalTo(@40);
        make.width.equalTo(@200);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(_passwordInputView.bottom).offset(30);
        make.height.equalTo(@1);
    }];
    
    UIButton *confirmCodeButton = [UIButton new];
    confirmCodeButton.layer.cornerRadius = 4.0;
    confirmCodeButton.layer.masksToBounds = YES;
    [confirmCodeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confirmCodeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confirmCodeButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmCodeButton addTarget:self action:@selector(confirmPasswordInputAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmCodeButton];
    [confirmCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UIButton *forgetPassswordButton = [UIButton new];
    [forgetPassswordButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [forgetPassswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPassswordButton setTitleColor:[UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0] forState:UIControlStateNormal];
    [forgetPassswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassswordButton];
    [forgetPassswordButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmCodeButton.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    if (chargeSuccessNoteView == nil) {
        chargeSuccessNoteView = [[ACKCoinChargeSuccessNoteView alloc] init];
        [chargeSuccessNoteView dismissChargeSuccessNoteViewAction];
        [self.navigationController.view addSubview:chargeSuccessNoteView];
        [chargeSuccessNoteView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    
    UITapGestureRecognizer *tapDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismissAction)];
    tapDismissGesture.delegate = self;
    tapDismissGesture.numberOfTapsRequired = 1;
    tapDismissGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapDismissGesture];
    
}

- (void)tapDismissAction
{
    [self.view endEditing:YES];
}

- (void)forgetPasswordAction:(UIButton *)sender
{
    NSLog(@"忘记密码...");
    [_passwordInputView endEditing:YES];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"personalCenter" bundle:[NSBundle mainBundle]];
    VerifyIDOilCardViewController *verifyIDVC = [storyBoard instantiateViewControllerWithIdentifier:@"VerifyIDOilCardViewController"];
    [self.navigationController showViewController:verifyIDVC sender:nil];
    
}

- (void)confirmPasswordInputAction:(UIButton *)sender
{
    NSLog(@"确认...");
    [_passwordInputView endEditing:YES];
    //[chargeSuccessNoteView showChargeSuccessNoteView];
    
    [_chargeOilCardSessionManager chargeOilCardWithParameter:@{} success:^(id finish) {
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired) {
            
        }
        
        
    } failure:^(NSError *reqError) {
        
        
        
    }];
    
    
    
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
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"交易密码验证";
    
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

//- (void)ViewExchangeDetail
//{
//    NSLog(@"查看交易明细...");
//    
//    
//}


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
