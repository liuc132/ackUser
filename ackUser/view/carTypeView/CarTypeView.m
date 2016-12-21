//
//  CarTypeView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CarTypeView.h"
#import "UIColor+HexColor.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@implementation CarTypeView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _normalCarView = [UIView new];
    _normalCarView.tag = NormalCarViewTag;
    [self addSubview:_normalCarView];
    [_normalCarView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@40);
    }];
    
    _normalCarLabel = [UILabel new];
    _normalCarLabel.text = @"轿车";
    _normalCarLabel.textAlignment = NSTextAlignmentLeft;
    _normalCarLabel.textColor = [UIColor colorFromHexString:@"#ffa437" alpha:1.0];
    [_normalCarView addSubview:_normalCarLabel];
    [_normalCarLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_normalCarView.left).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _normalCarImageView = [UIImageView new];
    _normalCarImageView.contentMode = UIViewContentModeCenter;
    _normalCarImageView.image = [UIImage imageNamed:@"icon_selected"];
    [_normalCarView addSubview:_normalCarImageView];
    [_normalCarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_normalCarView.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(_normalCarView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    //
    _offRoadVehicleView = [UIView new];
    _offRoadVehicleView.tag = OffRoadVehicleViewTag;
    [self addSubview:_offRoadVehicleView];
    [_offRoadVehicleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@40);
    }];
    
    _offRoadVehicleLabel = [UILabel new];
    _offRoadVehicleLabel.text = @"越野车";
    _offRoadVehicleLabel.textAlignment = NSTextAlignmentLeft;
    _offRoadVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    [_offRoadVehicleView addSubview:_offRoadVehicleLabel];
    [_offRoadVehicleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_offRoadVehicleView.left).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _offRoadVehicleImageView = [UIImageView new];
    _offRoadVehicleImageView.contentMode = UIViewContentModeCenter;
    _offRoadVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    [_offRoadVehicleView addSubview:_offRoadVehicleImageView];
    [_offRoadVehicleImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_offRoadVehicleView.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(_offRoadVehicleView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    //
    _carSUVVehicleView = [UIView new];
    _carSUVVehicleView.tag = CarSUVViewTag;
    [self addSubview:_carSUVVehicleView];
    [_carSUVVehicleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@40);
    }];
    
    _carSUVVehicleLabel = [UILabel new];
    _carSUVVehicleLabel.text = @"SUV";
    _carSUVVehicleLabel.textAlignment = NSTextAlignmentLeft;
    _carSUVVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    [_carSUVVehicleView addSubview:_carSUVVehicleLabel];
    [_carSUVVehicleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_carSUVVehicleView.left).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _carSUVVehicleImageView = [UIImageView new];
    _carSUVVehicleImageView.contentMode = UIViewContentModeCenter;
    _carSUVVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    [_carSUVVehicleView addSubview:_carSUVVehicleImageView];
    [_carSUVVehicleImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_carSUVVehicleView.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView2 = [UIView new];
    separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView2];
    [separetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(_carSUVVehicleView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    //
    _businessVehicleView = [UIView new];
    _businessVehicleView.tag = BusinessVehicleTag;
    [self addSubview:_businessVehicleView];
    [_businessVehicleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@40);
    }];
    
    _businessVehicleLabel = [UILabel new];
    _businessVehicleLabel.text = @"商务车";
    _businessVehicleLabel.textAlignment = NSTextAlignmentLeft;
    _businessVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    [_businessVehicleView addSubview:_businessVehicleLabel];
    [_businessVehicleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_businessVehicleView.left).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _businessVehicleImageView = [UIImageView new];
    _businessVehicleImageView.contentMode = UIViewContentModeCenter;
    _businessVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    [_businessVehicleView addSubview:_businessVehicleImageView];
    [_businessVehicleImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_businessVehicleView.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView3 = [UIView new];
    separetedView3.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView3];
    [separetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(_businessVehicleView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    
    
    return self;
}


/**
 dismiss the CarTypeView
 */
- (void)dismissCarTypeViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
    
}

/**
 show the CarTypeView
 */
- (void)showCarTypeView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
    
}


@end
