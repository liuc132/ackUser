//
//  ChangePasswordViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ackUserPCH.pch"
#import "Masonry.h"


@interface ChangePasswordViewController ()

@property (strong, nonatomic) UIImageView       *navigationImageView;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customChangePasswordCreateView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)customChangePasswordCreateView
{
    UITextField *passwordTextField = [UITextField new];
    passwordTextField.userInteractionEnabled = YES;
    passwordTextField.placeholder = @"请输入原密码";
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    passwordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:passwordTextField];
    [passwordTextField makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(passwordTextField.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UITextField *inputNewPasswordTextField = [UITextField new];
    inputNewPasswordTextField.userInteractionEnabled = YES;
    inputNewPasswordTextField.placeholder = @"请设置新密码";
    [inputNewPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    inputNewPasswordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:inputNewPasswordTextField];
    [inputNewPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(inputNewPasswordTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UITextField *reInputPasswordTextField = [UITextField new];
    reInputPasswordTextField.userInteractionEnabled = YES;
    reInputPasswordTextField.placeholder = @"请重复您的密码";
    [reInputPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    reInputPasswordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:reInputPasswordTextField];
    [reInputPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(reInputPasswordTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIButton *confrimSettingButton = [UIButton new];
    [confrimSettingButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confrimSettingButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confrimSettingButton setTitle:@"提交" forState:UIControlStateNormal];
    [confrimSettingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimSettingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confrimSettingButton addTarget:self action:@selector(confirmChangePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confrimSettingButton];
    [confrimSettingButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UIButton *forgetPasswordButton = [UIButton new];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    [forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:forgetPasswordButton];
    [forgetPasswordButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(confrimSettingButton.bottom).offset(5);
        make.height.equalTo(@30);
    }];
    
}

- (void)forgetPasswordAction:(UIButton *)sender
{
    NSLog(@"忘记密码...");
    //
    
}

- (void)confirmChangePassword:(UIButton *)sender
{
    NSLog(@"确定密码设置...");
    
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(feedBackToSettingVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"修改密码";
    
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
- (void)feedBackToSettingVC
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
