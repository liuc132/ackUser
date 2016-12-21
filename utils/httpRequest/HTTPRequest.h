//
//  HTTPRequest.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^completeRequest)(id finish);
typedef void(^completeError)(NSError *reqError);

@interface HTTPRequest : NSObject

+ (instancetype)sharedManager;

/**
 设置会话headerField
 */
- (void)setSessionHeaderField;

/**
 清除认证headerField
 */
- (void)clearSessionHeaderFieldAuthorization;



/**
 获取我的所有车辆的信息
 
 @param finish finish 请求成功之后的返回结果
 @param reqError reqError 请求失败之后的返回结果
 */
- (void)getAllCarsListsSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 添加车辆信息到服务器
 
 @param parameter parameter 上传的车辆信息参数
 @param finish finish 请求成功之后的返回
 @param reqError reqError 请求失败返回结果
 */
- (void)upLoadNewCarInformationWithParemeter:(NSDictionary *)parameter complete:(completeRequest)finish error:(completeError)reqError;

/**
 删除车辆信息
 
 @param carId carId 删除参数
 @param finish finish 删除成功的返回块
 @param reqError reqError 服务器请求失败的返回块
 */
- (void)deleteCarInformationWithParameter:(NSString *)carId complete:(completeRequest)finish failure:(completeError)reqError;

/**
 上传图片并将相应的返回值通过块的方式返回
 
 @param uploadImage uploadImage 需要上传的图片
 @param index index 图片索引，0:行驶证  1:车身照片
 @param finish finish 请求成功之后的返回值
 @param reqError reqError 请求失败之后的返回块
 */
- (void)uploadImageToServerWithImage:(UIImage *)uploadImage andIndex:(NSInteger)index complete:(completeRequest)finish error:(completeError)reqError;

/**
 登录接口
 
 @param parameters parameters 登录参数
 @param finish finish 登录成功之后的返回
 @param reqError reqError 请求服务器失败的返回结果
 */
- (void)userSignInWithParameter:(NSDictionary *)parameters  complete:(completeRequest)finish error:(completeError)reqError;

/**
 第三方登录
 
 @param parameter parameter type:(第三方登陆 类型：{1：微信，2：QQ，3：微博})  code:openID
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)thirdPartLogInWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 修改头像
 
 @param avatarURL avatarURL 上传的头像的地址
 @param finish finish 请求成功之后的返回结果
 @param reqError reqError 请求失败之后的返回结果
 */
- (void)changeAvatarWithAvatarURL:(NSString *)avatarURL complete:(completeRequest)finish error:(completeError)reqError;

/**
 获取个人中心的数据
 
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)getPersonalCenterInformationComplete:(completeRequest)finish failure:(completeError)reqError;

/**
 个人资料初始化
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)UserDetailInitialDataRequestSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 个人资料完善，获取基础数据，无需参数
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getUserDetailDictionarySuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 个人资料完善，获取地区数据，无需参数
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getAreasSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 根据行业ID获取该行业中的工作角色
 
 @param parameter parameter 获取验证码参数 industryCdId
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getJobRoleWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 个人资料更换验证旧手机号
 
 @param parameter parameter :phone password
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)checkOldPhoneNumWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 保存新的手机号，替换旧的手机号
 
 @param parameter parameter valiCode
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)exchangePhoneNumberToNewPhoneWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 获取验证码
 
 @param parameter parameter 获取验证码参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getCheckCodeWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 短信验证码验证接口
 
 @param parameter parameter 验证短信参数
 @param finish finish 请求成功的参数
 @param reqError reqError 请求失败的参数
 */
- (void)messageValidateWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 检查当前用户是否存在
 
 @param parameter parameter 查询的参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)userExistedWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 注册时的设置密码
 
 @param parameters parameters 注册时的参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)registerSetPasswordWithParameter:(NSDictionary *)parameters success:(completeRequest)finish failure:(completeError)reqError;

/**
 完善用户个人资料.手机号不能在改接口中变动，单独修改。同时原型上标星号的字段必须要传
 
 @param parameter parameter 待保存的参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)saveUserDetailInformationWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 修改资料.需要判断居住区域与工作区域是否可以修改，传参数可以都为空
 
 @param parameter parameter body
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)changeUserDetailWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 获取我的任务列表数据
 
 @param parameters parameters status=?&pageSize=?
 @param finish finish 访问成功之后的返回块
 @param reqError reqError 访问失败的返回块
 */
- (void)getMyTasksWithURLWithParameter:(NSDictionary *)parameters Success:(completeRequest)finish failure:(completeError)reqError;

/**
 申请终止任务
 
 @param parameter parameter 终止任务参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)requestStopTaskWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 首页任务领取，获取广告任务列表的广告任务
 
 @param parameter parameter “pagesize pageNo”这两个参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)getHomeAdvTaskListsWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 找回密码
 
 @param parameter parameter 找回密码参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)findPasswordWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 爱车币账户
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getAckCoinAccountSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 获取油卡列表，无需参数,油卡卡状态(0 未绑定 1 未激活 2已激活 3已废弃 4挂失中)
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getOilCardListsSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 油卡激活
 
 @param parameter parameter 激活油卡参数 cardid:油卡ID   cardnumber:油卡卡号
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)activeOilCardWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 拉取密保问题
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getSecurityQuestionSuccess:(completeRequest)finish failure:(completeError)reqError;

/**
 油卡挂失
 
 @param parameter parameter cardid 传油卡ID
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)reportCardLossWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 设置密保问题
 
 @param parameter parameter 密保问题参数 密码，问题，答案 json 放在body里边
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)setSecurityQuetionWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;

/**
 油卡充值
 
 @param parameter parameter money充值金额数 tradpwd交易密码
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)chargeOilCardWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError;






@end
