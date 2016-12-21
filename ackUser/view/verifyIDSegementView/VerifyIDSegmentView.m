//
//  VerifyIDSegmentView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/30.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "VerifyIDSegmentView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation VerifyIDSegmentView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _petroleumCardContentView = [UIView new];
    _petroleumCardContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_petroleumCardContentView];
    [_petroleumCardContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.width.equalTo(@(SCREEN_WIDTH/2 - 1));
        make.height.equalTo(@30);
    }];
    
    _petroleumCardImageView = [UIImageView new];
    _petroleumCardImageView.image = [UIImage imageNamed:@"icon_petroleumCard"];
    _petroleumCardImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_petroleumCardContentView addSubview:_petroleumCardImageView];
    [_petroleumCardImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_petroleumCardContentView.left).offset(25);
        make.top.equalTo(_petroleumCardContentView.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _petroleumCardLabel = [UILabel new];
    _petroleumCardLabel.font = [UIFont systemFontOfSize:15];
    _petroleumCardLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    _petroleumCardLabel.textAlignment = NSTextAlignmentCenter;
    _petroleumCardLabel.text = @"油卡卡号";
    [_petroleumCardContentView addSubview:_petroleumCardLabel];
    [_petroleumCardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_petroleumCardImageView.right).offset(4);
        make.top.equalTo(_petroleumCardContentView.top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    UIView *betweenCoinAndAccountLeftView = [UIView new];
    betweenCoinAndAccountLeftView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:betweenCoinAndAccountLeftView];
    [betweenCoinAndAccountLeftView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(5);
        make.width.equalTo(@1);
        make.height.equalTo(@30);
    }];
    
    _securityQuestionView = [UIView new];
    _securityQuestionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_securityQuestionView];
    [_securityQuestionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.right.equalTo(self.right);
        make.width.equalTo(@(SCREEN_WIDTH/2 - 1));
        make.height.equalTo(@30);
    }];
    
    _securityQuestionImageView = [UIImageView new];
    _securityQuestionImageView.image = [UIImage imageNamed:@"icon_securityQuestion"];
    _securityQuestionImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_securityQuestionView addSubview:_securityQuestionImageView];
    [_securityQuestionImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_securityQuestionView.left).offset(20);
        make.top.equalTo(_securityQuestionView.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _securityQuestionLabel = [UILabel new];
    _securityQuestionLabel.font = [UIFont systemFontOfSize:15];
    _securityQuestionLabel.textColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0];
    _securityQuestionLabel.textAlignment = NSTextAlignmentCenter;
    _securityQuestionLabel.text = @"密保问题";
    [_securityQuestionView addSubview:_securityQuestionLabel];
    [_securityQuestionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_securityQuestionImageView.right).offset(4);
        make.top.equalTo(_securityQuestionView.top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _horizonalSeparetedView = [UIView new];
    _horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    [self addSubview:_horizonalSeparetedView];
    [_horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_securityQuestionLabel.left);
        make.top.equalTo(_petroleumCardContentView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH/10));
        make.height.equalTo(@1);
    }];
    
    UIImage *petroleumCardImage = [UIImage imageNamed:@"icon_petroleumCard"];
    //[UIColor colorFromHexString:@"#ffa122" alpha:1.0]
    _petroleumCardImageView.image = [petroleumCardImage imageWithColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
    _petroleumCardLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    
    UIImage *securityQuestionImage = [UIImage imageNamed:@"icon_securityQuestion"];
    _securityQuestionImageView.image = [securityQuestionImage imageWithColor:[UIColor colorFromHexString:@"#7e8384" alpha:1.0]];
    
    _horizonalSeparetedView0 = [UIView new];
    _horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [self addSubview:_horizonalSeparetedView0];
    [_horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_petroleumCardLabel.left);
        make.top.equalTo(_petroleumCardContentView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH/10));
        make.height.equalTo(@1);
    }];
    
    _horizonalSeparetedView1 = [UIView new];
    _horizonalSeparetedView1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:_horizonalSeparetedView1];
    [_horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_horizonalSeparetedView.bottom);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    return self;
}




@end
