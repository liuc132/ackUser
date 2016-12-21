//
//  PersonalCenterMainModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/7.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenterMainModel : NSObject<NSCoding>

/** id */
@property (strong, nonatomic) NSString                      *userId;

/** 绑定的微信ID */
@property (strong, nonatomic) NSString                      *wechatId;

/** 绑定的QQID */
@property (strong, nonatomic) NSString                      *qqId;

/** 绑定的微博ID */
@property (strong, nonatomic) NSString                      *microblogId;

/** 用户昵称 */
@property (strong, nonatomic) NSString                      *nickname;

/** 性别（0未知, 1男   2女） */
@property (strong, nonatomic) NSString                      *sex;

/** 联系电话 */
@property (strong, nonatomic) NSString                      *tel;

/** 身份证号 */
@property (strong, nonatomic) NSString                      *idno;

/** 出生日期 */
@property (strong, nonatomic) NSString                      *birthDate;

/** 婚姻状态（0 未婚  1 已婚  3 保密） */
@property (strong, nonatomic) NSString                      *marigStatus;

/** 归属省 */
@property (strong, nonatomic) NSString                      *province;

/** 注册城市代码 */
@property (strong, nonatomic) NSString                      *regCity;

/** 工作区域代码 */
@property (strong, nonatomic) NSString                      *workarea;

/** 居住区域代码 */
@property (strong, nonatomic) NSString                      *resiArea;

/** 通信地址 */
@property (strong, nonatomic) NSString                      *contactAddr;

/** 用户邀请码 */
@property (strong, nonatomic) NSString                      *invtCode;

/** 用户被邀请码 */
@property (strong, nonatomic) NSString                      *invtCodeRel;

/** 行业类别代码 */
@property (strong, nonatomic) NSString                      *industryCd;

/** 职业角色代码 */
@property (strong, nonatomic) NSString                      *occpCd;

/** 月收入代码 */
@property (strong, nonatomic) NSString                      *incomeCd;

/** 兴趣爱好代码（可多选，多值存储爱好代码，爱好代码由数据字典定义） */
@property (strong, nonatomic) NSString                      *hobbyCd;

/** 用户头像（默认爱车贴卡通头像） */
@property (strong, nonatomic) NSString                      *headImgUrl;

/** 当前剩余爱车币 */
@property (strong, nonatomic) NSString                      *score;

/** 当前剩余现金 */
@property (strong, nonatomic) NSString                      *cash;

/** 信用等级 */
@property (strong, nonatomic) NSString                      *creditLevel;

/** 当前信用积分 */
@property (strong, nonatomic) NSString                      *creditScore;

/** 集团名称 */
@property (strong, nonatomic) NSString                      *carClubsVlue;

/** 是否可以修改工作区域 */
@property (assign, nonatomic) BOOL                          isUpdateResiArea;

/** 是否可以修改居住区域 */
@property (assign, nonatomic) BOOL                          isUpdateWorkarea;



@end
