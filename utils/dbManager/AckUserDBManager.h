//
//  ACKDBManager.h
//  ACKStores
//
//  Created by 爱车客研发部 on 2016/10/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeHandleDB)(BOOL finish);
typedef void(^getResultFromDB)(NSMutableArray *result);

@interface AckUserDBManager : NSObject

+ (instancetype)sharedManager;
/**
 进入待安装任务列表界面的时候，通过此查询返回当前缓存在本地的待安装任务的列表数据
 */
- (void)getCachedDataComplete:(getResultFromDB)result;

/**
 获取需要上传的任务数据
 */
- (void)getNeedUploadTaskDataComplete:(getResultFromDB)finished;

/**
 数据库更新
 
 @param resultDictionary resultDictionary 网络请求返回的数据
 */
- (void)dBUpdateWithDictionary:(NSDictionary *)resultDictionary;

/**
 改变taskID所对应的任务的状态ID
 
 @param taskID taskID 任务ID
 @param status status 任务所对应的状态
 
 */
- (void)changeTaskStatusInDBWithTaskID:(NSString *)taskID status:(NSString *)status complete:(completeHandleDB)finish;

/**
 删除已经完成上传的在本地数据库中的任务数据
 
 @param taskID taskID 任务ID
 */
- (void)deleteTaskDataWithTaskID:(NSString *)taskID;

@end
