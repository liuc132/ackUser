//
//  SecurityQuestionModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SecurityQuestionModel.h"

@implementation SecurityQuestionModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.questionId forKey:@"questionId"];
    [aCoder encodeObject:self.parentId forKey:@"parentId"];
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.value forKey:@"value"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.sortNo forKey:@"sortNo"];
    [aCoder encodeObject:self.questionDescription forKey:@"questionDescription"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.subList forKey:@"subList"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.questionId = [aDecoder decodeObjectForKey:@"questionId"];
        self.parentId = [aDecoder decodeObjectForKey:@"parentId"];
        self.key = [aDecoder decodeObjectForKey:@"key"];
        self.value = [aDecoder decodeObjectForKey:@"value"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.sortNo = [aDecoder decodeObjectForKey:@"sortNo"];
        self.questionDescription = [aDecoder decodeObjectForKey:@"questionDescription"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.subList = [aDecoder decodeObjectForKey:@"subList"];
    }
    return self;
}


@end
