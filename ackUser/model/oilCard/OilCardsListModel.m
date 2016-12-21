//
//  OilCardsListModel.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "OilCardsListModel.h"

@implementation OilCardsListModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.oilCardId forKey:@"id"];
    [aCoder encodeObject:self.backimgurl forKey:@"backimgurl"];
    [aCoder encodeObject:self.bindStatus forKey:@"bindStatus"];
    [aCoder encodeObject:self.cardNumber forKey:@"cardNumber"];
    [aCoder encodeObject:self.custel forKey:@"custel"];
    [aCoder encodeObject:self.hotlinename forKey:@"hotlinename"];
    [aCoder encodeObject:self.imgurl forKey:@"imgurl"];
    [aCoder encodeObject:self.issettradpwd forKey:@"issettradpwd"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.ownerId forKey:@"ownerId"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.oilCardId = [aDecoder decodeObjectForKey:@"id"];
        self.backimgurl = [aDecoder decodeObjectForKey:@"backimgurl"];
        self.bindStatus = [aDecoder decodeObjectForKey:@"bindStatus"];
        self.cardNumber = [aDecoder decodeObjectForKey:@"cardNumber"];
        self.custel = [aDecoder decodeObjectForKey:@"custel"];
        self.hotlinename = [aDecoder decodeObjectForKey:@"hotlinename"];
        self.imgurl = [aDecoder decodeObjectForKey:@"imgurl"];
        self.issettradpwd = [aDecoder decodeObjectForKey:@"issettradpwd"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.ownerId = [aDecoder decodeObjectForKey:@"ownerId"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
    }
    return self;
}

@end
