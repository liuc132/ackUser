//
//  SetPasswordViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordViewController : UIViewController

@property (copy, nonatomic) NSString        *registerCheckCode;
@property (copy, nonatomic) NSString        *registerPhoneNum;

/**
 1:设置密码  2:注册  3:验证码登录
 */
@property (copy, nonatomic) NSString        *setPWFindPasswordEnable;

@end
