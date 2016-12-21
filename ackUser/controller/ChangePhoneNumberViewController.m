//
//  ChangePhoneNumberViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ChangePhoneNumberViewController.h"
#import "ackUserPCH.pch"
#import "MessegeVerifyViewController.h"
#import "HTTPRequest.h"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@interface ChangePhoneNumberViewController ()

@property (strong, nonatomic) UIImageView           *navigationImageView;
@property (strong, nonatomic) UITextField           *phoneNumberTextField;

@property (strong, nonatomic) HTTPRequest           *changeTelSessionManager;

@end

@implementation ChangePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self customRemoveAccountCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _changeTelSessionManager = [HTTPRequest sharedManager];
    
}

- (void)customRemoveAccountCreateView
{
    _phoneNumberTextField = [UITextField new];
    _phoneNumberTextField.userInteractionEnabled = YES;
    _phoneNumberTextField.placeholder = @"请输入新手机号";
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
        make.left.equalTo(self.view.left);
        make.height.equalTo(@1);
        make.top.equalTo(_phoneNumberTextField.bottom).offset(10);
        make.right.equalTo(self.view.right);
    }];
    
    UIButton *confrimIDVerifyButton = [UIButton new];
    confrimIDVerifyButton.layer.cornerRadius = 4.0;
    confrimIDVerifyButton.layer.masksToBounds = YES;
    [confrimIDVerifyButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confrimIDVerifyButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confrimIDVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [confrimIDVerifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimIDVerifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confrimIDVerifyButton addTarget:self action:@selector(confirmVerifyID:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confrimIDVerifyButton];
    [confrimIDVerifyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    
}

- (void)confirmVerifyID:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"confirm...");
    NSDictionary *changePhoneParameter = @{@"type":ChangePhoneType,@"phone":_phoneNumberTextField.text};
    [_changeTelSessionManager getCheckCodeWithParameter:changePhoneParameter success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            [strongSelf jumpToMessageInterface];
            
        }
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
    }];
    
}

- (void)jumpToMessageInterface
{
    UIStoryboard *homePageStoryboard = [UIStoryboard storyboardWithName:@"personalCenter" bundle:[NSBundle mainBundle]];
    MessegeVerifyViewController *messageVerifyVC = [homePageStoryboard instantiateViewControllerWithIdentifier:@"MessegeVerifyViewController"];
    messageVerifyVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    messageVerifyVC.findPasswordEnable = ChangePhoneType;
    messageVerifyVC.changedPhoneNumber = _phoneNumberTextField.text;
    messageVerifyVC.registerPhoneNumber = _userPhoneNumber;
    messageVerifyVC.password = _userPassword;
    [self.navigationController showViewController:messageVerifyVC sender:nil];
    
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
    
    self.navigationItem.title = @"修改手机号";
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
