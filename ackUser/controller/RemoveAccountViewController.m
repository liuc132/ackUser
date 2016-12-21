//
//  RemoveAccountViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "RemoveAccountViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"
#import "SVProgressHUD.h"


@interface RemoveAccountViewController ()

@property (strong, nonatomic) UIImageView       *navigationImageView;


@end

@implementation RemoveAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customRemoveAccountCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod
- (void)customRemoveAccountCreateView
{
    UITextField *phoneNumberTextField = [UITextField new];
    phoneNumberTextField.userInteractionEnabled = YES;
    phoneNumberTextField.placeholder = @"请输入原手机号";
    [phoneNumberTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    phoneNumberTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:phoneNumberTextField];
    [phoneNumberTextField makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(phoneNumberTextField.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UITextField *inputPasswordTextField = [UITextField new];
    inputPasswordTextField.userInteractionEnabled = YES;
    inputPasswordTextField.placeholder = @"请输入登录密码";
    [inputPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    inputPasswordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:inputPasswordTextField];
    [inputPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(inputPasswordTextField.bottom).offset(10);
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
    
    
}

- (void)confirmVerifyID:(UIButton *)sender
{
    NSLog(@"confirm...");
    
    [SVProgressHUD showErrorWithStatus:@"注销成功!"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(changePasswordToSettingVC)];
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
- (void)changePasswordToSettingVC
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
