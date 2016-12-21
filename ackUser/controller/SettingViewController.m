//
//  SettingViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SettingViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "RemoveAccountView.h"
#import "Masonry.h"

@interface SettingViewController ()<UIGestureRecognizerDelegate>
{
    RemoveAccountView *removeAccountNoteView;
}

@property (strong, nonatomic) UIImageView       *navigationImageView;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customSettingInterfaceView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)customSettingInterfaceView
{
    UIView *changeExchangePWView = [UIView new];
    UITapGestureRecognizer *changeExchangePWGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeExchangePasswordAction:)];
    changeExchangePWGesture.delegate = self;
    changeExchangePWGesture.numberOfTapsRequired = 1;
    changeExchangePWGesture.numberOfTouchesRequired = 1;
    [changeExchangePWView addGestureRecognizer:changeExchangePWGesture];
    changeExchangePWView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:changeExchangePWView];
    [changeExchangePWView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *exchangPWImageView = [UIImageView new];
    exchangPWImageView.image = [UIImage imageNamed:@"setting_changeExchangePassword"];
    exchangPWImageView.contentMode = UIViewContentModeScaleAspectFill;
    [changeExchangePWView addSubview:exchangPWImageView];
    [exchangPWImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *exchangePWNoteLabel = [UILabel new];
    exchangePWNoteLabel.font = [UIFont systemFontOfSize:15];
    exchangePWNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    exchangePWNoteLabel.textAlignment = NSTextAlignmentLeft;
    exchangePWNoteLabel.text = @"修改交易密码";
    [changeExchangePWView addSubview:exchangePWNoteLabel];
    [exchangePWNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exchangPWImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *exchangePWEnterImageView = [UIImageView new];
    exchangePWEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    exchangePWEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [changeExchangePWView addSubview:exchangePWEnterImageView];
    [exchangePWEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeExchangePWView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView = [UIView new];
    horizonalSeparetedView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView];
    [horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeExchangePWView.bottom).offset(5);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    UIView *changeSignInPWView = [UIView new];
    UITapGestureRecognizer *changeSignInPWGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSignInPasswordAction:)];
    changeSignInPWGesture.delegate = self;
    changeSignInPWGesture.numberOfTapsRequired = 1;
    changeSignInPWGesture.numberOfTouchesRequired = 1;
    [changeSignInPWView addGestureRecognizer:changeSignInPWGesture];
    changeSignInPWView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:changeSignInPWView];
    [changeSignInPWView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *changeSignInImageView = [UIImageView new];
    changeSignInImageView.image = [UIImage imageNamed:@"setting_changeSignInPassword"];
    changeSignInImageView.contentMode = UIViewContentModeScaleAspectFill;
    [changeSignInPWView addSubview:changeSignInImageView];
    [changeSignInImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *changeSignInLabel = [UILabel new];
    changeSignInLabel.font = [UIFont systemFontOfSize:15];
    changeSignInLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    changeSignInLabel.textAlignment = NSTextAlignmentLeft;
    changeSignInLabel.text = @"修改登录密码";
    [changeSignInPWView addSubview:changeSignInLabel];
    [changeSignInLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(exchangPWImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *changeSignInEnterImageView = [UIImageView new];
    changeSignInEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    changeSignInEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [changeSignInPWView addSubview:changeSignInEnterImageView];
    [changeSignInEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeExchangePWView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeSignInPWView.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@5);
    }];
    
    UIView *updateApplicationView = [UIView new];
    updateApplicationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:updateApplicationView];
    [updateApplicationView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *updateApplicationImageView = [UIImageView new];
    updateApplicationImageView.image = [UIImage imageNamed:@"setting_updateApplication"];
    updateApplicationImageView.contentMode = UIViewContentModeScaleAspectFill;
    [updateApplicationView addSubview:updateApplicationImageView];
    [updateApplicationImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(updateApplicationView.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *updateApplicationLabel = [UILabel new];
    updateApplicationLabel.font = [UIFont systemFontOfSize:15];
    updateApplicationLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    updateApplicationLabel.textAlignment = NSTextAlignmentLeft;
    updateApplicationLabel.text = @"应用更新";
    [updateApplicationView addSubview:updateApplicationLabel];
    [updateApplicationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(updateApplicationImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *updateApplicationEnterImageView = [UIImageView new];
    updateApplicationEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    updateApplicationEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [updateApplicationView addSubview:updateApplicationEnterImageView];
    [updateApplicationEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(updateApplicationView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(updateApplicationView.bottom).offset(5);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    UIView *clearCachedPicturesView = [UIView new];
    clearCachedPicturesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clearCachedPicturesView];
    [clearCachedPicturesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *clearCachedPicturesImageView = [UIImageView new];
    clearCachedPicturesImageView.image = [UIImage imageNamed:@"setting_clearCachedPictures"];
    clearCachedPicturesImageView.contentMode = UIViewContentModeScaleAspectFill;
    [clearCachedPicturesView addSubview:clearCachedPicturesImageView];
    [clearCachedPicturesImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *clearCachedPicturesLabel = [UILabel new];
    clearCachedPicturesLabel.font = [UIFont systemFontOfSize:15];
    clearCachedPicturesLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    clearCachedPicturesLabel.textAlignment = NSTextAlignmentLeft;
    clearCachedPicturesLabel.text = @"清除缓存图片";
    [clearCachedPicturesView addSubview:clearCachedPicturesLabel];
    [clearCachedPicturesLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearCachedPicturesImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *clearCachedPicturesEnterImageView = [UIImageView new];
    clearCachedPicturesEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    clearCachedPicturesEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [clearCachedPicturesView addSubview:clearCachedPicturesEnterImageView];
    [clearCachedPicturesEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(clearCachedPicturesView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clearCachedPicturesView.bottom).offset(5);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    UIView *clearCachedFilesView = [UIView new];
    clearCachedFilesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clearCachedFilesView];
    [clearCachedFilesView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *clearCachedFilesImageView = [UIImageView new];
    clearCachedFilesImageView.image = [UIImage imageNamed:@"setting_clearCachedFiles"];
    clearCachedFilesImageView.contentMode = UIViewContentModeScaleAspectFill;
    [clearCachedFilesView addSubview:clearCachedFilesImageView];
    [clearCachedFilesImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *clearCachedFilesLabel = [UILabel new];
    clearCachedFilesLabel.font = [UIFont systemFontOfSize:15];
    clearCachedFilesLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    clearCachedFilesLabel.textAlignment = NSTextAlignmentLeft;
    clearCachedFilesLabel.text = @"清除缓存文件";
    [clearCachedFilesView addSubview:clearCachedFilesLabel];
    [clearCachedFilesLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearCachedFilesImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *clearCachedFilesEnterImageView = [UIImageView new];
    clearCachedFilesEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    clearCachedFilesEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [clearCachedFilesView addSubview:clearCachedFilesEnterImageView];
    [clearCachedFilesEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(clearCachedFilesView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView3 = [UIView new];
    horizonalSeparetedView3.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView3];
    [horizonalSeparetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clearCachedFilesView.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@5);
    }];
    
    UIView *feedBackView = [UIView new];
    UITapGestureRecognizer *feedBackTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedBackAction:)];
    feedBackTapGesture.delegate = self;
    feedBackTapGesture.numberOfTouchesRequired = 1;
    feedBackTapGesture.numberOfTapsRequired = 1;
    [feedBackView addGestureRecognizer:feedBackTapGesture];
    feedBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:feedBackView];
    [feedBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *feedBackImageView = [UIImageView new];
    feedBackImageView.image = [UIImage imageNamed:@"setting_feedBack"];
    feedBackImageView.contentMode = UIViewContentModeScaleAspectFill;
    [feedBackView addSubview:feedBackImageView];
    [feedBackImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(feedBackView.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *feedBackLabel = [UILabel new];
    feedBackLabel.font = [UIFont systemFontOfSize:15];
    feedBackLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    feedBackLabel.textAlignment = NSTextAlignmentLeft;
    feedBackLabel.text = @"留言反馈";
    [feedBackView addSubview:feedBackLabel];
    [feedBackLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(feedBackImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIImageView *feedBackEnterImageView = [UIImageView new];
    feedBackEnterImageView.image = [UIImage imageNamed:@"installTask_enter"];
    feedBackEnterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [feedBackView addSubview:feedBackEnterImageView];
    [feedBackEnterImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(feedBackView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@6);
        make.height.equalTo(@6);
    }];
    
    UIView *horizonalSeparetedView4 = [UIView new];
    horizonalSeparetedView4.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView4];
    [horizonalSeparetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedBackView.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@5);
    }];
    
    UIView *removeAccountView = [UIView new];
    UITapGestureRecognizer *removeAccountGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAccountAciont:)];
    removeAccountGesture.delegate = self;
    removeAccountGesture.numberOfTapsRequired = 1;
    removeAccountGesture.numberOfTouchesRequired = 1;
    [removeAccountView addGestureRecognizer:removeAccountGesture];
    removeAccountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:removeAccountView];
    [removeAccountView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView4.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *removeAccountImageView = [UIImageView new];
    removeAccountImageView.image = [UIImage imageNamed:@"setting_removeAccount"];
    removeAccountImageView.contentMode = UIViewContentModeScaleAspectFill;
    [removeAccountView addSubview:removeAccountImageView];
    [removeAccountImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(removeAccountView.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *removeAccountLabel = [UILabel new];
    removeAccountLabel.textColor = [UIColor colorFromHexString:@"#c82928" alpha:1.0];
    removeAccountLabel.font = [UIFont systemFontOfSize:15];
    removeAccountLabel.textAlignment = NSTextAlignmentLeft;
    removeAccountLabel.text = @"注销账号";
    [removeAccountView addSubview:removeAccountLabel];
    [removeAccountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(removeAccountImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UILabel *removeAccountNoteLabel = [UILabel new];
    removeAccountNoteLabel.textAlignment = NSTextAlignmentCenter;
    removeAccountNoteLabel.textColor = [UIColor colorFromHexString:@"#cacacd" alpha:1.0];
    removeAccountNoteLabel.text = @"请谨慎操作";
    [removeAccountView addSubview:removeAccountNoteLabel];
    [removeAccountNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(removeAccountView.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView5 = [UIView new];
    horizonalSeparetedView5.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView5];
    [horizonalSeparetedView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(removeAccountView.bottom).offset(5);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    UIView *signOutView = [UIView new];
    UITapGestureRecognizer *signOutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signOutAction:)];
    signOutGesture.delegate = self;
    signOutGesture.numberOfTapsRequired = 1;
    signOutGesture.numberOfTouchesRequired = 1;
    [signOutView addGestureRecognizer:signOutGesture];
    signOutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signOutView];
    [signOutView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView5.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *signOutImageView = [UIImageView new];
    signOutImageView.image = [UIImage imageNamed:@"icon_setting_signOut"];
    signOutImageView.contentMode = UIViewContentModeCenter;
    [signOutView addSubview:signOutImageView];
    [signOutImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(signOutView.left).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel *signOutLabel = [UILabel new];
    signOutLabel.textAlignment = NSTextAlignmentLeft;
    signOutLabel.textColor = [UIColor colorFromHexString:@"#757877" alpha:1.0];
    signOutLabel.text = @"退出";
    [signOutView addSubview:signOutLabel];
    [signOutLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(signOutImageView.right).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView6 = [UIView new];
    horizonalSeparetedView6.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:horizonalSeparetedView6];
    [horizonalSeparetedView6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(signOutView.bottom).offset(5);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@5);
    }];
    
    if (removeAccountNoteView == nil) {
        removeAccountNoteView = [[RemoveAccountView alloc] init];
        [removeAccountNoteView dismissRemoveAccountViewAction];
        [self.navigationController.view addSubview:removeAccountNoteView];
        [removeAccountNoteView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [removeAccountNoteView.removeAccountCancelButton addTarget:self action:@selector(cancelRemoveAccount) forControlEvents:UIControlEventTouchUpInside];
        [removeAccountNoteView.removeAccountConfirmButton addTarget:self action:@selector(confirmRemoveAccount) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

- (void)confirmRemoveAccount
{
    NSLog(@"进入身份验证...");
    [removeAccountNoteView dismissRemoveAccountViewAction];
    [self performSegueWithIdentifier:@"settingToRemoveAccountVC" sender:nil];
    
}

- (void)cancelRemoveAccount
{
    [removeAccountNoteView dismissRemoveAccountViewAction];
}

- (void)removeAccountAciont:(UITapGestureRecognizer *)sender
{
    NSLog(@"注销帐号提示...");
    [removeAccountNoteView showRemoveAccountView];
    
}

- (void)feedBackAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"留言反馈...");
    [self performSegueWithIdentifier:@"settingVCToFeedBackVC" sender:nil];
    
}

- (void)changeSignInPasswordAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"修改登录密码...");
    [self performSegueWithIdentifier:@"settingVCToChangePassword" sender:nil];
    
}

- (void)changeExchangePasswordAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"修改交易密码...");
    [self performSegueWithIdentifier:@"settingVCToChangePassword" sender:nil];
    
}

- (void)signOutAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"退出...");
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"signInTag"];
    
    [self settingViewToSignVC];
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(settingViewToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"设置";
    
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
- (void)settingViewToSignVC
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
