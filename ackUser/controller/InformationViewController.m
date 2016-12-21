//
//  InformationViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "InformationViewController.h"
#import "ackUserPCH.pch"
#import "HTTPRequest.h"
#import "Masonry.h"


@interface InformationViewController ()

@property (strong, nonatomic) UIImageView       *navigationImageView;

@property (strong, nonatomic) HTTPRequest       *informationSession;


@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self findNavigationBarDownLine];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self settingNavBar];
//    
    self.navigationController.navigationBarHidden = YES;
//
//    self.navigationImageView.hidden = YES;
    
}

#pragma mark -privateMethod
- (void)signInDataInitialization
{
    
    
    
}

- (void)settingDataInitialization
{
    
    
    
}

- (void)settingNetwork
{
    _informationSession = [HTTPRequest sharedManager];
    
}

- (void)customCreateView
{
    
    
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
    
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_home_messege_RightBar"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction)];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0]];
    //去掉导航栏最下边的分割线
    
    
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction
{
    NSLog(@"注册...");
    
    [self performSegueWithIdentifier:@"toRegisterVC" sender:nil];
    
}

- (void)forgetPasswordAction:(UIButton *)sender
{
    NSLog(@"忘记密码");
    
    [self performSegueWithIdentifier:@"toForgetVC" sender:nil];
    
    
}

- (void)filterResultDataWithDictionary:(NSDictionary *)result
{
    
    
}


#pragma mark -memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}


@end
