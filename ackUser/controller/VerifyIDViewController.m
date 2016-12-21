//
//  VerifyIDViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "VerifyIDViewController.h"
#import "ackUserPCH.pch"
#import "SimpleInformationCheck.h"
#import "ChangePhoneNumberViewController.h"
#import "HTTPRequest.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

@interface VerifyIDViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView       *navigationImageView;

@property (strong, nonatomic) UITextField       *phoneNumberTextField;
@property (strong, nonatomic) UITextField       *inputPasswordTextField;

@property (strong, nonatomic) HTTPRequest       *userIDCheckSessionManager;


@end

@implementation VerifyIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self customUserIDCheckCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _userIDCheckSessionManager = [HTTPRequest sharedManager];
    
}

- (void)customUserIDCheckCreateView
{
    _phoneNumberTextField = [UITextField new];
    _phoneNumberTextField.userInteractionEnabled = YES;
    _phoneNumberTextField.placeholder = @"请输入原手机号";
    [_phoneNumberTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumberTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_phoneNumberTextField];
    [_phoneNumberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.height.equalTo(@30);
        make.top.equalTo(self.view.top).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.height.equalTo(@1);
        make.top.equalTo(_phoneNumberTextField.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    _inputPasswordTextField = [UITextField new];
    _inputPasswordTextField.userInteractionEnabled = YES;
    _inputPasswordTextField.secureTextEntry = YES;
    _inputPasswordTextField.placeholder = @"请输入登录密码";
    [_inputPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _inputPasswordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_inputPasswordTextField];
    [_inputPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(_inputPasswordTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIButton *confrimIDVerifyButton = [UIButton new];
    confrimIDVerifyButton.layer.cornerRadius = 4.0;
    confrimIDVerifyButton.layer.masksToBounds = YES;
    [confrimIDVerifyButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confrimIDVerifyButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confrimIDVerifyButton setTitle:@"确定" forState:UIControlStateNormal];
    [confrimIDVerifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimIDVerifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confrimIDVerifyButton addTarget:self action:@selector(confirmVerifyID:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confrimIDVerifyButton];
    [confrimIDVerifyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UITapGestureRecognizer *tapDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAction)];
    tapDismissGesture.delegate = self;
    tapDismissGesture.numberOfTapsRequired = 1;
    tapDismissGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapDismissGesture];
    
}

- (void)dismissKeyboardAction
{
    [self.view endEditing:YES];
}

- (void)confirmVerifyID:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    
    NSString *phoneNum = [NSString stringWithFormat:@"%@",_phoneNumberTextField.text];
    NSString *password = [NSString stringWithFormat:@"%@",_inputPasswordTextField.text];
    
    if (![SimpleInformationCheck checkMobilePhoneNumberWithPhoneNumber:phoneNum] || (password.length < 6)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入手机号或者密码错误!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    
    NSDictionary *checkTelParameter = @{@"phone":phoneNum,@"password":password};
    
    [_userIDCheckSessionManager checkOldPhoneNumWithParameter:checkTelParameter success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            [strongSelf performSegueWithIdentifier:@"verifyIDToMessage" sender:nil];
            
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(changePhoneToPersonalCenterVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"身份验证";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //去掉导航栏最下边的分割线
    
    
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)changePhoneToPersonalCenterVC
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
    ChangePhoneNumberViewController *changeNumberVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"verifyIDToMessage"]) {
        changeNumberVC.userPhoneNumber = _phoneNumberTextField.text;
        changeNumberVC.userPassword = _inputPasswordTextField.text;
    }
    
}


@end
