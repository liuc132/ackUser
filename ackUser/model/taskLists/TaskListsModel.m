//
//  TaskListsModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskListsModel.h"

@implementation TaskListsModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.taskId forKey:@"taskId"];
    [aCoder encodeObject:self.plate forKey:@"plate"];
    [aCoder encodeObject:self.taskStatus forKey:@"taskStatus"];
    [aCoder encodeObject:self.taskStatusValue forKey:@"taskStatusValue"];
    [aCoder encodeObject:self.storeStatus forKey:@"storeStatus"];
    [aCoder encodeObject:self.storeValue forKey:@"storeValue"];
    [aCoder encodeObject:self.taskEndTime forKey:@"taskEndTime"];
    [aCoder encodeObject:self.advName forKey:@"advName"];
    [aCoder encodeObject:self.advDesc forKey:@"advDesc"];
    [aCoder encodeObject:self.advPrice forKey:@"advPrice"];
    [aCoder encodeObject:self.installTime forKey:@"installTime"];
    [aCoder encodeObject:self.installTimes forKey:@"installTimes"];
    [aCoder encodeObject:self.checkTime forKey:@"checkTime"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.advImg forKey:@"advImg"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.taskId = [aDecoder decodeObjectForKey:@"taskId"];
        self.plate = [aDecoder decodeObjectForKey:@"plate"];
        self.taskStatus = [aDecoder decodeObjectForKey:@"taskStatus"];
        self.taskStatusValue = [aDecoder decodeObjectForKey:@"taskStatusValue"];
        self.storeStatus = [aDecoder decodeObjectForKey:@"storeStatus"];
        self.storeValue = [aDecoder decodeObjectForKey:@"storeValue"];
        self.taskEndTime = [aDecoder decodeObjectForKey:@"taskEndTime"];
        self.advName = [aDecoder decodeObjectForKey:@"advName"];
        self.advDesc = [aDecoder decodeObjectForKey:@"advDesc"];
        self.advPrice = [aDecoder decodeObjectForKey:@"advPrice"];
        self.installTime = [aDecoder decodeObjectForKey:@"installTime"];
        self.installTimes = [aDecoder decodeObjectForKey:@"installTimes"];
        self.checkTime = [aDecoder decodeObjectForKey:@"checkTime"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.advImg = [aDecoder decodeObjectForKey:@"advImg"];
    }
    return self;
}

@end
