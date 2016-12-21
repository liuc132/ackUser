//
//  CarInformationModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInformationModel : NSObject<NSCoding>

/** 车辆id */
@property (copy, nonatomic) NSString              *iD;

/** 用户ID */
@property (copy, nonatomic) NSString              *ownerId;

/** 用户姓名 */
@property (copy, nonatomic) NSString              *name;

/** 车牌号 */
@property (copy, nonatomic) NSString              *plate;

/** 车辆品牌 */
@property (copy, nonatomic) NSString              *brand;

/** 车辆颜色代码 */
@property (copy, nonatomic) NSString              *colorCd;

/** 车辆颜色名称 */
@property (copy, nonatomic) NSString              *colorName;

/** 发布价格代码 */
@property (copy, nonatomic) NSString              *priceCd;

/** 发布价格名称 */
@property (copy, nonatomic) NSString              *priceName;

/** 发证日期 */
@property (copy, nonatomic) NSString              *issuetime;

/** 最近年检时间 */
@property (copy, nonatomic) NSString              *latetime;

/** 状态（0:待审核 1:审核通过 2:审核不通过3:待完善 9:已注销） */
@property (copy, nonatomic) NSString              *status;

/** 车系 */
@property (copy, nonatomic) NSString              *series;

/** 车型代码 */
@property (copy, nonatomic) NSString              *typeCd;

/** 车型名称 */
@property (copy, nonatomic) NSString              *typeName;

/** 是否报备（1表示正常 2表示 报备） */
@property (copy, nonatomic) NSString              *isreport;

/** 行驶证照片 */
@property (copy, nonatomic) NSString              *travelpic;

/** 车辆正前照 */
@property (copy, nonatomic) NSString              *positivepic;

/** 车辆前侧45度照片 */
@property (copy, nonatomic) NSString              *ventripic;

/** 车辆品牌图片 */
@property (copy, nonatomic) NSString              *brandImgUrl;

/** 创建时间 */
@property (copy, nonatomic) NSString              *creTime;

/** 最后编辑时间state=1,2时有值 */
@property (copy, nonatomic) NSString              *lastUpdateTime;



@end
