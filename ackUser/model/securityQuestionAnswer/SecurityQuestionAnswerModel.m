//
//  SecurityQuestionAnswerModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SecurityQuestionAnswerModel.h"

@implementation SecurityQuestionAnswerModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.questionId forKey:@"questionId"];
    [aCoder encodeObject:self.ownerId forKey:@"ownerId"];
    [aCoder encodeObject:self.sn forKey:@"sn"];
    [aCoder encodeObject:self.questionCd forKey:@"questionCd"];
    [aCoder encodeObject:self.answer forKey:@"answer"];
    [aCoder encodeObject:self.creTime forKey:@"creTime"];
    [aCoder encodeObject:self.lastUpdateTime forKey:@"lastUpdateTime"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.questionId = [aDecoder decodeObjectForKey:@"questionId"];
        self.ownerId = [aDecoder decodeObjectForKey:@"ownerId"];
        self.sn = [aDecoder decodeObjectForKey:@"sn"];
        self.questionCd = [aDecoder decodeObjectForKey:@"questionCd"];
        self.answer = [aDecoder decodeObjectForKey:@"answer"];
        self.creTime = [aDecoder decodeObjectForKey:@"creTime"];
        self.lastUpdateTime = [aDecoder decodeObjectForKey:@"lastUpdateTime"];
    }
    return self;
}


@end
