//
//  SecurityQuestionAnswerModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityQuestionAnswerModel : NSObject<NSCoding>

/** id */
@property (copy, nonatomic) NSString                *questionId;

/** 用户ID */
@property (copy, nonatomic) NSString                *ownerId;

/** 密保问题序号（1 问题1、 2 问题2、3 问题3，按用户ID的问题排序） */
@property (copy, nonatomic) NSString                *sn;

/** 密保问题代码 */
@property (copy, nonatomic) NSString                *questionCd;

/** 密保答案 */
@property (copy, nonatomic) NSString                *answer;

/** 创建时间 */
@property (copy, nonatomic) NSString                *creTime;

/** 最后更新时间 */
@property (copy, nonatomic) NSString                *lastUpdateTime;

@end
