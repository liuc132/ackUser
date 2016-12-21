//
//  UserDetailView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailView : UIView

@property (strong, nonatomic) UIView                        *avatarView;
@property (strong, nonatomic) UIImageView                   *avatarImageView;
@property (strong, nonatomic) UILabel                       *registeredCityLabel;
@property (strong, nonatomic) UITextField                   *registeredCityTextField;
@property (strong, nonatomic) UILabel                       *phoneNumberLabel;
@property (strong, nonatomic) UITextField                   *phoneNumInputTextField;
@property (strong, nonatomic) UILabel                       *registeredCodeLabel;
@property (strong, nonatomic) UITextField                   *registeredCodeTextField;
@property (strong, nonatomic) UITextField                   *nickNameTextField;
@property (strong, nonatomic) UILabel                       *sexLabel;
@property (strong, nonatomic) UITextField                   *sexTextField;
@property (strong, nonatomic) UILabel                       *birthdayLabel;
@property (strong, nonatomic) UITextField                   *birthdayTextField;
@property (strong, nonatomic) UILabel                       *liveCityLabel;
@property (strong, nonatomic) UITextField                   *liveCityTextField;
@property (strong, nonatomic) UILabel                       *workCityLabel;
@property (strong, nonatomic) UITextField                   *workCityTextField;
@property (strong, nonatomic) UILabel                       *detailAddressLabel;
@property (strong, nonatomic) UITextField                   *detailAddressTextField;
@property (strong, nonatomic) UITextField                   *marriageStatusTextField;
@property (strong, nonatomic) UITextField                   *industryTextField;
@property (strong, nonatomic) UITextField                   *jobRoleTextField;
@property (strong, nonatomic) UITextField                   *monthlyIncomeTextField;
@property (strong, nonatomic) UITextField                   *interestTextField;
@property (strong, nonatomic) UILabel                       *detailWeChatBindLable;
@property (strong, nonatomic) UIButton                      *detailWeChatBindButton;
@property (strong, nonatomic) UILabel                       *detailQQBindLable;
@property (strong, nonatomic) UIButton                      *detailQQBindButton;
@property (strong, nonatomic) UILabel                       *detailWeboBindLable;
@property (strong, nonatomic) UIButton                      *detailWeboBindButton;
@property (strong, nonatomic) UIButton                      *detailSaveButton;


@end
