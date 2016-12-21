//
//  TaskListsModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListsModel : NSObject<NSCoding>

/** 我的任务id */
@property (copy, nonatomic) NSString          *taskId;
/** 车牌号 */
@property (copy, nonatomic) NSString          *plate;
/** 我的任务状态 (1, "待安装" 2, "安装待审核" 3, "待自检" 4, "自检待审核" 5, "发布中" 6, "安装关闭" 7, "已结束" 8, "逾期关闭" 9, "任务已终止" 10, "终止申请中" 11, "已取消" 12, "申述待审核" 13, "逾期安装")*/
@property (copy, nonatomic) NSString          *taskStatus;
/** 我的任务状态 */
@property (copy, nonatomic) NSString          *taskStatusValue;
/** 我的任务状态 */
@property (copy, nonatomic) NSString          *storeStatus;
/** 我的任务状态 */
@property (copy, nonatomic) NSString          *storeValue;
/** 我的任务结束时间 */
@property (copy, nonatomic) NSString          *taskEndTime ;
/** 任务名称 */
@property (copy, nonatomic) NSString          *advName;
/** 任务描述 */
@property (copy, nonatomic) NSString          *advDesc;
/** 任务金额 */
@property (copy, nonatomic) NSString          *advPrice;
/** 安装时间 */
@property (copy, nonatomic) NSString          *installTime;
/** 安装时段 */
@property (copy, nonatomic) NSString          *installTimes;
/** 自检时间 */
@property (copy, nonatomic) NSString          *checkTime;
/** 省份 */
@property (copy, nonatomic) NSString          *province;
/** 城市 */
@property (copy, nonatomic) NSString          *city;
/** 区域 */
@property (copy, nonatomic) NSString          *area;
/** 详细地址 */
@property (copy, nonatomic) NSString          *address;
/** 经度 */
@property (copy, nonatomic) NSString          *longitude;
/** 纬度 */
@property (copy, nonatomic) NSString          *latitude;
/** 纬度 */
@property (copy, nonatomic) NSString          *advImg;



@end
