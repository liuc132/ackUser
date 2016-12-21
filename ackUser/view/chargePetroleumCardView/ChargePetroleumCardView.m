//
//  ChargePetroleumCardView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/30.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ChargePetroleumCardView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation ChargePetroleumCardView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIView *coinInputView = [UIView new];
    coinInputView.layer.cornerRadius = 4.0;
    coinInputView.layer.masksToBounds = YES;
    coinInputView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    [self addSubview:coinInputView];
    [coinInputView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    UILabel *coinCountNoteLabel = [UILabel new];
    coinCountNoteLabel.layer.cornerRadius = 4.0;
    coinCountNoteLabel.layer.masksToBounds = YES;
    coinCountNoteLabel.textAlignment = NSTextAlignmentLeft;
    coinCountNoteLabel.text = @"金额:";
    coinCountNoteLabel.font = [UIFont systemFontOfSize:14];
    coinCountNoteLabel.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
//    coinCountNoteLabel.textColor = [UIColor colorFromHexString:@"#e0e0e0" alpha:1.0];
    [coinInputView addSubview:coinCountNoteLabel];
    [coinCountNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(coinInputView.left).offset(10);
        make.centerY.equalTo(@0);
        make.height.equalTo(@30);
        make.width.equalTo(@40);
    }];
    
    _coinCountTextField = [UITextField new];
    _coinCountTextField.layer.cornerRadius = 4.0;
    _coinCountTextField.layer.masksToBounds = YES;
    _coinCountTextField.userInteractionEnabled = YES;
    _coinCountTextField.textAlignment = NSTextAlignmentRight;
    _coinCountTextField.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    _coinCountTextField.placeholder = @"余额为30000爱车币";
    [_coinCountTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _coinCountTextField.borderStyle = UITextBorderStyleNone;
    [coinInputView addSubview:_coinCountTextField];
    [_coinCountTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(coinCountNoteLabel.right).offset(10);
        make.height.equalTo(@30);
        make.centerY.equalTo(@0);
        make.right.equalTo(coinInputView.right).offset(-10);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(_coinCountTextField.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *ackCoinDifferenceLabel = [UILabel new];
    ackCoinDifferenceLabel.numberOfLines = 0;
    ackCoinDifferenceLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinDifferenceLabel.font = [UIFont systemFontOfSize:13];
    ackCoinDifferenceLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    NSString *ackCoinDifferenceString = @"1爱车币=0.01元";
    ackCoinDifferenceLabel.text = ackCoinDifferenceString;
    [self addSubview:ackCoinDifferenceLabel];
    [ackCoinDifferenceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(separetedView.bottom).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    UILabel *ackCoinNoteLabel = [UILabel new];
    ackCoinNoteLabel.numberOfLines = 0;
    ackCoinNoteLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinNoteLabel.font = [UIFont systemFontOfSize:15];
    ackCoinNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    NSString *ackCoinNoteString = @"使用爱车币充值油卡必须为5000的倍数";
    ackCoinNoteLabel.text = ackCoinNoteString;
    [self addSubview:ackCoinNoteLabel];
    [ackCoinNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(ackCoinDifferenceLabel.bottom).equalTo(@5);
        make.width.equalTo(@270);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(ackCoinNoteLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _confrimChargeButton = [UIButton new];
    _confrimChargeButton.layer.cornerRadius = 4.0;
    _confrimChargeButton.layer.masksToBounds = YES;
    [_confrimChargeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    _confrimChargeButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [_confrimChargeButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confrimChargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confrimChargeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_confrimChargeButton];
    [_confrimChargeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    
    
    return self;
}

@end
