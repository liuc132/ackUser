//
//  SetPasswordViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "ackUserPCH.pch"
#import "RemoveAccountView.h"
#import "HTTPRequest.h"
#import "PersonalDetailInformationViewController.h"
#import "HomePageViewController.h"
#import "Masonry.h"
#import "AFURLRequestSerialization.h"

@interface SetPasswordViewController ()<UIGestureRecognizerDelegate>
{
    RemoveAccountView *finishSetPasswordNoteView;
}

@property (strong, nonatomic) HTTPRequest                   *setPasswordSession;

@property (strong, nonatomic) UIImageView                   *navigationImageView;

@property (strong, nonatomic) UITextField                   *passwordTextField;
@property (strong, nonatomic) UITextField                   *reInputPasswordTextField;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customCreateView];
    [self settingNavBar];
    [self networkInitialization];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


#pragma mark -privateMethod

- (void)networkInitialization
{
    _setPasswordSession = [HTTPRequest sharedManager];
    
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
    _passwordTextField = [UITextField new];
    _passwordTextField.userInteractionEnabled = YES;
    _passwordTextField.placeholder = @"请输入6-20位数字或字母";
    _passwordTextField.secureTextEntry = YES;
    [_passwordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_passwordTextField];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    
    _reInputPasswordTextField = [UITextField new];
    _reInputPasswordTextField.secureTextEntry = YES;
    _reInputPasswordTextField.userInteractionEnabled = YES;
    _reInputPasswordTextField.placeholder = @"请重复输入您的登录密码";
    [_reInputPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _reInputPasswordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_reInputPasswordTextField];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView0];
    
    
    UIButton *confrimSettingButton = [UIButton new];
    confrimSettingButton.layer.cornerRadius = 4.0;
    confrimSettingButton.layer.masksToBounds = YES;
    [confrimSettingButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confrimSettingButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confrimSettingButton setTitle:@"确定" forState:UIControlStateNormal];
    [confrimSettingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimSettingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confrimSettingButton addTarget:self action:@selector(confirmSetForCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confrimSettingButton];
    
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.height.equalTo(@30);
        make.top.equalTo(self.view.top).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.height.equalTo(@1);
        make.top.equalTo(_passwordTextField.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [_reInputPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(_reInputPasswordTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [confrimSettingButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    if (finishSetPasswordNoteView == nil) {
        finishSetPasswordNoteView = [[RemoveAccountView alloc] init];
        [finishSetPasswordNoteView dismissRemoveAccountViewAction];
        [self.navigationController.view addSubview:finishSetPasswordNoteView];
        [finishSetPasswordNoteView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        finishSetPasswordNoteView.noteTitleLabel.text = @"注册成功";
        finishSetPasswordNoteView.noteSubTitleLabel.text = @"您已成功注册爱车贴领任务赚油卡，还需善个人资料和车辆信息";
        [finishSetPasswordNoteView.removeAccountCancelButton setTitle:@"现在就去" forState:UIControlStateNormal];
        [finishSetPasswordNoteView.removeAccountCancelButton addTarget:self action:@selector(finishPersonalInformation) forControlEvents:UIControlEventTouchUpInside];
        [finishSetPasswordNoteView.removeAccountConfirmButton setTitle:@"先逛逛再说" forState:UIControlStateNormal];
        [finishSetPasswordNoteView.removeAccountConfirmButton addTarget:self action:@selector(enterHomeView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)finishPersonalInformation
{
    NSLog(@"完善资料");
    [finishSetPasswordNoteView dismissRemoveAccountViewAction];
    [self performSegueWithIdentifier:@"setPasswordToPersonalDetail" sender:nil];
    
}

- (void)enterHomeView
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"先逛逛再说");
    [finishSetPasswordNoteView dismissRemoveAccountViewAction];
    UIStoryboard *homePageStoryboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:[NSBundle mainBundle]];
    HomePageViewController *homePageVC = [homePageStoryboard instantiateViewControllerWithIdentifier:@"HomePage"];
    homePageVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController popToRootViewControllerAnimated:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController showViewController:homePageVC sender:nil];
    });
    
    
}

- (void)confirmSetForCheckCode:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    //
    if (_passwordTextField.text.length < 6) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码设置不能少于六位" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    else if (_passwordTextField.text.length > 20) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码设置不能多于20位" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    
    else if (![_passwordTextField.text isEqualToString:_reInputPasswordTextField.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码设置不一致" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    NSString *password = [NSString stringWithFormat:@"%@",_passwordTextField.text];
    
    if ([_setPWFindPasswordEnable isEqualToString:FindBackPasswordType]) {
        NSDictionary *setpasswordParameters = @{@"phone":_registerPhoneNum,@"code":_registerCheckCode,@"newPwd":password,@"type":FindBackPasswordType};
        [_setPasswordSession findPasswordWithParameter:setpasswordParameters success:^(id finish) {
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码修改成功!" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                    
                }]];
                
                [self presentViewController:alertController animated:YES completion: nil];
                
            }
            
            
        } failure:^(NSError *reqError) {
            
        }];
    }
    else if([_setPWFindPasswordEnable isEqualToString:RegisterType])
    {
        NSDictionary *setpasswordParameters = @{@"phone":_registerPhoneNum,@"code":_registerCheckCode,@"password":password,@"type":RegisterType};
        [_setPasswordSession registerSetPasswordWithParameter:setpasswordParameters success:^(id finish) {
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                [finishSetPasswordNoteView showRemoveAccountView];
            }
            
            
        } failure:^(NSError *reqError) {
            
        }];
    }
    else if ([_setPWFindPasswordEnable isEqualToString:SignInType])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(setPasswordBackToMessegeVerify)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"手机登录密码设置";
    
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
- (void)setPasswordBackToMessegeVerify
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
    PersonalDetailInformationViewController *pcDetailVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"setPasswordToPersonalDetail"]) {
        pcDetailVC.userTel = _registerPhoneNum;
        pcDetailVC.isFinishUserData = YES;
    }
    
}


@end
