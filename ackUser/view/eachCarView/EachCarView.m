//
//  EachCarView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "EachCarView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation EachCarView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *iconPlateNumberImageView = [UIImageView new];
    iconPlateNumberImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconPlateNumberImageView.image = [UIImage imageNamed:@"icon_carPlateNumber"];
    [self addSubview:iconPlateNumberImageView];
    [iconPlateNumberImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _carPlateNumberLabel = [UILabel new];
    _carPlateNumberLabel.text = @"渝B88955";
    _carPlateNumberLabel.textColor = [UIColor colorFromHexString:@"#7c817f" alpha:1.0];
    [self addSubview:_carPlateNumberLabel];
    [_carPlateNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconPlateNumberImageView.right).offset(5);
        make.top.equalTo(self.top).offset(5);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    _carPriceLabel = [UILabel new];
    _carPriceLabel.textColor = [UIColor colorFromHexString:@"#7c817f" alpha:1.0];
    _carPriceLabel.text = @"8-15万";
    [self addSubview:_carPriceLabel];
    [_carPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIImageView *carPriceImageView = [UIImageView new];
    carPriceImageView.contentMode = UIViewContentModeScaleAspectFill;
    carPriceImageView.image = [UIImage imageNamed:@"icon_carPrice"];
    [self addSubview:carPriceImageView];
    [carPriceImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.right.equalTo(_carPriceLabel.left).offset(-5);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _carBrandLabel = [UILabel new];
    _carBrandLabel.textColor = [UIColor colorFromHexString:@"#7c817f" alpha:1.0];
    _carBrandLabel.textAlignment = NSTextAlignmentRight;
    _carBrandLabel.text = @"一汽大众";
    [self addSubview:_carBrandLabel];
    [_carBrandLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(carPriceImageView.left).offset(-10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    UIImageView *carBrandImageView = [UIImageView new];
    carBrandImageView.contentMode = UIViewContentModeScaleAspectFill;
    carBrandImageView.image = [UIImage imageNamed:@"icon_carBrand"];
    [self addSubview:carBrandImageView];
    [carBrandImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.right.equalTo(_carBrandLabel.left).offset(-5);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _carBodyImageView = [UIImageView new];
    _carBodyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _carBodyImageView.image = [UIImage imageNamed:@"icon_carBody_sample1"];
    [self addSubview:_carBodyImageView];
    [_carBodyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconPlateNumberImageView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.bottom.equalTo(self.bottom).offset(-10);
    }];
    
    _carStatusLabel = [UILabel new];
    _carStatusLabel.layer.cornerRadius = 10.0;
    _carStatusLabel.layer.masksToBounds = YES;
    _carStatusLabel.textAlignment = NSTextAlignmentCenter;
    _carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    _carStatusLabel.textColor = [UIColor whiteColor];
    _carStatusLabel.text = @"待审核";
    [_carBodyImageView addSubview:_carStatusLabel];
    [_carStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_carBodyImageView.right);
        make.bottom.equalTo(_carBodyImageView.bottom).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    
    return self;
}


@end
