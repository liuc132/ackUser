//
//  UserDetailBaseDataModel.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailBaseDataModel : NSObject<NSCoding>

@property (copy, nonatomic) NSString        *dataID;
@property (copy, nonatomic) NSString        *dataKey;
@property (copy, nonatomic) NSString        *dataValue;

@end
