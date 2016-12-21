//
//  PersonalCenterViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ackUserPCH.pch"
#import "AckUserDBManager.h"
#import "PersonalCenterView.h"
#import "HTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "PersonalDetailInformationViewController.h"
#import "Masonry.h"

@interface PersonalCenterViewController ()<UIGestureRecognizerDelegate>
{
    PersonalCenterView *personalCenterView;
}

@property (assign, nonatomic) BOOL                  signInTag;
@property (strong, nonatomic) AckUserDBManager      *personalCenterDBManager;

@property (strong, nonatomic) HTTPRequest           *personalCenterSession;


@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden=NO;
    
    _signInTag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"signInTag"] boolValue];
    
    [self customCreatePersonalCenterSignInView];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.signInTag) {
            [strongSelf dataInitialization];
        }
        
    });
    
    [self.tabBarController setSelectedIndex:2];
    
    
}


#pragma mark -privateMethod
- (void)settingNetWork
{
    _personalCenterSession = [HTTPRequest sharedManager];
    
}

- (void)getPersonalCenterMainData
{
    [_personalCenterSession getPersonalCenterInformationComplete:^(id finish) {
        NSLog(@"%@",finish);
        
        
    } failure:^(NSError *reqError) {
        NSLog(@"error:%@",reqError.localizedDescription);
        
        
    }];
}

- (void)dataInitialization
{
    _personalCenterDBManager = [AckUserDBManager sharedManager];
    [_personalCenterDBManager getCachedDataComplete:^(NSMutableArray *result) {
        NSLog(@"result:%@",result);
        for (NSDictionary *userInfoDic in result) {
            NSLog(@"signInID:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"signInID"]);
            if ([userInfoDic[@"userID"] isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"signInID"]]]) {
                personalCenterView.userNickNameLabel.text = userInfoDic[@"userName"];
                [personalCenterView.headBackImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",userInfoDic[@"headImgUrl"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"icon_personalCenter_backImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        personalCenterView.headBackImageView.image = image;
                    }
                }];
            }
        }
        
        
        
    }];
}

- (void)customCreatePersonalCenterSignInView
{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (personalCenterView == nil) {
            personalCenterView = [[PersonalCenterView alloc] init];
            [strongSelf.view addSubview:personalCenterView];
            [personalCenterView makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(strongSelf.view);
                make.height.equalTo(@(SCREEN_HEIGHT));
                make.width.equalTo(@(SCREEN_WIDTH));
            }];
            
            [personalCenterView.personalInformationButton addTarget:self action:@selector(enterDetailInformationViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterMyTaskButton addTarget:self action:@selector(enterMyTaskAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterMyCarButton addTarget:self action:@selector(enterMyCarAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterPetroleumChargeButton addTarget:self action:@selector(enterChargeOilCard:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterCoinAccountButton addTarget:self action:@selector(ackCoinAccountAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterInviteButton addTarget:self action:@selector(enterInviteFriendAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterHelpButton addTarget:self action:@selector(enterHelpAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterSettingButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.personalCenterHotLineButton addTarget:self action:@selector(enterHotLine:) forControlEvents:UIControlEventTouchUpInside];
            [personalCenterView.registerRightNowButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UITapGestureRecognizer *userLevelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(creditScoreAction:)];
            userLevelTapGesture.delegate = strongSelf;
            userLevelTapGesture.numberOfTapsRequired = 1;
            userLevelTapGesture.numberOfTouchesRequired = 1;
//            [personalCenterView.userLevelView addGestureRecognizer:userLevelTapGesture];
            
            UITapGestureRecognizer *finishInformationRewardGesture = [[UITapGestureRecognizer alloc] initWithTarget:strongSelf action:@selector(enterPersonalInforAction:)];
            finishInformationRewardGesture.delegate = strongSelf;
            finishInformationRewardGesture.numberOfTouchesRequired = 1;
            finishInformationRewardGesture.numberOfTapsRequired = 1;
            personalCenterView.finishInformationRewardLabel.userInteractionEnabled = YES;
            [personalCenterView.finishInformationRewardLabel addGestureRecognizer:finishInformationRewardGesture];
            
            UITapGestureRecognizer *ackCoinTotalGesture = [[UITapGestureRecognizer alloc] initWithTarget:strongSelf action:@selector(ackCoinAccount:)];
            ackCoinTotalGesture.delegate = strongSelf;
            ackCoinTotalGesture.numberOfTouchesRequired = 1;
            ackCoinTotalGesture.numberOfTapsRequired = 1;
            [personalCenterView.ackCoinTotalView addGestureRecognizer:ackCoinTotalGesture];
            
            UITapGestureRecognizer *creditTotalScoresGesture = [[UITapGestureRecognizer alloc] initWithTarget:strongSelf action:@selector(creditScoreAction:)];
            creditTotalScoresGesture.delegate = strongSelf;
            creditTotalScoresGesture.numberOfTouchesRequired = 1;
            creditTotalScoresGesture.numberOfTapsRequired = 1;
            [personalCenterView.userCreditscoreView addGestureRecognizer:creditTotalScoresGesture];
            
        }
        
        if (strongSelf.signInTag) {
            [personalCenterView signInLayoutUpdate];
            
        }
        else
        {
            [personalCenterView signOutLayoutUpdate];
            
        }
        
    });
    
    
    
    
    
    
}

- (void)creditScoreAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"进入信用积分页面...");
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"personalCenterToCreditScoreVC" sender:nil];
    
    
}

- (void)enterHotLine:(UIButton *)sender
{
    NSLog(@"平台热线...");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"02361820001"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{@"":@""} completionHandler:nil];
}

- (void)enterHelpAction:(UIButton *)sender
{
    NSLog(@"帮助...");
    
}

- (void)enterInviteFriendAction:(UIButton *)sender
{
    NSLog(@"邀请好友...");
    
}

- (void)enterMyTaskAction:(UIButton *)sender
{
    NSLog(@"我的任务...");
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToMyTaskVC" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)enterMyCarAction:(UIButton *)sender
{
    NSLog(@"我的车辆...");
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToMyCar" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)settingAction:(UIButton *)sender
{
    NSLog(@"设置...");
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToSetting" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)ackCoinAccountAction:(UIButton *)sender
{
    NSLog(@"爱车币账户...");
    [self ackCoinEnter];
    
}

- (void)ackCoinAccount:(UITapGestureRecognizer *)sender
{
    [self ackCoinEnter];
    
}

- (void)creditTotalScoreAction:(UITapGestureRecognizer *)sender
{
    
    
}

- (void)ackCoinEnter
{
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToAckCoinVC" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)cashAccountAction:(UIButton *)sender
{
    NSLog(@"现金账户...");
    if (_signInTag) {
        [self performSegueWithIdentifier:@"settingVCToCashAccount" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
    
    
}


- (void)enterChargeOilCard:(UIButton *)sender
{
    NSLog(@"油卡充值...");
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToChargeOilCard" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    
    self.tabBarController.tabBar.hidden=YES;
    
}


- (void)enterDetailInformationViewAction:(UIButton *)sender
{
    [self detailInformation];
    
}

- (void)enterPersonalInforAction:(UITapGestureRecognizer *)sender
{
    [self detailInformation];
    
}

- (void)detailInformation
{
    if (_signInTag) {
        [self performSegueWithIdentifier:@"personalCenterToDetailInformation" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    }
    self.tabBarController.tabBar.hidden=YES;
    
}


- (void)enterSignInViewAction:(UIButton *)sender
{
    
}

- (void)registerButtonAction:(UIButton *)sender
{
    NSLog(@"注册...");
    [self performSegueWithIdentifier:@"personalCenterToRegisteVC" sender:nil];
    self.tabBarController.tabBar.hidden=YES;
    
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
    PersonalDetailInformationViewController *personaldetailVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"personalCenterToDetailInformation"]) {
        personaldetailVC.isFinishUserData = NO;
    }
    
}


- (IBAction)signIn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toSignIn" sender:nil];
    self.tabBarController.tabBar.hidden=YES;
    
}
@end
