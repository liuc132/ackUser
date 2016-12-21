//
//  MessegeVerifyViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessegeVerifyViewController : UIViewController

@property (copy, nonatomic) NSString        *registerPhoneNumber;
@property (copy, nonatomic) NSString        *password;
@property (copy, nonatomic) NSString        *changedPhoneNumber;

/**
 短信类型{1：注册，2：登录，3：找回密码，4:修改手机，5：注销车辆}
 */
@property (copy, nonatomic) NSString        *findPasswordEnable;

@end
