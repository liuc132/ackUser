//
//  MyTaskDetailModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/6.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTaskDetailModel : NSObject<NSCoding>

/** 我的任务id */
@property (assign, nonatomic) NSInteger         taskId;
/** 车牌号 */
@property (copy, nonatomic) NSString            *plate;
/** 我的任务状态 */
@property (assign, nonatomic) NSInteger         taskStatus;
/** 我的任务状态值 */
@property (copy, nonatomic) NSString            *taskStatusValue;
/** 我的安装状态码*/
@property (copy, nonatomic) NSString            *storeStatus;
/** 我的安装状态 */
@property (assign, nonatomic) NSInteger         storeValue;
/** 我的任务结束时间 */
@property (copy, nonatomic) NSString            *taskEndTime ;
/** 任务名称 */
@property (copy, nonatomic) NSString            *advName;
/** 任务描述 */
@property (copy, nonatomic) NSString            *advDesc;
/** 任务周期 */
@property (assign, nonatomic) NSInteger         days ;
/** 已发布天数 */
@property (assign, nonatomic) NSInteger         publishDays;
/** 安装时间 */
@property (copy, nonatomic) NSString            *installTime;
/** 安装时段 */
@property (copy, nonatomic) NSString            *installTimes;
/** 商家热线 */
@property (copy, nonatomic) NSString            *adverTel;
/** 已赚取的报酬 */
@property (assign, nonatomic) NSInteger         earnMoney;
/** 需自检总次数 */
@property (assign, nonatomic) NSInteger         checkCount;
/** 已自检次数 */
@property (assign, nonatomic) NSInteger         checkedCount;
/** 自检时间 */
@property (copy, nonatomic) NSString            *checkTime;
/** 门店省份 */
@property (copy, nonatomic) NSString            *province;
/** 门店城市 */
@property (copy, nonatomic) NSString            *city;
/** 门店区域 */
@property (copy, nonatomic) NSString            *area;
/** 门店详细地址 */
@property (copy, nonatomic) NSString            *address;
/** 门店经度 */
@property (assign, nonatomic) double            longitude;
/** 门店纬度 */
@property (assign, nonatomic) double            latitude;


@end
