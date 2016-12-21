//
//  AckCoinAccountViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/17.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AckCoinAccountViewController.h"
#import "ackUserPCH.pch"
#import "HTTPRequest.h"
#import "UIColor+HexColor.h"
#import "UINavigationBar+Awesome.h"
#import "Masonry.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface AckCoinAccountViewController ()

@property (strong, nonatomic) UIImageView       *navigationImageView;

@property (strong, nonatomic) HTTPRequest       *ackCoinAccountSessionManager;
@property (copy, nonatomic)   NSString          *ackCoinLeftString;

@property (strong, nonatomic) UIButton          *ackCoinLeftButton;


@end

@implementation AckCoinAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self dataInitialization];
    [self findNavigationBarDownLine];
    [self customAckCoinAccountView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self settingNavBar];
    
    self.navigationImageView.hidden = YES;
    [self.view setNeedsDisplay];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _ackCoinAccountSessionManager = [HTTPRequest sharedManager];
    
}

- (void)dataInitialization
{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [_ackCoinAccountSessionManager getAckCoinAccountSuccess:^(id finish) {
        NSLog(@"%@",finish);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSDictionary *resultDictionary = finish[@"data"];
            NSLog(@"%@",resultDictionary);
            strongSelf.ackCoinLeftString = [NSString stringWithFormat:@"%@",resultDictionary[@"score"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf setAckCoinButton];
            });
            [SVProgressHUD dismiss];
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            [SVProgressHUD showErrorWithStatus:finish[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
        
    }];
    
    
}

- (void)setAckCoinButton
{
    NSString *ackCoinLeftString = [NSString stringWithFormat:@"%@\n可用爱车币",_ackCoinLeftString];//@"5000000     可用爱车币";
    NSInteger ackCoinLength = _ackCoinLeftString.length;
    NSMutableAttributedString *ackCoinLeftAttrStr = [[NSMutableAttributedString alloc] initWithString:ackCoinLeftString];
    //setting font
    [ackCoinLeftAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(ackCoinLength + 1, 5)];
    [ackCoinLeftAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, ackCoinLength)];
    [ackCoinLeftAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fca51b" alpha:1.0] range:NSMakeRange(0, ackCoinLength)];
    [ackCoinLeftAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#83817d" alpha:1.0] range:NSMakeRange(ackCoinLength + 1, 5)];
    [_ackCoinLeftButton setAttributedTitle:ackCoinLeftAttrStr forState:UIControlStateNormal];
    [_ackCoinLeftButton setTitle:ackCoinLeftString forState:UIControlStateNormal];
}

- (void)customAckCoinAccountView
{
    UIImageView *ackCoinAccountImageView = [UIImageView new];
    ackCoinAccountImageView.layer.masksToBounds = YES;
    ackCoinAccountImageView.contentMode = UIViewContentModeScaleAspectFill;
    ackCoinAccountImageView.image = [UIImage imageNamed:@"icon_personalCenter_backImage"];
    [self.view addSubview:ackCoinAccountImageView];
    [ackCoinAccountImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(-64);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@264);
    }];
    
    _ackCoinLeftButton = [UIButton new];
    _ackCoinLeftButton.layer.cornerRadius = 50.0;
    _ackCoinLeftButton.layer.masksToBounds = YES;
    _ackCoinLeftButton.layer.borderWidth = 2.0;
    _ackCoinLeftButton.adjustsImageWhenHighlighted = NO;
    _ackCoinLeftButton.layer.borderColor = [UIColor colorFromHexString:@"#feab4a" alpha:1.0].CGColor;
    _ackCoinLeftButton.titleLabel.numberOfLines = 0;
    _ackCoinLeftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_ackCoinLeftButton setBackgroundImage:[UIImage imageNamed:@"icon_ackCoinAccountLeft_button"] forState:UIControlStateNormal];
    [self.view addSubview:_ackCoinLeftButton];
    [_ackCoinLeftButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.view.top).equalTo(@74);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];

    
    UITextField *phoneNumTextField = [UITextField new];
    phoneNumTextField.userInteractionEnabled = YES;
    phoneNumTextField.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    phoneNumTextField.placeholder = @"请输入爱车币数";
    [phoneNumTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    phoneNumTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:phoneNumTextField];
    [phoneNumTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.height.equalTo(@40);
        make.top.equalTo(ackCoinAccountImageView.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(phoneNumTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *ackCoinDifferenceLabel = [UILabel new];
    ackCoinDifferenceLabel.numberOfLines = 0;
    ackCoinDifferenceLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinDifferenceLabel.font = [UIFont systemFontOfSize:13];
    ackCoinDifferenceLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    NSString *ackCoinDifferenceString = @"1爱车币=0.01元";
    ackCoinDifferenceLabel.text = ackCoinDifferenceString;
    [self.view addSubview:ackCoinDifferenceLabel];
    [ackCoinDifferenceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(separetedView.bottom).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    UILabel *ackCoinNoteLabel = [UILabel new];
    ackCoinNoteLabel.numberOfLines = 0;
    ackCoinNoteLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinNoteLabel.font = [UIFont systemFontOfSize:15];
    ackCoinNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    NSString *ackCoinNoteString = @"使用爱车币充值油卡必须为5000的倍数";
    ackCoinNoteLabel.text = ackCoinNoteString;
    [self.view addSubview:ackCoinNoteLabel];
    [ackCoinNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(ackCoinDifferenceLabel.bottom).equalTo(@5);
        make.width.equalTo(@270);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(ackCoinNoteLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    
    
    UIButton *getCheckCodeButton = [UIButton new];
    getCheckCodeButton.layer.cornerRadius = 4.0;
    getCheckCodeButton.layer.masksToBounds = YES;
    [getCheckCodeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    getCheckCodeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [getCheckCodeButton setTitle:@"立即充值" forState:UIControlStateNormal];
    [getCheckCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCheckCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCheckCodeButton addTarget:self action:@selector(chargeRightNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCheckCodeButton];
    [getCheckCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
}

- (void)chargeRightNow:(UIButton *)sender
{
    NSLog(@"立即充值...");
    [self performSegueWithIdentifier:@"ackCoinAccountToExchangePassword" sender:nil];
    
    
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
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"爱车币账户";
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)forgetBackToSignVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ViewExchangeDetail
{
    NSLog(@"查看交易明细...");
    [self performSegueWithIdentifier:@"ackCoinAccountToExchangeDetail" sender:nil];
    
}



#pragma mark memoryWarning
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
