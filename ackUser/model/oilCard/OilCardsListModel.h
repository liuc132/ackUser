//
//  OilCardsListModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OilCardsListModel : NSObject<NSCoding>

/** 油卡激活ID */
@property (copy, nonatomic) NSString                *oilCardId;
/** 背景图片路径 */
@property (copy, nonatomic) NSString                *backimgurl;
/** 绑定状态（0 未绑定 1 已绑定） */
@property (copy, nonatomic) NSString                *bindStatus;
/** 油卡号 */
@property (copy, nonatomic) NSString                *cardNumber;
/** 客户热线 */
@property (copy, nonatomic) NSString                *custel;
/** 热线名称 */
@property (copy, nonatomic) NSString                *hotlinename;
/** 公司商标图片地址 */
@property (copy, nonatomic) NSString                *imgurl;
/** 油卡是否设置交易密码 0：表示已设置交易密码 1：表示未设置交易密码 */
@property (copy, nonatomic) NSString                *issettradpwd;
/** 发卡单位名称 */
@property (copy, nonatomic) NSString                *name;
/** 用户ID */
@property (copy, nonatomic) NSString                *ownerId;
/** 卡状态（ 0 未激活 1激活 2 废弃 3已挂失 */
@property (copy, nonatomic) NSString                *status;
/** 热线电话 */
@property (copy, nonatomic) NSString                *tel;

@end
