//
//  RegisterViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/15.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "RegisterViewController.h"
#import "ackUserPCH.pch"
#import "MessegeVerifyViewController.h"
#import "SimpleInformationCheck.h"
#import "HTTPRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Masonry.h"

@interface RegisterViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView                   *navigationImageView;
@property (strong, nonatomic) UITextField                   *phoneNumTextField;

@property (strong, nonatomic) HTTPRequest                   *registerSessionManager;

@property (assign, nonatomic) BOOL                          agreeProtocolEnable;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataInitialization];
    [self networkInitialization];
    [self customCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark -privateMethod

- (void)dataInitialization
{
    _agreeProtocolEnable = YES;
}

- (void)networkInitialization
{
    _registerSessionManager = [HTTPRequest sharedManager];
    
    UITapGestureRecognizer *tapDismissKeyboardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismissAction)];
    tapDismissKeyboardGesture.delegate = self;
    tapDismissKeyboardGesture.numberOfTouchesRequired = 1;
    tapDismissKeyboardGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapDismissKeyboardGesture];
}

- (void)tapDismissAction
{
    [self.view endEditing:YES];
}

- (void)customCreateView
{
    UIImageView *ackImageLogo = [UIImageView new];
    ackImageLogo.image = [UIImage imageNamed:@"personalCenter_logo"];
    ackImageLogo.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:ackImageLogo];
    
    _phoneNumTextField = [UITextField new];
    _phoneNumTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _phoneNumTextField.userInteractionEnabled = YES;
    _phoneNumTextField.placeholder = @"请输入手机号";
    [_phoneNumTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_phoneNumTextField];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    
    UIButton *selectAgreeProtocolButton = [UIButton new];
    [selectAgreeProtocolButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    [selectAgreeProtocolButton setImage:[UIImage imageNamed:@"personalCenterSignIn_select"] forState:UIControlStateNormal];
    [selectAgreeProtocolButton addTarget:self action:@selector(agreeProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    selectAgreeProtocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:selectAgreeProtocolButton];
    
    UILabel *agreeLabel = [UILabel new];
    agreeLabel.text = @"我已同意";
    agreeLabel.font = [UIFont systemFontOfSize:12];
    agreeLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:agreeLabel];
    
    UIButton *viewProtocolButton = [UIButton new];
    viewProtocolButton.userInteractionEnabled = YES;
    [viewProtocolButton addTarget:self action:@selector(viewProtocolAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewProtocolButton setTitleColor:[UIColor colorWithRed:5/255.0 green:97/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
    [viewProtocolButton setTitle:@"《爱车贴协议》" forState:UIControlStateNormal];
    viewProtocolButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:viewProtocolButton];
    
    UIButton *getCheckCodeButton = [UIButton new];
    getCheckCodeButton.layer.cornerRadius = 4.0;
    getCheckCodeButton.layer.masksToBounds = YES;
    [getCheckCodeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    getCheckCodeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [getCheckCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCheckCodeButton addTarget:self action:@selector(requestForCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCheckCodeButton];
    
    
    [ackImageLogo makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.equalTo(@60);
        make.width.equalTo(@120);
    }];
    
    [_phoneNumTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@40);
        make.top.equalTo(ackImageLogo.bottom).offset(60);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(_phoneNumTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [selectAgreeProtocolButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@30);
        make.top.equalTo(separetedView.bottom).offset(70);
        make.height.equalTo(@30);
    }];
    
    [agreeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectAgreeProtocolButton.right).offset(5);
        make.width.equalTo(@50);
        make.top.equalTo(separetedView.bottom).offset(70);
        make.height.equalTo(@30);
        
    }];
    
    [viewProtocolButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreeLabel.right).offset(5);
        make.width.equalTo(@90);
        make.top.equalTo(separetedView.bottom).offset(70);
        make.height.equalTo(@30);
    }];
    
    [getCheckCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(viewProtocolButton.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
}


- (void)agreeProtocolAction:(UIButton *)sender
{
    NSLog(@"选择是否同意协议...");
    
    if (_agreeProtocolEnable) {
        _agreeProtocolEnable = NO;
        [sender setImage:[UIImage imageNamed:@"personalCenterSignIn_unselect"] forState:UIControlStateNormal];
    }
    else
    {
        _agreeProtocolEnable = YES;
        [sender setImage:[UIImage imageNamed:@"personalCenterSignIn_select"] forState:UIControlStateNormal];
    }
    
}

- (void)viewProtocolAction:(UIButton *)sender
{
    NSLog(@"进入协议页面....");
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"signIn_close"] style:UIBarButtonItemStylePlain target:self action:@selector(backToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    
    
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
- (void)backToSignVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)signInAccountAction
{
    NSLog(@"登录已有账号...");
    [self backToSignVC];
    
}

- (void)requestForCheckCode:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"获取验证吗...");
    NSString *phoneNum = [NSString stringWithFormat:@"%@",_phoneNumTextField.text];
    if (![SimpleInformationCheck checkMobilePhoneNumberWithPhoneNumber:phoneNum]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入手机号异常" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        return;
    }
    
    if (!_agreeProtocolEnable) {
        [SVProgressHUD showErrorWithStatus:@"请同意协议!"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary *userTelParameters = @{@"phone":phoneNum};
    [_registerSessionManager userExistedWithParameter:userTelParameters success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",finish);
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSDictionary *getCheckCodeParameters = @{@"type":RegisterType,@"phone":phoneNum};
            [strongSelf.registerSessionManager getCheckCodeWithParameter:getCheckCodeParameters success:^(id finish) {
                NSLog(@"%@",finish);
                if ([finish[@"code"] integerValue] == RequestSuccess) {
                    [self performSegueWithIdentifier:@"registerToMessegeVerify" sender:nil];
                    
                    
                }
                else if ([finish[@"code"] integerValue] == TokenExpired)
                {
                    
                }
                
                
            } failure:^(NSError *reqError) {
                NSLog(@"error:%@",reqError.localizedDescription);
                
            }];
            
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancle");
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *reqError) {
        NSLog(@"error:%@",reqError.localizedDescription);
        
    }];
    
    
}



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
    if ([segue.identifier isEqualToString:@"registerToMessegeVerify"]) {
        messegeVerifyVC.registerPhoneNumber = _phoneNumTextField.text;
        messegeVerifyVC.findPasswordEnable = RegisterType;
    }
    
}


@end
