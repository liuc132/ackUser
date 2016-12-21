//
//  CarInformationModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CarInformationModel.h"

@implementation CarInformationModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.iD forKey:@"iD"];
    [aCoder encodeObject:self.ownerId forKey:@"ownerId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.plate forKey:@"plate"];
    [aCoder encodeObject:self.brand forKey:@"brand"];
    [aCoder encodeObject:self.colorCd forKey:@"colorCd"];
    [aCoder encodeObject:self.colorName forKey:@"colorName"];
    [aCoder encodeObject:self.priceCd forKey:@"priceCd"];
    [aCoder encodeObject:self.priceName forKey:@"priceName"];
    [aCoder encodeObject:self.issuetime forKey:@"issuetime"];
    [aCoder encodeObject:self.latetime forKey:@"latetime"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.series forKey:@"series"];
    [aCoder encodeObject:self.typeCd forKey:@"typeCd"];
    [aCoder encodeObject:self.typeName forKey:@"typeName"];
    [aCoder encodeObject:self.isreport forKey:@"isreport"];
    [aCoder encodeObject:self.travelpic forKey:@"travelpic"];
    [aCoder encodeObject:self.positivepic forKey:@"positivepic"];
    [aCoder encodeObject:self.ventripic forKey:@"ventripic"];
    [aCoder encodeObject:self.brandImgUrl forKey:@"brandImgUrl"];
    [aCoder encodeObject:self.creTime forKey:@"creTime"];
    [aCoder encodeObject:self.lastUpdateTime forKey:@"lastUpdateTime"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.iD = [aDecoder decodeObjectForKey:@"adId"];
        self.ownerId = [aDecoder decodeObjectForKey:@"advname"];
        self.name = [aDecoder decodeObjectForKey:@"price"];
        self.plate = [aDecoder decodeObjectForKey:@"recruitcarssurplus"];
        self.brand = [aDecoder decodeObjectForKey:@"img1url"];
        self.colorCd = [aDecoder decodeObjectForKey:@"srecruitTimeToLong"];
        self.colorName = [aDecoder decodeObjectForKey:@"status"];
        self.priceCd = [aDecoder decodeObjectForKey:@"cycle"];
        self.priceName = [aDecoder decodeObjectForKey:@"adId"];
        self.issuetime = [aDecoder decodeObjectForKey:@"advname"];
        self.latetime = [aDecoder decodeObjectForKey:@"price"];
        self.status = [aDecoder decodeObjectForKey:@"recruitcarssurplus"];
        self.series = [aDecoder decodeObjectForKey:@"img1url"];
        self.typeCd = [aDecoder decodeObjectForKey:@"srecruitTimeToLong"];
        self.typeName = [aDecoder decodeObjectForKey:@"status"];
        self.isreport = [aDecoder decodeObjectForKey:@"cycle"];
        self.travelpic = [aDecoder decodeObjectForKey:@"adId"];
        self.positivepic = [aDecoder decodeObjectForKey:@"advname"];
        self.ventripic = [aDecoder decodeObjectForKey:@"price"];
        self.brandImgUrl = [aDecoder decodeObjectForKey:@"recruitcarssurplus"];
        self.creTime = [aDecoder decodeObjectForKey:@"img1url"];
        self.lastUpdateTime = [aDecoder decodeObjectForKey:@"srecruitTimeToLong"];
        
    }
    return self;
}

@end
