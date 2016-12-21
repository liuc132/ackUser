//
//  GetTaskListsModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "GetTaskListsModel.h"

@implementation GetTaskListsModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.adId forKey:@"adId"];
    [aCoder encodeObject:self.advname forKey:@"advname"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.recruitcarssurplus forKey:@"recruitcarssurplus"];
    [aCoder encodeObject:self.img1url forKey:@"img1url"];
    [aCoder encodeObject:self.srecruitTimeToLong forKey:@"srecruitTimeToLong"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.cycle forKey:@"cycle"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.adId = [aDecoder decodeObjectForKey:@"adId"];
        self.advname = [aDecoder decodeObjectForKey:@"advname"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.recruitcarssurplus = [aDecoder decodeObjectForKey:@"recruitcarssurplus"];
        self.img1url = [aDecoder decodeObjectForKey:@"img1url"];
        self.srecruitTimeToLong = [aDecoder decodeObjectForKey:@"srecruitTimeToLong"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.cycle = [aDecoder decodeObjectForKey:@"cycle"];
    }
    return self;
}


@end
