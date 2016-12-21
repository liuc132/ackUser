//
//  PetroleumCardVerityView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/30.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "PetroleumCardVerityView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation PetroleumCardVerityView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UILabel *phonhNumberLabel = [UILabel new];
    phonhNumberLabel.textAlignment = NSTextAlignmentLeft;
    phonhNumberLabel.text = @"手机号码";
    [self addSubview:phonhNumberLabel];
    [phonhNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _petroleumPhoneNumberTextField = [UITextField new];
    _petroleumPhoneNumberTextField.placeholder = @"请输入您的手机号";
    [self addSubview:_petroleumPhoneNumberTextField];
    [_petroleumPhoneNumberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phonhNumberLabel.right).offset(5);
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(self.top).offset(20);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView = [UIView new];
    horizonalSeparetedView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:horizonalSeparetedView];
    [horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(phonhNumberLabel.bottom).offset(20);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    UILabel *petroleumCardLabel = [UILabel new];
    petroleumCardLabel.textAlignment = NSTextAlignmentLeft;
    petroleumCardLabel.text = @"油卡卡号";
    [self addSubview:petroleumCardLabel];
    [petroleumCardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView.bottom).offset(20);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _petroleumPhoneNumberTextField = [UITextField new];
    _petroleumPhoneNumberTextField.placeholder = @"请输入您的手机号";
    [self addSubview:_petroleumPhoneNumberTextField];
    [_petroleumPhoneNumberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(petroleumCardLabel.right).offset(5);
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(horizonalSeparetedView.bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(petroleumCardLabel.bottom).offset(20);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _confirmChargePetroleumButton = [UIButton new];
    _confirmChargePetroleumButton.layer.cornerRadius = 4.0;
    _confirmChargePetroleumButton.layer.masksToBounds = YES;
    [_confirmChargePetroleumButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    _confirmChargePetroleumButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [_confirmChargePetroleumButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmChargePetroleumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmChargePetroleumButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_confirmChargePetroleumButton];
    [_confirmChargePetroleumButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    
    
    
    return self;
}

@end
