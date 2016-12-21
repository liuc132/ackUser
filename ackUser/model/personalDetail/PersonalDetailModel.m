//
//  PersonalDetailModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/7.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "PersonalDetailModel.h"

@implementation PersonalDetailModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.wechatId forKey:@"wechatId"];
    [aCoder encodeObject:self.qqId forKey:@"qqId"];
    [aCoder encodeObject:self.microblogId forKey:@"microblogId"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.idno forKey:@"idno"];
    [aCoder encodeObject:self.birthDate forKey:@"birthDate"];
    [aCoder encodeObject:self.marigStatus forKey:@"marigStatus"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.regCity forKey:@"regCity"];
    [aCoder encodeObject:self.workarea forKey:@"workarea"];
    [aCoder encodeObject:self.resiArea forKey:@"resiArea"];
    [aCoder encodeObject:self.invtCode forKey:@"invtCode"];
    [aCoder encodeObject:self.invtCodeRel forKey:@"invtCodeRel"];
    [aCoder encodeObject:self.industryCd forKey:@"industryCd"];
    [aCoder encodeObject:self.occpCd forKey:@"occpCd"];
    [aCoder encodeObject:self.incomeCd forKey:@"incomeCd"];
    [aCoder encodeObject:self.hobbyCd forKey:@"hobbyCd"];
    [aCoder encodeObject:self.carClubsVlue forKey:@"carClubsVlue"];
    [aCoder encodeBool:self.isUpdateResiArea forKey:@"isUpdateResiArea"];
    [aCoder encodeBool:self.isUpdateWorkarea forKey:@"isUpdateWorkarea"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.wechatId = [aDecoder decodeObjectForKey:@"wechatId"];
        self.qqId = [aDecoder decodeObjectForKey:@"qqId"];
        self.microblogId = [aDecoder decodeObjectForKey:@"microblogId"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.idno = [aDecoder decodeObjectForKey:@"idno"];
        self.birthDate = [aDecoder decodeObjectForKey:@"birthDate"];
        self.marigStatus = [aDecoder decodeObjectForKey:@"marigStatus"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.regCity = [aDecoder decodeObjectForKey:@"regCity"];
        self.workarea = [aDecoder decodeObjectForKey:@"workarea"];
        self.resiArea = [aDecoder decodeObjectForKey:@"resiArea"];
        self.invtCode = [aDecoder decodeObjectForKey:@"invtCode"];
        self.invtCodeRel = [aDecoder decodeObjectForKey:@"invtCodeRel"];
        self.industryCd = [aDecoder decodeObjectForKey:@"industryCd"];
        self.occpCd = [aDecoder decodeObjectForKey:@"occpCd"];
        self.incomeCd = [aDecoder decodeObjectForKey:@"incomeCd"];
        self.hobbyCd = [aDecoder decodeObjectForKey:@"hobbyCd"];
        self.carClubsVlue = [aDecoder decodeObjectForKey:@"carClubsVlue"];
        self.isUpdateResiArea = [aDecoder decodeBoolForKey:@"isUpdateResiArea"];
        self.isUpdateWorkarea = [aDecoder decodeBoolForKey:@"isUpdateWorkarea"];
    }
    return self;
}


@end
