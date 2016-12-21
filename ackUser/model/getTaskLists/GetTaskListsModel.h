//
//  GetTaskListsModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTaskListsModel : NSObject<NSCoding>

/** 广告ID */
@property (copy, nonatomic) NSString                  *adId;
/** 广告名称  */
@property (copy, nonatomic) NSString                  *advname;
/** 广告价格 */
@property (copy, nonatomic) NSString                  *price;
/** 剩余名额 */
@property (copy, nonatomic) NSString                  *recruitcarssurplus;
/** 设计稿图片 */
@property (copy, nonatomic) NSString                  *img1url;
/** 离招募结束时间 */
@property (copy, nonatomic) NSString                  *srecruitTimeToLong;
/**
 状态
 (1, "待安装" 2, "安装待审核" 3, "待自检" 4, "自检待审核" 5, "发布中" 6, "安装关闭" 7, "已结束" 8, "逾期关闭" 9, "任务已终止" 10, "终止申请中" 11, "已取消" 12, "申述待审核" 13, "逾期安装")
 */
@property (copy, nonatomic) NSString                  *status;
/** 周期*/
@property (copy, nonatomic) NSString                  *cycle;


@end
