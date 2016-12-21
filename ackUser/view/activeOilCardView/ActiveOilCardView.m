//
//  ActiveOilCardView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ActiveOilCardView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation ActiveOilCardView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UILabel *oilCardNumberLabel = [UILabel new];
    oilCardNumberLabel.text = @"油卡卡号";
    oilCardNumberLabel.textAlignment = NSTextAlignmentLeft;
//    oilCardNumberLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self addSubview:oilCardNumberLabel];
    [oilCardNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(30);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _oilCardTextField = [UITextField new];
    _oilCardTextField.userInteractionEnabled = YES;
    _oilCardTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _oilCardTextField.placeholder = @"请输入您的油卡卡号";
    [_oilCardTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _oilCardTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:_oilCardTextField];
    [_oilCardTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oilCardNumberLabel.right).offset(5);
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.top).offset(30);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(oilCardNumberLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    _oilCardActiveButton = [UIButton new];
    _oilCardActiveButton.userInteractionEnabled = YES;
    _oilCardActiveButton.layer.cornerRadius = 4.0;
    _oilCardActiveButton.layer.masksToBounds = YES;
    _oilCardActiveButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [_oilCardActiveButton setTitle:@"激活" forState:UIControlStateNormal];
    [_oilCardActiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_oilCardActiveButton];
    [_oilCardActiveButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    return self;
}

@end
