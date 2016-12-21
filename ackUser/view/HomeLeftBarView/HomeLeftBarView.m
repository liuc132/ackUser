//
//  HomeLeftBarView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeLeftBarView.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@implementation HomeLeftBarView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *companyLogoImageView = [UIImageView new];
    companyLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
    companyLogoImageView.image = [UIImage imageNamed:@"icon_homeLogo"];
    [self addSubview:companyLogoImageView];
    [companyLogoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.left);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];
    
    UIView *verticalSeparetedView = [UIView new];
    verticalSeparetedView.backgroundColor = [UIColor whiteColor];
    [self addSubview:verticalSeparetedView];
    [verticalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(companyLogoImageView.right).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@20);
    }];
    
    _locationLabel = [UILabel new];
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.font = [UIFont systemFontOfSize:13];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSString *locationString = @"重庆市";
    CGSize textSize = [locationString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _locationLabel.text = locationString;
    [self addSubview:_locationLabel];
    [_locationLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView.right).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(textSize.width+10));
        make.height.equalTo(@20);
    }];
    
    
    
    
    
    return self;
}


@end
