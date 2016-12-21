//
//  SimpleInformationCheck.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/8.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleInformationCheck : NSObject

/**
 信息检测单列初始化
 
 @return return value 实例变量
 */
+ (instancetype)sharedManager;

/**
 校验手机号是否正确
 
 @param phoneNumber phoneNumber 需要校验的手机号
 
 @return return value 返回是否正确,YES->符合所设定的规则的号码;NO->不是符合规则的号码
 */
+ (BOOL)checkMobilePhoneNumberWithPhoneNumber:(NSString *)phoneNumber;


@end
