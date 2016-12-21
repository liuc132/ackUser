//
//  ActivateOilCardViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ActivateOilCardViewController.h"
#import "ackUserPCH.pch"
#import "Masonry.h"
#import "HTTPRequest.h"
#import "ActiveOilCardView.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define alreadySetPassword          0
#define NotSetPassword              1

@interface ActivateOilCardViewController ()

@property (strong, nonatomic) HTTPRequest           *oilCardSessionManager;
@property (strong, nonatomic) ActiveOilCardView     *activeOilCardView;


@end

@implementation ActivateOilCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self customActivateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _oilCardSessionManager = [HTTPRequest sharedManager];
}

- (void)customActivateView
{
    if (_activeOilCardView == nil) {
        _activeOilCardView = [[ActiveOilCardView alloc] init];
        [self.view addSubview:_activeOilCardView];
        [_activeOilCardView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [_activeOilCardView.oilCardActiveButton addTarget:self action:@selector(confirmActiveOilCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)confirmActiveOilCardAction:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [self.view endEditing:YES];
    NSLog(@"油卡激活");
//    [self performSegueWithIdentifier:@"activeOilCardToSetPW" sender:nil];//230120005578965
//    return;
    
    NSString *cardID = [NSString stringWithFormat:@"%@",_needActiveOilCardModel.oilCardId];
    NSString *cardnumber = [NSString stringWithFormat:@"%@",_activeOilCardView.oilCardTextField.text];
    if (cardnumber.length > 20 || cardnumber.length < 14) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的油卡卡号!"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    NSDictionary *activeOilCardDictionary = @{@"cardid":cardID,@"cardnumber":cardnumber};
    [SVProgressHUD show];
    [_oilCardSessionManager activeOilCardWithParameter:activeOilCardDictionary success:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == TokenExpired) {
            NSLog(@"请重新登录");
            
        }
        else if ([finish[@"code"] integerValue] == RequestSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"激活成功!"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            NSString *isSetPW = [NSString stringWithFormat:@"%@",strongSelf.needActiveOilCardModel.issettradpwd];
            if ([isSetPW integerValue] == alreadySetPassword) {
                [strongSelf activeOilCardToOilCardListVC];
            }
            else if ([isSetPW integerValue] == NotSetPassword)
            {
                [strongSelf performSegueWithIdentifier:@"activeOilCardToSetPW" sender:nil];
            }
            
            
            
        }
        else if ([finish[@"code"] integerValue] == NoExistSuccess)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"激活失败!" message:finish[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
                
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"呼叫客户处理" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"呼叫客户处理");
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@",strongSelf.needActiveOilCardModel.tel]];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
    }];
    
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(activeOilCardToOilCardListVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.navigationItem.title = @"油卡激活";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //NSFontAttributeName
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

/**
 左侧导航按钮对应的action
 */
- (void)activeOilCardToOilCardListVC
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
