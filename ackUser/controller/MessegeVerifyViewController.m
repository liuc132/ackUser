//
//  MessegeVerifyViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MessegeVerifyViewController.h"
#import "ackUserPCH.pch"
#import "SimpleInformationCheck.h"
#import "SetPasswordViewController.h"
#import "PersonalDetailInformationViewController.h"
#import "UIColor+HexColor.h"
#import "HTTPRequest.h"
#import "Masonry.h"

@interface MessegeVerifyViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) HTTPRequest       *messageVerifySession;

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) UILabel           *resendMessegeLabel;
@property (strong, nonatomic) UITextField       *checkCodeTextField;

@end

@implementation MessegeVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self dataInitialization];
    [self customCreateView];
    [self startTimeCountdown];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _messageVerifySession = [HTTPRequest sharedManager];
    
}

- (void)dataInitialization
{
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
    NSString *messageSendPhone;
    if ([_findPasswordEnable isEqualToString:ChangePhoneType]) {
        messageSendPhone = _changedPhoneNumber;
    }
    else
    {
        messageSendPhone = _registerPhoneNumber;
    }
    
    
    UILabel *phoneNumberLabel = [UILabel new];
    phoneNumberLabel.numberOfLines = 0;
    phoneNumberLabel.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumberLabel.text = [NSString stringWithFormat:@"  已发送验证码短信到+86 %@",[NSString stringWithFormat:@"%@*****%@",[messageSendPhone substringWithRange:NSMakeRange(0, 3)],[messageSendPhone substringWithRange:NSMakeRange(8, 3)]]];
    phoneNumberLabel.font = [UIFont systemFontOfSize:13];
    phoneNumberLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:phoneNumberLabel];
    /*
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView0];
    */
    _checkCodeTextField = [UITextField new];
    _checkCodeTextField.userInteractionEnabled = YES;
    _checkCodeTextField.placeholder = @"请输入验证码";
    [_checkCodeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _checkCodeTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_checkCodeTextField];
    
    _resendMessegeLabel = [UILabel new];
    _resendMessegeLabel.layer.cornerRadius = 4.0;
    _resendMessegeLabel.layer.masksToBounds = YES;
    _resendMessegeLabel.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6" alpha:1.0].CGColor;
    _resendMessegeLabel.layer.borderWidth = 2.0;
    _resendMessegeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *sendCheckCodeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCheckCodeAction:)];
    sendCheckCodeGesture.delegate = self;
    sendCheckCodeGesture.numberOfTapsRequired = 1;
    sendCheckCodeGesture.numberOfTouchesRequired = 1;
    [_resendMessegeLabel addGestureRecognizer:sendCheckCodeGesture];
    _resendMessegeLabel.textAlignment = NSTextAlignmentCenter;
    _resendMessegeLabel.text = @"获取验证码";
    _resendMessegeLabel.backgroundColor = [UIColor whiteColor];
    _resendMessegeLabel.textColor = [UIColor colorFromHexString:@"#767978" alpha:1.0];
    [self.view addSubview:_resendMessegeLabel];
    
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
    [getCheckCodeButton addTarget:self action:@selector(verifyCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCheckCodeButton];
    /*
    [alreadySendMessegeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@20);
        make.top.equalTo(self.view.top).offset(10);
        make.width.equalTo(@160);
    }];
    */
    [phoneNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(self.view.top);
        make.height.equalTo(@40);
//        make.width.equalTo(@160);
    }];
    /*
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(phoneNumberLabel.bottom).offset(20);
        make.height.equalTo(@1);
    }];
    */
    [_resendMessegeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.top.equalTo(phoneNumberLabel.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    [_checkCodeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@30);
        make.top.equalTo(phoneNumberLabel.bottom).offset(10);
        make.right.equalTo(_resendMessegeLabel.left);
    }];
    
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(_checkCodeTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [getCheckCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
}

-(void)startTimeCountdown{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置 特别注明：UI的改变一定要在主线程中进行
                _resendMessegeLabel.text = @"获取验证码";
                _resendMessegeLabel.userInteractionEnabled = YES;
                _checkCodeTextField.placeholder = @"输入验证码";
                
                [self.view setNeedsDisplay];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _resendMessegeLabel.textAlignment = NSTextAlignmentCenter;
                _resendMessegeLabel.adjustsFontSizeToFitWidth = YES;
                
                [_resendMessegeLabel setText:[NSString stringWithFormat:@"%@秒后重发",strTime]];
                _resendMessegeLabel.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

- (void)getCheckCodeAction:(UITapGestureRecognizer *)sender
{
    [self startTimeCountdown];
    
    NSString *messageSendPhone;
    if ([_findPasswordEnable isEqualToString:ChangePhoneType]) {
        messageSendPhone = _changedPhoneNumber;
    }
    else
    {
        messageSendPhone = _registerPhoneNumber;
    }
    
    NSString *phoneNum = [NSString stringWithFormat:@"%@",messageSendPhone];
    if (![SimpleInformationCheck checkMobilePhoneNumberWithPhoneNumber:phoneNum]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号异常" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        return;
    }
    NSDictionary *getCheckCodeParameters = @{@"type":@"1",@"phone":phoneNum};
    [_messageVerifySession getCheckCodeWithParameter:getCheckCodeParameters success:^(id finish) {
        
    } failure:^(NSError *reqError) {
        
    }];
    
    
}

- (void)verifyCheckCode:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"检查验证码并进入设置密码...");
    
    if (_checkCodeTextField.text.length <= 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"confirm");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        return;
    }
    else
    {
        NSString *messageSendPhone;
        if ([_findPasswordEnable isEqualToString:ChangePhoneType]) {
            messageSendPhone = _changedPhoneNumber;
        }
        else
        {
            messageSendPhone = _registerPhoneNumber;
        }
        //code=2&type=1&phone=2
        NSDictionary *messageParameter = @{@"code":_checkCodeTextField.text,@"type":_findPasswordEnable,@"phone":messageSendPhone};
        [_messageVerifySession messageValidateWithParameter:messageParameter success:^(id finish) {
            NSLog(@"%@",finish);
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                if ([strongSelf.findPasswordEnable isEqualToString:ChangePhoneType]) {
                    [strongSelf confirmChangePhoneNumber];
                }
                else
                {
                    [self performSegueWithIdentifier:@"toSettingPassword" sender:nil];
                }
                
                
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
            
        } failure:^(NSError *reqError) {
            
            
        }];
        
    }
    
}

- (void)confirmChangePhoneNumber
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *changePhoneParamer = @{@"valiCode":_checkCodeTextField.text,@"newPhone":_changedPhoneNumber,@"phone":_registerPhoneNumber,@"password":_password};
    [_messageVerifySession exchangePhoneNumberToNewPhoneWithParameter:changePhoneParamer success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == RequestSuccess)
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"personalCenter" bundle:[NSBundle mainBundle]];
            PersonalDetailInformationViewController *userDetailInformationVC = [storyBoard instantiateViewControllerWithIdentifier:@"PersonalDetailInformationViewController"];
            [strongSelf.navigationController showViewController:userDetailInformationVC sender:nil];
        }
        
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
        
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(messegeVerifyBackToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"短信验证";
    
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
- (void)messegeVerifyBackToSignVC
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
    SetPasswordViewController *setpasswordVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toSettingPassword"]) {
        setpasswordVC.registerPhoneNum = _registerPhoneNumber;
        setpasswordVC.registerCheckCode = _checkCodeTextField.text;
        setpasswordVC.setPWFindPasswordEnable = _findPasswordEnable;
    }
    
    
    
}


@end
