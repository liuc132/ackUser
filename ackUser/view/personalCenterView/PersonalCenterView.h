//
//  PersonalCenterView.h
//  ackUser
//
//  Created by LiuC on 16/11/27.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterView : UIView

@property (strong, nonatomic) UIImageView   *headBackImageView;
@property (strong, nonatomic) UIButton      *personalInformationButton;
@property (strong, nonatomic) UILabel       *userNickNameLabel;
@property (strong, nonatomic) UIView        *userLevelView;
@property (strong, nonatomic) UIImageView   *userLevelImageView0;
@property (strong, nonatomic) UIImageView   *userLevelImageView1;
@property (strong, nonatomic) UIImageView   *userLevelImageView2;
@property (strong, nonatomic) UIImageView   *userLevelImageView3;
@property (strong, nonatomic) UIImageView   *userLevelImageView4;
@property (strong, nonatomic) UIView        *ackCoinTotalView;
@property (strong, nonatomic) UIImageView   *ackCoinTotalImageView;
@property (strong, nonatomic) UILabel       *ackCoinTotalLabel;
@property (strong, nonatomic) UIView        *userCreditscoreView;
@property (strong, nonatomic) UIImageView   *userCreditscoreImageView;
@property (strong, nonatomic) UIButton      *personalCenterMyTaskButton;
@property (strong, nonatomic) UILabel       *userCreditscoreLabel;
@property (strong, nonatomic) UIButton      *registerRightNowButton;
@property (strong, nonatomic) UILabel       *finishInformationRewardLabel;
@property (strong, nonatomic) UIButton      *personalCenterMyCarButton;
@property (strong, nonatomic) UIButton      *personalCenterPetroleumChargeButton;
@property (strong, nonatomic) UIButton      *personalCenterCoinAccountButton;
@property (strong, nonatomic) UIButton      *personalCenterInviteButton;
@property (strong, nonatomic) UIButton      *personalCenterHelpButton;
@property (strong, nonatomic) UIButton      *personalCenterSettingButton;
@property (strong, nonatomic) UIButton      *personalCenterHotLineButton;



/**
 未登录时的登录界面的布局更新
 */
- (void)signOutLayoutUpdate;

/**
 登录之后的登录界面的布局更新
 */
- (void)signInLayoutUpdate;

/**
 dismiss the PersonalCenterView
 */
- (void)dismissPersonalCenterViewAction;

/**
 show the PersonalCenterView
 */
- (void)showPersonalCenterView;


@end
