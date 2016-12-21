//
//  ForgetPasswordViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/15.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ackUserPCH.pch"
#import "SimpleInformationCheck.h"
#import "MessegeVerifyViewController.h"
#import "Masonry.h"

@interface ForgetPasswordViewController ()

@property (strong, nonatomic) UIImageView *navigationImageView;

@property (strong, nonatomic) UITextField *phoneNumTextField;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNavBar];
    
    [self customCreateView];
    
    
}

#pragma mark -privateMethod

- (void)customCreateView
{
    _phoneNumTextField = [UITextField new];
    _phoneNumTextField.userInteractionEnabled = YES;
    _phoneNumTextField.placeholder = @"请输入手机号";
    [_phoneNumTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_phoneNumTextField];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    
    UIButton *getCheckCodeButton = [UIButton new];
    getCheckCodeButton.layer.cornerRadius = 4.0;
    getCheckCodeButton.layer.masksToBounds = YES;
    [getCheckCodeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    getCheckCodeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [getCheckCodeButton setTitle:@"确定" forState:UIControlStateNormal];
    [getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCheckCodeButton addTarget:self action:@selector(getCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCheckCodeButton];
    
    [_phoneNumTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@40);
        make.top.equalTo(self.view.top).offset(20);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(_phoneNumTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [getCheckCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
}

- (void)getCheckCode:(UIButton *)sender
{
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
    
    [self performSegueWithIdentifier:@"forgetPasswordToVerify" sender:nil];
    
    
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
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
//    
//    
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"手机验证";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
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











#pragma mark memoryWarning
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
    if ([segue.identifier isEqualToString:@"forgetPasswordToVerify"]) {
        messegeVerifyVC.registerPhoneNumber = _phoneNumTextField.text;
        messegeVerifyVC.findPasswordEnable = FindBackPasswordType;
    }
    
}


@end
