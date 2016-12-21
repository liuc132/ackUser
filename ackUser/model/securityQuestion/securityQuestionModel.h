//
//  SecurityQuestionModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityQuestionModel : NSObject<NSCoding>

/** id */
@property (copy, nonatomic) NSString                *questionId;

/** 父id */
@property (copy, nonatomic) NSString                *parentId;

/** 值 */
@property (copy, nonatomic) NSString                *key;

/** 键 */
@property (copy, nonatomic) NSString                *value;

/** 类型 */
@property (copy, nonatomic) NSString                *type;

/** 状态 */
@property (copy, nonatomic) NSString                *status;

/** 排序号 */
@property (copy, nonatomic) NSString                *sortNo;

/** 描述 */
@property (copy, nonatomic) NSString                *questionDescription;

/** 创建时间 */
@property (copy, nonatomic) NSString                *createTime;

/** 下级字典 */
@property (copy, nonatomic) NSDictionary            *subList;


@end
