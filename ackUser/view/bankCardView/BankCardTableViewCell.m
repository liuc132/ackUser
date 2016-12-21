//
//  BankCardTableViewCell.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/22.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "BankCardTableViewCell.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@implementation BankCardTableViewCell

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _bankLogoImageView = [UIImageView new];
    _bankLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bankLogoImageView.image = [UIImage imageNamed:@"setting_feedBack_ack"];
    [self addSubview:_bankLogoImageView];
    [_bankLogoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    _bankNameLabel = [UILabel new];
    _bankNameLabel.text = @"工商银行";
    _bankNameLabel.textColor = [UIColor whiteColor];
    [_bankNameLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:_bankNameLabel];
    [_bankNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.left.equalTo(_bankLogoImageView.right).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _bankCardTypeLabel = [UILabel new];
    _bankCardTypeLabel.text = @"储蓄卡";
    _bankCardTypeLabel.font = [UIFont systemFontOfSize:13];
    _bankCardTypeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_bankCardTypeLabel];
    [_bankCardTypeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankNameLabel.bottom).offset(10);
        make.left.equalTo(_bankLogoImageView.right).offset(5);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];
    
    UIView *verticalSeparetedView = [UIView new];
    verticalSeparetedView.backgroundColor = [UIColor whiteColor];
    [self addSubview:verticalSeparetedView];
    [verticalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankCardTypeLabel.right).offset(5);
        make.top.equalTo(_bankNameLabel.bottom).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@20);
    }];
    
    _bankLastFourNumberLabel = [UILabel new];
    _bankLastFourNumberLabel.font = [UIFont systemFontOfSize:13];
    _bankLastFourNumberLabel.text = @"尾号6253";
    _bankLastFourNumberLabel.textColor = [UIColor whiteColor];
    [self addSubview:_bankLastFourNumberLabel];
    [_bankLastFourNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankNameLabel.bottom).offset(10);
        make.left.equalTo(verticalSeparetedView.right).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    
    return self;
}








@end
