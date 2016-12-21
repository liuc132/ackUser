//
//  PersonalCenterView.m
//  ackUser
//
//  Created by LiuC on 16/11/27.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "PersonalCenterView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

#define verticalSeparetedSpace      (SCREEN_WIDTH - 141)/4

@implementation PersonalCenterView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(SCREEN_HEIGHT));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    _headBackImageView = [UIImageView new];
    _headBackImageView.layer.masksToBounds = YES;
    _headBackImageView.image = [UIImage imageNamed:@"icon_personalCenter_backImage"];
    _headBackImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_headBackImageView];
    [_headBackImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(self.top);
        if (SCREEN_WIDTH > ISixW) {
            make.height.equalTo(@290);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.height.equalTo(@255);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.height.equalTo(@200);
            }
            else
            {
                make.height.equalTo(@240);
            }
            
        }
        
    }];
    
    _personalInformationButton = [UIButton new];
    _personalInformationButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _personalInformationButton.layer.masksToBounds = YES;
    _personalInformationButton.layer.cornerRadius = _personalInformationButton.frame.size.width;
    [_personalInformationButton setBackgroundImage:[UIImage imageNamed:@"signIn_Avatar"] forState:UIControlStateNormal];
    [_personalInformationButton setAdjustsImageWhenHighlighted:NO];
    [_personalInformationButton setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self addSubview:_personalInformationButton];
    [_personalInformationButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(60);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    _userNickNameLabel = [UILabel new];
    [_userNickNameLabel setFont:[UIFont systemFontOfSize:13]];
    _userNickNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNickNameLabel.text = @"小灰灰";
    _userNickNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_userNickNameLabel];
    [_userNickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_personalInformationButton.bottom).offset(5);
        make.width.equalTo(@140);
        make.height.equalTo(@20);
    }];
    
    _userLevelView = [UIView new];
    [self addSubview:_userLevelView];
    [_userLevelView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_userNickNameLabel.bottom).offset(2);
        make.width.equalTo(@80);
        make.height.equalTo(@10);
    }];
    
    _userLevelImageView0 = [UIImageView new];
    _userLevelImageView0.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];
    _userLevelImageView0.contentMode = UIViewContentModeCenter;
    [_userLevelView addSubview:_userLevelImageView0];
    [_userLevelImageView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLevelView.left).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _userLevelImageView1 = [UIImageView new];
    _userLevelImageView1.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];//到时候设置条件进行判断?:
    _userLevelImageView1.contentMode = UIViewContentModeCenter;
    [_userLevelView addSubview:_userLevelImageView1];
    [_userLevelImageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLevelImageView0.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _userLevelImageView2 = [UIImageView new];
    _userLevelImageView2.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];
    _userLevelImageView2.contentMode = UIViewContentModeCenter;
    [_userLevelView addSubview:_userLevelImageView2];
    [_userLevelImageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLevelImageView1.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _userLevelImageView3 = [UIImageView new];
    _userLevelImageView3.image = [UIImage imageNamed:@"personalCenter_negativelevel"];
    _userLevelImageView3.contentMode = UIViewContentModeCenter;
    [_userLevelView addSubview:_userLevelImageView3];
    [_userLevelImageView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLevelImageView2.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _userLevelImageView4 = [UIImageView new];
    _userLevelImageView4.image = [UIImage imageNamed:@"personalCenter_negativelevel"];
    _userLevelImageView4.contentMode = UIViewContentModeCenter;
    [_userLevelView addSubview:_userLevelImageView4];
    [_userLevelImageView4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userLevelImageView3.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _finishInformationRewardLabel = [UILabel new];
    _finishInformationRewardLabel.layer.cornerRadius = 10.0;
    _finishInformationRewardLabel.font = [UIFont systemFontOfSize:13];
    _finishInformationRewardLabel.layer.masksToBounds = YES;
    _finishInformationRewardLabel.textAlignment = NSTextAlignmentCenter;
    _finishInformationRewardLabel.text = @"完善资料300积分到手";
    _finishInformationRewardLabel.backgroundColor = [UIColor colorFromHexString:@"#ffffff" alpha:1.0];
    _finishInformationRewardLabel.textColor = [UIColor colorFromHexString:@"#ff9f1d" alpha:1.0];
    [self addSubview:_finishInformationRewardLabel];
    [_finishInformationRewardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLevelView.bottom).offset(5);
        make.centerX.equalTo(@0);
        make.width.equalTo(@160);
        make.height.equalTo(@20);
    }];
    
    _ackCoinTotalView = [UIView new];
    [self addSubview:_ackCoinTotalView];
    [_ackCoinTotalView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_finishInformationRewardLabel.bottom).offset(10);
        make.centerX.equalTo(@(-SCREEN_WIDTH/4 + 20));
        make.width.equalTo(@(SCREEN_WIDTH/2 - 20));
        make.height.equalTo(@20);
    }];
    
    _ackCoinTotalImageView = [UIImageView new];
    _ackCoinTotalImageView.image = [UIImage imageNamed:@"personalCenter_ackCoin"];
    _ackCoinTotalImageView.contentMode = UIViewContentModeCenter;
    [_ackCoinTotalView addSubview:_ackCoinTotalImageView];
    [_ackCoinTotalImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ackCoinTotalView.left);
        make.centerY.equalTo(@0);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _ackCoinTotalLabel = [UILabel new];
    _ackCoinTotalLabel.font = [UIFont systemFontOfSize:12];
    _ackCoinTotalLabel.textColor = [UIColor whiteColor];
    _ackCoinTotalLabel.textAlignment = NSTextAlignmentLeft;
    _ackCoinTotalLabel.text = @"爱车币:15000";
    [_ackCoinTotalView addSubview:_ackCoinTotalLabel];
    [_ackCoinTotalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ackCoinTotalImageView.right).offset(5);
        make.right.equalTo(_ackCoinTotalView.right);
        make.centerY.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    
    _userCreditscoreView = [UIView new];
    [self addSubview:_userCreditscoreView];
    [_userCreditscoreView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_finishInformationRewardLabel.bottom).offset(10);
        make.centerX.equalTo(@(SCREEN_WIDTH/4 + 20));
        make.width.equalTo(@(SCREEN_WIDTH/2 - 20));
        make.height.equalTo(@20);
    }];
    
    _userCreditscoreImageView = [UIImageView new];
    _userCreditscoreImageView.image = [UIImage imageNamed:@"personalCenter_creditScore"];
    _userCreditscoreImageView.contentMode = UIViewContentModeCenter;
    [_userCreditscoreView addSubview:_userCreditscoreImageView];
    [_userCreditscoreImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userCreditscoreView.left);
        make.centerY.equalTo(@0);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _userCreditscoreLabel = [UILabel new];
    _userCreditscoreLabel.font = [UIFont systemFontOfSize:12];
    _userCreditscoreLabel.textColor = [UIColor whiteColor];
    _userCreditscoreLabel.textAlignment = NSTextAlignmentLeft;
    _userCreditscoreLabel.text = @"信用积分:20000";
    [_userCreditscoreView addSubview:_userCreditscoreLabel];
    [_userCreditscoreLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userCreditscoreImageView.right).offset(5);
        make.right.equalTo(_userCreditscoreView.right);
        make.centerY.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    _registerRightNowButton = [UIButton new];
    _registerRightNowButton.layer.cornerRadius = 13.0;
    _registerRightNowButton.layer.masksToBounds = YES;
    [_registerRightNowButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [_registerRightNowButton setTitleColor:[UIColor colorFromHexString:@"#ff9f1d" alpha:1.0] forState:UIControlStateNormal];
    _registerRightNowButton.backgroundColor = [UIColor whiteColor];
    _registerRightNowButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_registerRightNowButton];
    
    UIView *verticalSeparetedView0 = [UIView new];
    verticalSeparetedView0.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:verticalSeparetedView0];
    [verticalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_headBackImageView.bottom);
        make.bottom.equalTo(self.bottom).offset(-49);
        make.width.equalTo(@1);
    }];
    
    UIView *horizontalSeparetedView0 = [UIView new];
    horizontalSeparetedView0.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:horizontalSeparetedView0];
    [horizontalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(100);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(90);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(_headBackImageView.bottom).offset(70);
            }
            else
            {
                make.top.equalTo(_headBackImageView.bottom).offset(70);
            }
            
        }
//        make.top.equalTo(_headBackImageView.bottom).offset(70);
        make.centerX.equalTo(@0);
        make.height.equalTo(@1);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    UIView *horizontalSeparetedView1 = [UIView new];
    horizontalSeparetedView1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:horizontalSeparetedView1];
    [horizontalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(100);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(90);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(70);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(70);
            }
            
        }
        make.centerX.equalTo(@0);
        make.height.equalTo(@1);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    UIView *horizontalSeparetedView2 = [UIView new];
    horizontalSeparetedView2.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:horizontalSeparetedView2];
    [horizontalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(100);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(90);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(70);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(70);
            }
            
        }
        make.centerX.equalTo(@0);
        make.height.equalTo(@1);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    _personalCenterMyTaskButton = [UIButton new];
    [_personalCenterMyTaskButton setTitle:@"我的任务" forState:UIControlStateNormal];
    [_personalCenterMyTaskButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterMyTaskButton setImage:[UIImage imageNamed:@"personalCenter_myTask"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterMyTaskButton];
    [_personalCenterMyTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(_headBackImageView.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(_headBackImageView.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterMyTaskButton titleLength:4];
    
    _personalCenterMyCarButton = [UIButton new];
    [_personalCenterMyCarButton setTitle:@"我的车辆" forState:UIControlStateNormal];
    [_personalCenterMyCarButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterMyCarButton setImage:[UIImage imageNamed:@"personalCenter_myCar"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterMyCarButton];
    [_personalCenterMyCarButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(_headBackImageView.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(_headBackImageView.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(_headBackImageView.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterMyCarButton titleLength:4];
    
    _personalCenterPetroleumChargeButton = [UIButton new];
    [_personalCenterPetroleumChargeButton setTitle:@"油卡充值" forState:UIControlStateNormal];
    [_personalCenterPetroleumChargeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterPetroleumChargeButton setImage:[UIImage imageNamed:@"personalCenter_oilCard"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterPetroleumChargeButton];
    [_personalCenterPetroleumChargeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterPetroleumChargeButton titleLength:4];
    
    _personalCenterCoinAccountButton = [UIButton new];
    [_personalCenterCoinAccountButton setTitle:@"爱车币账户" forState:UIControlStateNormal];
    [_personalCenterCoinAccountButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterCoinAccountButton setImage:[UIImage imageNamed:@"personalCenter_ackCoinAccount"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterCoinAccountButton];
    [_personalCenterCoinAccountButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-verticalSeparetedSpace + 5);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView0.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterCoinAccountButton titleLength:5];
    
    _personalCenterInviteButton = [UIButton new];
    [_personalCenterInviteButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    [_personalCenterInviteButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterInviteButton setImage:[UIImage imageNamed:@"personalCenter_inviteFriend"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterInviteButton];
    [_personalCenterInviteButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterInviteButton titleLength:4];
    
    _personalCenterHelpButton = [UIButton new];
    [_personalCenterHelpButton setTitle:@"用户帮助" forState:UIControlStateNormal];
    [_personalCenterHelpButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterHelpButton setImage:[UIImage imageNamed:@"personalCenter_help"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterHelpButton];
    [_personalCenterHelpButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView1.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterHelpButton titleLength:4];
    
    _personalCenterSettingButton = [UIButton new];
    [_personalCenterSettingButton setTitle:@"设置" forState:UIControlStateNormal];
    [_personalCenterSettingButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterSettingButton setImage:[UIImage imageNamed:@"personalCenter_setting"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterSettingButton];
    [_personalCenterSettingButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView2.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView2.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView2.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView2.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterSettingButton titleLength:2];
    
    _personalCenterHotLineButton = [UIButton new];
    [_personalCenterHotLineButton setTitle:@"平台热线" forState:UIControlStateNormal];
    [_personalCenterHotLineButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_personalCenterHotLineButton setImage:[UIImage imageNamed:@"personalCenter_hotline"] forState:UIControlStateNormal];
    [self addSubview:_personalCenterHotLineButton];
    [_personalCenterHotLineButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-verticalSeparetedSpace);
        if (SCREEN_WIDTH > ISixW) {
            make.top.equalTo(horizontalSeparetedView2.bottom).offset(20);
        }
        else if (SCREEN_WIDTH > IFiveSW && SCREEN_WIDTH <= ISixW) {
            make.top.equalTo(horizontalSeparetedView2.bottom).offset(15);
        }
        else
        {
            if (SCREEN_HEIGHT < IFiveSH) {
                make.top.equalTo(horizontalSeparetedView2.bottom).offset(5);
            }
            else
            {
                make.top.equalTo(horizontalSeparetedView2.bottom).offset(5);
            }
            
        }
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_personalCenterHotLineButton titleLength:4];
    
    return self;
}


- (void)settingButtonImageAndTitlePositionWithButton:(UIButton *)sender titleLength:(NSInteger)length
{
    [sender setTitleColor:[UIColor colorFromHexString:@"#2d2d2d" alpha:1.0] forState:UIControlStateNormal];
    
    CGSize titleSize = CGSizeMake(40.0, 20.0);
    CGSize imageSize = sender.imageView.bounds.size;
    
    CGFloat horizontalMoveLength = 0.0;
    switch (length) {
        case 2:
            horizontalMoveLength = 25.0;
            break;
            
        case 4:
            horizontalMoveLength = 50.0;
            break;
            
        case 5:
            horizontalMoveLength = 60.0;
            break;
            
        default:
            break;
    }
    
    CGFloat totalHeight = (imageSize.height + titleSize.height);
    sender.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, -horizontalMoveLength);
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

/**
 未登录时的登录界面的布局更新
 */
- (void)signOutLayoutUpdate
{
    NSLog(@"未登录的布局更新...");
    _userLevelView.hidden = YES;
    _finishInformationRewardLabel.hidden = YES;
    _ackCoinTotalView.hidden = YES;
    _userCreditscoreView.hidden = YES;
    _registerRightNowButton.hidden = NO;
    [_personalInformationButton setTitle:@"登录" forState:UIControlStateNormal];
    _userNickNameLabel.text = @"爱车贴,帮您轻松养车 !";
    [_registerRightNowButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNickNameLabel.bottom).offset(5);
        make.centerX.equalTo(@0);
        make.width.equalTo(@90);
        make.height.equalTo(@26);
    }];
    
}

/**
 登录之后的登录界面的布局更新
 */
- (void)signInLayoutUpdate
{
    NSLog(@"登录之后的布局更新...");
    _userLevelView.hidden = NO;
    _finishInformationRewardLabel.hidden = NO;
    _ackCoinTotalView.hidden = NO;
    _userCreditscoreView.hidden = NO;
    _registerRightNowButton.hidden = YES;
    [_personalInformationButton setTitle:@"" forState:UIControlStateNormal];
    _userNickNameLabel.text = @"小灰灰";
    
    
    
}

/**
 dismiss the PersonalCenterView
 */
- (void)dismissPersonalCenterViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
    
}

/**
 show the PersonalCenterView
 */
- (void)showPersonalCenterView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}


@end
