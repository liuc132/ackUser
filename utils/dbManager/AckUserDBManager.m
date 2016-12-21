//
//  ACKDBManager.m
//  ACKStores
//
//  Created by 爱车客研发部 on 2016/10/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AckUserDBManager.h"
#import "ackUserPCH.pch"

@interface AckUserDBManager ()
{
    FMDatabaseQueue *queue;
}

@property (strong, nonatomic) FMDatabase    *ackDBManager;

@end

@implementation AckUserDBManager

+ (instancetype)sharedManager
{
    static AckUserDBManager *dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[AckUserDBManager alloc] init];
        [dbManager dBInitSetting];
        
    });
    
    return dbManager;
}

#pragma mark - 配置数据库单聊
+(FMDatabaseQueue *)getSharedDatabaseQueue
{
    static FMDatabaseQueue *my_FMDatabaseQueue=nil;
    
    if (!my_FMDatabaseQueue) {
        NSString *dbPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"ackUserDBPath"];
        my_FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return my_FMDatabaseQueue;
    }


/**
 数据库的初始化设置
 */
- (void)dBInitSetting
{
    NSString *dbPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"ackUserDBPath"];
    _ackDBManager  = [FMDatabase databaseWithPath:dbPath];
    queue = [AckUserDBManager getSharedDatabaseQueue];
}

/**
 进入待安装任务列表界面的时候，通过此查询返回当前缓存在本地的待安装任务的列表数据
 */
- (void)getCachedDataComplete:(getResultFromDB)result
{
    NSMutableArray *cachedTaskDataArray = [[NSMutableArray alloc] init];
    
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs;
        if ([db open]) {
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"signInID"];
            rs = [db executeQuery:@"select *from tbl_userAccountInfo where userID = ?",userID];
            while ([rs next]) {
//                NSLog(@"rs:%@",rs.resultDictionary);
                [cachedTaskDataArray addObject:rs.resultDictionary];
                
            }
            [rs close];
            [db close];
            result(cachedTaskDataArray);
        }
    }];
    
}

/**
 获取需要上传的任务数据
 */
- (void)getNeedUploadTaskDataComplete:(getResultFromDB)result
{
    NSMutableArray *needUploadTasksArray = [[NSMutableArray alloc]init];
    
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs;
        if ([db open]) {
            NSString *MDID = [[NSUserDefaults standardUserDefaults] objectForKey:@"mdID"];
            rs = [db executeQuery:@"select *from tbl_needInstallTask where  MDID = ?",MDID];
            while ([rs next]) {
//                NSLog(@"rs:%@",rs.resultDictionary);
                NSDictionary *curMDDBDictionary;// = [[NSMutableDictionary alloc] init];
                curMDDBDictionary = rs.resultDictionary;
                if ([curMDDBDictionary[@"needUpload"] isEqualToString:@"true"]) {
                    [needUploadTasksArray addObject:curMDDBDictionary];
                }
            }
            [rs close];
            [db close];
            result(needUploadTasksArray);
        }
    }];
    
}

/**
 数据库更新
 
 @param resultDictionary resultDictionary 网络请求返回的数据
 */
- (void)dBUpdateWithDictionary:(NSDictionary *)resultDictionary
{
    NSLog(@"res:%@",resultDictionary);
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *result;
            result = [db executeQuery:[NSString stringWithFormat:@"select userID from tbl_userAccountInfo where userID = '%@'",resultDictionary[@"userID"]]];
            if (![result next]) {
                //tbl_userAccountInfo(id integer primary key autoincrement, userID text, carClubsId text, wechatId text, qqId text, sinaWeboId text, userName text, nickname text, userTel text, regCity text, creditLevel text, creditScore text, invtCode text, headImgUrl text)
                [db executeUpdate:@"insert into tbl_userAccountInfo(userID, carClubsId, wechatId, qqId, sinaWeboId, userName, nickname, userTel, regCity, creditLevel, creditScore, invtCode, headImgUrl) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",resultDictionary[@"userID"],resultDictionary[@"carClubsId"],resultDictionary[@"wechatId"],resultDictionary[@"qqId"],resultDictionary[@"microblogId"],resultDictionary[@"name"],resultDictionary[@"nickname"],resultDictionary[@"tel"],resultDictionary[@"regCity"],resultDictionary[@"creditLevel"],resultDictionary[@"creditScore"],resultDictionary[@"invtCode"],resultDictionary[@"headImgUrl"]];
            }
            
            [db close];
        }
    }];
    
}


/**
  改变taskID所对应的任务的状态ID

 @param taskID taskID 任务ID
 @param status status 任务所对应的状态
 
 */
- (void)changeTaskStatusInDBWithTaskID:(NSString *)taskID status:(NSString *)status complete:(completeHandleDB)finish
{
    __block BOOL success = NO;
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *result;
            //tbl_needInstallTask(ID text,Brand text,IMGURL text,MDN text,plate text,reservation text,taskName text,MDID text,needUpload text)
            result = [db executeQuery:[NSString stringWithFormat:@"select ID from tbl_needInstallTask where ID = '%@'",taskID]];
            if ([result next]) {
                NSLog(@"result:%@",result.resultDictionary);
                if ([db executeUpdate:[NSString stringWithFormat:@"update tbl_needInstallTask set needUpload = '%@' where ID = '%@'",status,taskID]]) {
                    NSLog(@"update successfully");
                    success = YES;
                }
            }
            [db close];
            finish(success);
            
        }
    }];
    
}


/**
 删除已经完成上传的在本地数据库中的任务数据

 @param taskID taskID 任务ID
 */
- (void)deleteTaskDataWithTaskID:(NSString *)taskID
{
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            FMResultSet *result;
            //tbl_needInstallTask(ID text,Brand text,IMGURL text,MDN text,plate text,reservation text,taskName text,MDID text,needUpload text)
            result = [db executeQuery:[NSString stringWithFormat:@"select ID from tbl_needInstallTask where ID = '%@'",taskID]];
            if ([result next]) {
                //            NSLog(@"result:%@",result.resultDictionary);
                //DELETE FROM 表名称 WHERE 列名称 = 值
                if ([db executeUpdate:[NSString stringWithFormat:@"delete from tbl_needInstallTask where ID = '%@'",taskID]]) {
                    NSLog(@"delete successfully");
                }
                else
                {
                    NSLog(@"delete failed");
                }
            }
            
            [db close];
        }
    }];
    
}


@end
