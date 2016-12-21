//
//  UserDetailBaseDataModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "UserDetailBaseDataModel.h"

@implementation UserDetailBaseDataModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dataID forKey:@"dataID"];
    [aCoder encodeObject:self.dataKey forKey:@"dataKey"];
    [aCoder encodeObject:self.dataValue forKey:@"dataValue"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.dataID = [aDecoder decodeObjectForKey:@"dataID"];
        self.dataKey = [aDecoder decodeObjectForKey:@"dataKey"];
        self.dataValue = [aDecoder decodeObjectForKey:@"dataValue"];
    }
    return self;
}

@end
