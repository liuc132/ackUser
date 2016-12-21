//
//  MyTaskDetailModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/6.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MyTaskDetailModel.h"

@implementation MyTaskDetailModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.taskId forKey:@"taskId"];
    [aCoder encodeObject:self.plate forKey:@"plate"];
    [aCoder encodeInteger:self.taskStatus forKey:@"taskStatus"];
    [aCoder encodeObject:self.taskStatusValue forKey:@"taskStatusValue"];
    [aCoder encodeObject:self.storeStatus forKey:@"storeStatus"];
    [aCoder encodeInteger:self.storeValue forKey:@"storeValue"];
    [aCoder encodeObject:self.taskEndTime forKey:@"taskEndTime"];
    [aCoder encodeObject:self.advName forKey:@"advName"];
    [aCoder encodeObject:self.advDesc forKey:@"advDesc"];
    [aCoder encodeInteger:self.days forKey:@"days"];
    [aCoder encodeInteger:self.publishDays forKey:@"publishDays"];
    [aCoder encodeObject:self.installTime forKey:@"installTime"];
    [aCoder encodeObject:self.installTimes forKey:@"installTimes"];
    [aCoder encodeObject:self.adverTel forKey:@"adverTel"];
    [aCoder encodeInteger:self.earnMoney forKey:@"earnMoney"];
    [aCoder encodeInteger:self.checkCount forKey:@"checkCount"];
    [aCoder encodeInteger:self.checkedCount forKey:@"checkedCount"];
    [aCoder encodeObject:self.checkTime forKey:@"checkTime"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeDouble:self.longitude forKey:@"longitude"];
    [aCoder encodeDouble:self.latitude forKey:@"latitude"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.taskId = [aDecoder decodeIntegerForKey:@"taskId"];
        self.plate = [aDecoder decodeObjectForKey:@"plate"];
        self.taskStatus = [aDecoder decodeIntegerForKey:@"price"];
        self.taskStatusValue = [aDecoder decodeObjectForKey:@"taskStatusValue"];
        self.storeStatus = [aDecoder decodeObjectForKey:@"storeStatus"];
        self.storeValue = [aDecoder decodeIntegerForKey:@"storeValue"];
        self.taskEndTime = [aDecoder decodeObjectForKey:@"taskEndTime"];
        self.advName = [aDecoder decodeObjectForKey:@"advName"];
        self.advDesc = [aDecoder decodeObjectForKey:@"advDesc"];
        self.days = [aDecoder decodeIntegerForKey:@"days"];
        self.publishDays = [aDecoder decodeIntegerForKey:@"publishDays"];
        self.installTime = [aDecoder decodeObjectForKey:@"installTime"];
        self.installTimes = [aDecoder decodeObjectForKey:@"installTimes"];
        self.adverTel = [aDecoder decodeObjectForKey:@"adverTel"];
        self.earnMoney = [aDecoder decodeIntegerForKey:@"earnMoney"];
        self.checkCount = [aDecoder decodeIntegerForKey:@"checkCount"];
        self.checkedCount = [aDecoder decodeIntegerForKey:@"checkedCount"];
        self.checkTime = [aDecoder decodeObjectForKey:@"checkTime"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.longitude = [aDecoder decodeDoubleForKey:@"longitude"];
        self.latitude = [aDecoder decodeDoubleForKey:@"latitude"];
    }
    return self;
}


@end
