//
//  SignInViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/15.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SignInViewController.h"
#import "ackUserPCH.pch"
#import "SimpleInformationCheck.h"
#import "AckUserDBManager.h"
#import "MessegeVerifyViewController.h"
#import "HTTPRequest.h"
#import "Masonry.h"

@interface SignInViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) HTTPRequest                   *signInSessionManager;

@property (strong, nonatomic) SimpleInformationCheck        *phoneNumberCheck;
@property (strong, nonatomic) AckUserDBManager              *userSignInDBManager;



@property (strong, nonatomic) UIImageView   *navigationImageView;
@property (strong, nonatomic) UIButton      *dynamicCodeSignButton;
@property (strong, nonatomic) UIImageView   *ackImageLogo;
@property (strong, nonatomic) UILabel       *phoneNumLabel;
@property (strong, nonatomic) UITextField   *phoneNumTextField;
@property (strong, nonatomic) UIView        *separetedView;
@property (strong, nonatomic) UILabel       *passwordNumLabel;
@property (strong, nonatomic) UITextField   *passwordNumTextField;
@property (strong, nonatomic) UIView        *separetedView1;
@property (strong, nonatomic) UIButton      *signInButton;
@property (strong, nonatomic) UIButton      *forgetPasswordButton;
@property (strong, nonatomic) UIView        *separetedView2;
@property (strong, nonatomic) UILabel       *thirdSignLabel;
@property (strong, nonatomic) UIView        *separetedView3;
@property (strong, nonatomic) UIButton      *weChatSignButton;
@property (strong, nonatomic) UIButton      *QQSignButton;
@property (strong, nonatomic) UIButton      *weboSignButton;
@property (strong, nonatomic) UILabel       *weChatLabel;
@property (strong, nonatomic) UILabel       *QQLabel;
@property (strong, nonatomic) UILabel       *weboLabel;


@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingDataInitialization];
    [self findNavigationBarDownLine];
    [self settingNetwork];
    [self signInDataInitialization];
    
    [self customCreateView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationImageView.hidden = YES;
    
}

#pragma mark -privateMethod
- (void)signInDataInitialization
{
    _userSignInDBManager = [AckUserDBManager sharedManager];
    
    
}

- (void)settingDataInitialization
{
    _phoneNumberCheck = [SimpleInformationCheck sharedManager];
    
    
}

- (void)settingNetwork
{
    /*
    _logInSessionManager = [AFHTTPSessionManager manager];
    _logInSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/javascript",@"application/json", nil];
    
    _reachabilityManager = [AFNetworkReachabilityManager manager];
    [_reachabilityManager startMonitoring];
    */
    _signInSessionManager = [HTTPRequest sharedManager];
    
    
}

- (void)customCreateView
{
    _ackImageLogo = [UIImageView new];
    _ackImageLogo.image = [UIImage imageNamed:@"personalCenter_logo"];
    _ackImageLogo.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_ackImageLogo];
    
    _phoneNumLabel = [UILabel new];
    _phoneNumLabel.text = @"手机号";
    _phoneNumLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_phoneNumLabel];
    
    _phoneNumTextField = [UITextField new];
    _phoneNumTextField.userInteractionEnabled = YES;
    _phoneNumTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _phoneNumTextField.placeholder = @"请输入手机号";
    [_phoneNumTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_phoneNumTextField];
    
    _separetedView = [UIView new];
    _separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_separetedView];
    
    _passwordNumLabel = [UILabel new];
    _passwordNumLabel.text = @"密码";
    _passwordNumLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_passwordNumLabel];
    
    _passwordNumTextField = [UITextField new];
//    passwordNumTextField.delegate = self;
    _passwordNumTextField.placeholder = @"请输入密码";
    _passwordNumTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordNumTextField.secureTextEntry = YES;
    _passwordNumTextField.userInteractionEnabled = YES;
    [_passwordNumTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordNumTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_passwordNumTextField];
    
    _separetedView1 = [UIView new];
    _separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_separetedView1];
    
    _signInButton = [UIButton new];
    _signInButton.userInteractionEnabled = YES;
    _signInButton.layer.cornerRadius = 4.0;
    _signInButton.layer.masksToBounds = YES;
    [_signInButton addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    _signInButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [_signInButton setTitle:@"登录" forState:UIControlStateNormal];
    [_signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_signInButton];
    
    _dynamicCodeSignButton = [UIButton new];
    [_dynamicCodeSignButton addTarget:self action:@selector(dynamicCodeSignAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dynamicCodeSignButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_dynamicCodeSignButton setTitle:@"动态密码登录" forState:UIControlStateNormal];
    _dynamicCodeSignButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_dynamicCodeSignButton];
    
    _forgetPasswordButton = [UIButton new];
    [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetPasswordButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_forgetPasswordButton];
    
    _separetedView2 = [UIView new];
    _separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_separetedView2];
    
    _thirdSignLabel = [UILabel new];
    _thirdSignLabel.text = @"第三方登录";
    _thirdSignLabel.textAlignment = NSTextAlignmentCenter;
    _thirdSignLabel.font = [UIFont systemFontOfSize:10];
    _thirdSignLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_thirdSignLabel];
    
    _separetedView3 = [UIView new];
    _separetedView3.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:_separetedView3];
    
    _weChatSignButton = [UIButton new];
    [_weChatSignButton setImage:[UIImage imageNamed:@"persionalCenter_wechat"] forState:UIControlStateNormal];
    [self.view addSubview:_weChatSignButton];
    
    _QQSignButton = [UIButton new];
    [_QQSignButton setImage:[UIImage imageNamed:@"persionalCenter_QQ"] forState:UIControlStateNormal];
    [self.view addSubview:_QQSignButton];
    
    _weboSignButton = [UIButton new];
    [_weboSignButton setImage:[UIImage imageNamed:@"persionalCenter_webo"] forState:UIControlStateNormal];
    [self.view addSubview:_weboSignButton];
    
    _weChatLabel = [UILabel new];
    _weChatLabel.text = @"微信";
    _weChatLabel.textAlignment = NSTextAlignmentCenter;
    _weChatLabel.font = [UIFont systemFontOfSize:10];
    _weChatLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_weChatLabel];
    
    _QQLabel = [UILabel new];
    _QQLabel.text = @"QQ";
    _QQLabel.textAlignment = NSTextAlignmentCenter;
    _QQLabel.font = [UIFont systemFontOfSize:10];
    _QQLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_QQLabel];
    
    _weboLabel = [UILabel new];
    _weboLabel.text = @"新浪微博";
    _weboLabel.textAlignment = NSTextAlignmentCenter;
    _weboLabel.font = [UIFont systemFontOfSize:10];
    _weboLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:_weboLabel];
    
    
    [_ackImageLogo makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.equalTo(@60);
        make.width.equalTo(@120);
    }];
    
    [_phoneNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(_ackImageLogo.bottom).offset(60);
        make.width.equalTo(@75);
        make.height.equalTo(@40);
    }];
    
    [_phoneNumTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneNumLabel.right).offset(10);
        make.height.equalTo(@40);
        make.top.equalTo(_ackImageLogo.bottom).offset(60);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [_separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_phoneNumLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [_passwordNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@75);
        make.top.equalTo(_separetedView.bottom).offset(10);
        make.height.equalTo(@40);
        
    }];
    
    [_passwordNumTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordNumLabel.right).offset(10);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [_separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_passwordNumLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [_signInButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_separetedView1.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [_dynamicCodeSignButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.width.equalTo(@85);
        make.top.equalTo(_signInButton.bottom).offset(5);
        make.height.equalTo(@30);
    }];
    
    [_forgetPasswordButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(_signInButton.bottom).offset(5);
        make.height.equalTo(@30);
    }];
    
    [_separetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@100);
        make.top.equalTo(_dynamicCodeSignButton.bottom).offset(90);
        make.height.equalTo(@1);
    }];
    
    [_thirdSignLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@60);
        make.top.equalTo(_dynamicCodeSignButton.bottom).offset(85);
        make.height.equalTo(@15);
    }];
    
    [_separetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thirdSignLabel.right).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(_dynamicCodeSignButton.bottom).offset(90);
        make.height.equalTo(@1);
    }];
    
    [_weChatSignButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@30);
        make.top.equalTo(_separetedView3.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    [_QQSignButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@30);
        make.top.equalTo(_separetedView3.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    [_weboSignButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_separetedView3.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    [_weChatLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@30);
        make.top.equalTo(_weChatSignButton.bottom).offset(5);
        make.left.equalTo(@20);
    }];
    
    [_QQLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@30);
        make.top.equalTo(_weChatSignButton.bottom).offset(5);
        make.centerX.equalTo(@0);
    }];
    
    [_weboLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@60);
        make.top.equalTo(_weChatSignButton.bottom).offset(5);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
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

- (void)dynamicCodeSignAction:(UIButton *)sender
{
    NSLog(@"动态验证码登录...");
    if ([sender.titleLabel.text isEqualToString:@"动态密码登录"]) {
        [sender setTitle:@"密码登录" forState:UIControlStateNormal];
        [_signInButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        //
        _passwordNumLabel.hidden = YES;
        _passwordNumTextField.hidden = YES;
        _separetedView1.hidden = YES;
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"密码登录"])
    {
        [sender setTitle:@"动态密码登录" forState:UIControlStateNormal];
        [_signInButton setTitle:@"登录" forState:UIControlStateNormal];
        //
        _passwordNumLabel.hidden = NO;
        _passwordNumTextField.hidden = NO;
        _separetedView1.hidden = NO;
    }
    
    
    
}

- (void)signInAction:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"登录／发送验证码....");
    [self.view endEditing:YES];
    if ([sender.titleLabel.text isEqualToString:@"登录"]) {
        NSLog(@"登录....");
        //don't forget to define the following first line!!!
        NSString *phoneNum = [NSString stringWithFormat:@"%@",_phoneNumTextField.text];
        NSString *password = [NSString stringWithFormat:@"%@",_passwordNumTextField.text];
        
        if (![SimpleInformationCheck checkMobilePhoneNumberWithPhoneNumber:phoneNum] || (password.length < 6)) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入手机号或者密码错误!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancle");
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
            
            return;
        }
        
        NSDictionary *logInParameters = @{@"phone":phoneNum,@"password":password};
        
        [_signInSessionManager userSignInWithParameter:logInParameters complete:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                NSDictionary *resultDictionary = finish[@"entity"];
                [strongSelf filterResultDataWithDictionary:resultDictionary];
                [strongSelf navBack];
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
        } error:^(id reqError) {
            NSError *backError = (NSError *)reqError;
            NSLog(@"%@",backError.localizedDescription);
            
            
        }];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"发送验证码"])
    {
        NSLog(@"发送验证码....");
        
        NSString *phoneNum = [NSString stringWithFormat:@"%@",_phoneNumTextField.text];
        
        if (![SimpleInformationCheck checkMobilePhoneNumberWithPhoneNumber:phoneNum]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入手机号或者密码错误!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancle");
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
            
            return;
        }
        
        NSDictionary *messageDictionary = @{@"type":SignInType,@"phone":_phoneNumTextField.text};
        [_signInSessionManager getCheckCodeWithParameter:messageDictionary success:^(id finish) {
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                [self performSegueWithIdentifier:@"toMessegeVerify" sender:nil];
                
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
        } failure:^(NSError *reqError) {
            
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signIn_close"] style:UIBarButtonItemStylePlain target:self action:@selector(navBack)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"我要注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
//    self.navigationItem.title = @"待安装任务";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0]];
    //去掉导航栏最下边的分割线
    
    
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction
{
    NSLog(@"注册...");
    
    [self performSegueWithIdentifier:@"toRegisterVC" sender:nil];
    
}

- (void)forgetPasswordAction:(UIButton *)sender
{
    NSLog(@"忘记密码");
    
    [self performSegueWithIdentifier:@"toForgetVC" sender:nil];
    
    
}

- (void)filterResultDataWithDictionary:(NSDictionary *)result
{
    NSMutableDictionary *handledDictionary = [[NSMutableDictionary alloc] init];
    [handledDictionary setValue:result[@"id"] forKey:@"userID"];
    NSString *carClubsIdStr = (NSString *)[result objectForKey:@"carClubsId"];
    if ([carClubsIdStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"carClubsId"];
    }
    else{
        [handledDictionary setValue:result[@"carClubsId"] forKey:@"carClubsId"];
    }
    
    NSString *wechatIdStr = (NSString *)[result objectForKey:@"wechatId"];
    if ([wechatIdStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"wechatId"];
    }
    else{
        [handledDictionary setValue:result[@"wechatId"] forKey:@"wechatId"];
    }
    
    NSString *qqIdStr = (NSString *)[result objectForKey:@"qqId"];
    if ([qqIdStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"qqId"];
    }
    else{
        [handledDictionary setValue:result[@"qqId"] forKey:@"qqId"];
    }
    
    NSString *microblogIdStr = (NSString *)[result objectForKey:@"microblogId"];
    if ([microblogIdStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"microblogId"];
    }
    else{
        [handledDictionary setValue:result[@"microblogId"] forKey:@"microblogId"];
    }
    
    NSString *nameStr = (NSString *)[result objectForKey:@"name"];
    if ([nameStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"name"];
    }
    else{
        [handledDictionary setValue:result[@"name"] forKey:@"name"];
    }
    
    NSString *nicknameStr = (NSString *)[result objectForKey:@"nickname"];
    if ([nicknameStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"nickname"];
    }
    else{
        [handledDictionary setValue:result[@"nickname"] forKey:@"nickname"];
    }
    
    NSString *telStr = (NSString *)[result objectForKey:@"tel"];
    if ([telStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"tel"];
    }
    else{
        [handledDictionary setValue:result[@"tel"] forKey:@"tel"];
    }
    
    NSString *regCityStr = (NSString *)[result objectForKey:@"regCity"];
    if ([regCityStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"regCity"];
    }
    else{
        [handledDictionary setValue:result[@"regCity"] forKey:@"regCity"];
    }
    
    NSString *creditLevelStr = (NSString *)[result objectForKey:@"creditLevel"];
    if ([creditLevelStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"creditLevel"];
    }
    else{
        [handledDictionary setValue:result[@"creditLevel"] forKey:@"creditLevel"];
    }
    
    NSString *creditScoreStr = (NSString *)[result objectForKey:@"creditScore"];
    if ([creditScoreStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"creditScore"];
    }
    else{
        [handledDictionary setValue:result[@"creditScore"] forKey:@"creditScore"];
    }
    
    NSString *invtCodeStr = (NSString *)[result objectForKey:@"invtCode"];
    if ([invtCodeStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"invtCode"];
    }
    else{
        [handledDictionary setValue:result[@"invtCode"] forKey:@"invtCode"];
    }
    
    NSString *headImgUrlStr = (NSString *)[result objectForKey:@"headImgUrl"];
    if ([headImgUrlStr isEqual:[NSNull null]]) {
        [handledDictionary setValue:@"" forKey:@"headImgUrl"];
    }
    else{
        [handledDictionary setValue:result[@"headImgUrl"] forKey:@"headImgUrl"];
    }
    [_userSignInDBManager dBUpdateWithDictionary:handledDictionary];
    
}



#pragma mark -memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MessegeVerifyViewController *messegeVerifyVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toMessegeVerify"]) {
        messegeVerifyVC.registerPhoneNumber = _phoneNumTextField.text;
        messegeVerifyVC.findPasswordEnable = SignInType;
    }
}


@end
