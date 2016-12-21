//
//  SetExchangePWView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetExchangePWView : UIView

@property (strong, nonatomic) UITextField               *passwordTextField;
@property (strong, nonatomic) UITextField               *confirmPasswordTextField;
@property (strong, nonatomic) UIView                    *firstSecretQuestionContentView;
@property (strong, nonatomic) UILabel                   *firstSecretQuestionLabel;
@property (strong, nonatomic) UITextField               *firstSecretQuestionTextField;
@property (strong, nonatomic) UIView                    *secondSecretQuestionContentView;
@property (strong, nonatomic) UILabel                   *secondSecretQuestionLabel;
@property (strong, nonatomic) UITextField               *secondSecretQuestionTextField;
@property (strong, nonatomic) UIButton                  *saveExchangePasswordButton;

@end
